import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/health_repository.dart';
import '../../../domain/entities/chart_data.dart';
import 'chart_event.dart';
import 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final PetRepository _petRepository;
  final FeedingRepository _feedingRepository;
  final HealthRepository _healthRepository;

  ChartBloc(
    this._petRepository,
    this._feedingRepository,
    this._healthRepository,
  ) : super(const ChartInitial()) {
    on<ChartLoadAll>(_onLoadAll);
    on<ChartLoadWeight>(_onLoadWeight);
    on<ChartLoadFeeding>(_onLoadFeeding);
  }

  Future<void> _onLoadAll(ChartLoadAll event, Emitter<ChartState> emit) async {
    emit(const ChartLoading());
    try {
      final pet = await _petRepository.getPetById(event.petId);
      if (pet == null) {
        emit(const ChartError('Pet not found'));
        return;
      }

      final weightData = await _loadWeightData(event.petId, 30);
      final feedingData = await _loadFeedingData(pet, 7);

      emit(ChartLoaded(
        weightData: weightData,
        feedingData: feedingData,
      ));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  Future<void> _onLoadWeight(ChartLoadWeight event, Emitter<ChartState> emit) async {
    final currentState = state;
    emit(const ChartLoading());
    try {
      final weightData = await _loadWeightData(event.petId, event.days);

      if (currentState is ChartLoaded) {
        emit(ChartLoaded(
          weightData: weightData,
          feedingData: currentState.feedingData,
        ));
      } else {
        emit(ChartLoaded(
          weightData: weightData,
          feedingData: const [],
        ));
      }
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  Future<void> _onLoadFeeding(ChartLoadFeeding event, Emitter<ChartState> emit) async {
    final currentState = state;
    emit(const ChartLoading());
    try {
      final pet = await _petRepository.getPetById(event.petId);
      if (pet == null) {
        emit(const ChartError('Pet not found'));
        return;
      }

      final feedingData = await _loadFeedingData(pet, event.days);

      if (currentState is ChartLoaded) {
        emit(ChartLoaded(
          weightData: currentState.weightData,
          feedingData: feedingData,
        ));
      } else {
        emit(ChartLoaded(
          weightData: const [],
          feedingData: feedingData,
        ));
      }
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  Future<List<WeightChartData>> _loadWeightData(int petId, int days) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day).subtract(Duration(days: days));
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final records = await _healthRepository.getWeightRecordsInRange(petId, start, end);

    return records
        .map((r) => WeightChartData(date: r.recordDate, weight: r.weight))
        .toList();
  }

  Future<List<FeedingChartData>> _loadFeedingData(Pet pet, int days) async {
    final result = <FeedingChartData>[];
    final now = DateTime.now();
    final recommendedKcal = _calculateRecommendedKcal(pet);

    for (int i = days - 1; i >= 0; i--) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final kcal = await _feedingRepository.getTotalKcalForDate(pet.id, date);
      result.add(FeedingChartData(
        date: date,
        totalKcal: kcal,
        recommendedKcal: recommendedKcal,
      ));
    }

    return result;
  }

  double _calculateRecommendedKcal(Pet pet) {
    if (pet.weight == null) return 0;

    final ageMonths = pet.ageInMonths ?? 24;
    String ageCategory;

    if (pet.species == PetSpecies.dog) {
      if (ageMonths < 12) {
        ageCategory = 'dog_puppy';
      } else if (ageMonths < 84) {
        ageCategory = 'dog_adult';
      } else {
        ageCategory = 'dog_senior';
      }
    } else if (pet.species == PetSpecies.cat) {
      if (ageMonths < 12) {
        ageCategory = 'cat_kitten';
      } else if (ageMonths < 84) {
        ageCategory = 'cat_adult';
      } else {
        ageCategory = 'cat_senior';
      }
    } else {
      return pet.weight! * 30;
    }

    final kcalPerKg = AppConstants.dailyKcalPerKg[ageCategory] ?? 30;
    return pet.weight! * kcalPerKg;
  }
}
