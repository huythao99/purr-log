import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/feeding_repository.dart';
import 'food_scanner_event.dart';
import 'food_scanner_state.dart';

class FoodScannerBloc extends Bloc<FoodScannerEvent, FoodScannerState> {
  final FeedingRepository _feedingRepository;

  FoodScannerBloc(this._feedingRepository) : super(const FoodScannerInitial()) {
    on<FoodScannerReset>(_onReset);
    on<FoodScannerBarcodeScanned>(_onBarcodeScanned);
    on<FoodScannerTextRecognized>(_onTextRecognized);
    on<FoodScannerSaveFood>(_onSaveFood);
  }

  void _onReset(FoodScannerReset event, Emitter<FoodScannerState> emit) {
    emit(const FoodScannerScanning());
  }

  Future<void> _onBarcodeScanned(
    FoodScannerBarcodeScanned event,
    Emitter<FoodScannerState> emit,
  ) async {
    emit(const FoodScannerProcessing());
    try {
      final existingFood = await _feedingRepository.getPetFoodByBarcode(event.barcode);
      emit(FoodScannerBarcodeFound(
        barcode: event.barcode,
        existingFood: existingFood,
      ));
    } catch (e) {
      emit(FoodScannerError(e.toString()));
    }
  }

  Future<void> _onTextRecognized(
    FoodScannerTextRecognized event,
    Emitter<FoodScannerState> emit,
  ) async {
    emit(const FoodScannerProcessing());
    try {
      final nutrition = _parseNutritionFromText(event.recognizedText);
      emit(FoodScannerNutritionExtracted(
        kcalPer100g: nutrition['kcal'],
        protein: nutrition['protein'],
        fat: nutrition['fat'],
        fiber: nutrition['fiber'],
        rawText: event.recognizedText,
      ));
    } catch (e) {
      emit(FoodScannerError(e.toString()));
    }
  }

  Future<void> _onSaveFood(
    FoodScannerSaveFood event,
    Emitter<FoodScannerState> emit,
  ) async {
    try {
      await _feedingRepository.addPetFood(event.food);
      emit(FoodScannerFoodSaved(event.food));
    } catch (e) {
      emit(FoodScannerError(e.toString()));
    }
  }

  Map<String, double?> _parseNutritionFromText(String text) {
    final result = <String, double?>{
      'kcal': null,
      'protein': null,
      'fat': null,
      'fiber': null,
    };

    final lowerText = text.toLowerCase();

    // Parse kcal/calories
    final kcalPatterns = [
      RegExp(r'(\d+(?:\.\d+)?)\s*kcal', caseSensitive: false),
      RegExp(r'calories?\s*[:\-]?\s*(\d+(?:\.\d+)?)', caseSensitive: false),
      RegExp(r'energy\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*kcal', caseSensitive: false),
      RegExp(r'metabolizable energy\s*[:\-]?\s*(\d+(?:\.\d+)?)', caseSensitive: false),
    ];

    for (final pattern in kcalPatterns) {
      final match = pattern.firstMatch(lowerText);
      if (match != null) {
        result['kcal'] = double.tryParse(match.group(1) ?? '');
        break;
      }
    }

    // Parse protein
    final proteinPattern = RegExp(
      r'(?:crude\s+)?protein\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*%?',
      caseSensitive: false,
    );
    final proteinMatch = proteinPattern.firstMatch(lowerText);
    if (proteinMatch != null) {
      result['protein'] = double.tryParse(proteinMatch.group(1) ?? '');
    }

    // Parse fat
    final fatPattern = RegExp(
      r'(?:crude\s+)?fat\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*%?',
      caseSensitive: false,
    );
    final fatMatch = fatPattern.firstMatch(lowerText);
    if (fatMatch != null) {
      result['fat'] = double.tryParse(fatMatch.group(1) ?? '');
    }

    // Parse fiber
    final fiberPattern = RegExp(
      r'(?:crude\s+)?fib(?:er|re)\s*[:\-]?\s*(\d+(?:\.\d+)?)\s*%?',
      caseSensitive: false,
    );
    final fiberMatch = fiberPattern.firstMatch(lowerText);
    if (fiberMatch != null) {
      result['fiber'] = double.tryParse(fiberMatch.group(1) ?? '');
    }

    return result;
  }
}
