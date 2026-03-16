import 'package:equatable/equatable.dart';

import '../../../data/models/pet_food_model.dart';

abstract class FoodScannerState extends Equatable {
  const FoodScannerState();

  @override
  List<Object?> get props => [];
}

class FoodScannerInitial extends FoodScannerState {
  const FoodScannerInitial();
}

class FoodScannerScanning extends FoodScannerState {
  const FoodScannerScanning();
}

class FoodScannerProcessing extends FoodScannerState {
  const FoodScannerProcessing();
}

class FoodScannerBarcodeFound extends FoodScannerState {
  final String barcode;
  final PetFood? existingFood;

  const FoodScannerBarcodeFound({
    required this.barcode,
    this.existingFood,
  });

  @override
  List<Object?> get props => [barcode, existingFood];
}

class FoodScannerNutritionExtracted extends FoodScannerState {
  final double? kcalPer100g;
  final double? protein;
  final double? fat;
  final double? fiber;
  final String rawText;

  const FoodScannerNutritionExtracted({
    this.kcalPer100g,
    this.protein,
    this.fat,
    this.fiber,
    required this.rawText,
  });

  @override
  List<Object?> get props => [kcalPer100g, protein, fat, fiber, rawText];
}

class FoodScannerFoodSaved extends FoodScannerState {
  final PetFood food;

  const FoodScannerFoodSaved(this.food);

  @override
  List<Object?> get props => [food];
}

class FoodScannerError extends FoodScannerState {
  final String message;

  const FoodScannerError(this.message);

  @override
  List<Object?> get props => [message];
}
