import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/wellness_calculator.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/activity_repository.dart';
import '../../../data/repositories/health_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository _petRepository;
  final FeedingRepository? _feedingRepository;
  final ActivityRepository? _activityRepository;
  final HealthRepository? _healthRepository;
  StreamSubscription<List<Pet>>? _petsSubscription;

  PetBloc(
    this._petRepository, {
    FeedingRepository? feedingRepository,
    ActivityRepository? activityRepository,
    HealthRepository? healthRepository,
  })  : _feedingRepository = feedingRepository,
        _activityRepository = activityRepository,
        _healthRepository = healthRepository,
        super(const PetInitial()) {
    on<PetLoadAll>(_onLoadAll);
    on<PetLoadOne>(_onLoadOne);
    on<PetAdd>(_onAdd);
    on<PetUpdate>(_onUpdate);
    on<PetDelete>(_onDelete);
    on<PetSubscribe>(_onSubscribe);
  }

  Future<void> _onLoadAll(PetLoadAll event, Emitter<PetState> emit) async {
    emit(const PetLoading());
    try {
      final pets = await _petRepository.getAllPets();
      emit(PetLoaded(pets));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onLoadOne(PetLoadOne event, Emitter<PetState> emit) async {
    emit(const PetLoading());
    try {
      final pet = await _petRepository.getPetById(event.petId);
      if (pet != null) {
        // Calculate wellness score if repositories are available
        final wellnessScore = await _calculateWellnessScore(pet);
        emit(PetDetailLoaded(pet, wellnessScore: wellnessScore));
      } else {
        emit(const PetError('Pet not found'));
      }
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<dynamic> _calculateWellnessScore(Pet pet) async {
    if (_feedingRepository == null ||
        _activityRepository == null ||
        _healthRepository == null) {
      return null;
    }

    try {
      final today = DateTime.now();
      final todayKcal = await _feedingRepository.getTotalKcalForDate(pet.id, today);
      final recommendedKcal = _calculateRecommendedKcal(pet);
      final todayActivityMinutes =
          await _activityRepository.getTotalActivityMinutesForDate(pet.id, today);
      final weightRecords = await _healthRepository.getWeightRecordsForPet(pet.id);

      return WellnessCalculator.calculate(
        pet: pet,
        todayKcal: todayKcal,
        recommendedKcal: recommendedKcal,
        todayActivityMinutes: todayActivityMinutes,
        recentWeightRecords: weightRecords,
      );
    } catch (e) {
      return null;
    }
  }

  double _calculateRecommendedKcal(Pet pet) {
    if (pet.weight == null) return 0;

    final ageMonths = pet.ageInMonths ?? 24;
    double kcalPerKg;

    if (pet.species == PetSpecies.dog) {
      if (ageMonths < 12) {
        kcalPerKg = 50.0;
      } else if (ageMonths < 84) {
        kcalPerKg = 30.0;
      } else {
        kcalPerKg = 25.0;
      }
    } else if (pet.species == PetSpecies.cat) {
      if (ageMonths < 12) {
        kcalPerKg = 60.0;
      } else if (ageMonths < 84) {
        kcalPerKg = 40.0;
      } else {
        kcalPerKg = 35.0;
      }
    } else {
      kcalPerKg = 30.0;
    }

    return pet.weight! * kcalPerKg;
  }

  Future<void> _onAdd(PetAdd event, Emitter<PetState> emit) async {
    try {
      await _petRepository.addPet(event.pet);
      emit(const PetOperationSuccess('Pet added successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onUpdate(PetUpdate event, Emitter<PetState> emit) async {
    try {
      await _petRepository.updatePet(event.pet);
      emit(const PetOperationSuccess('Pet updated successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onDelete(PetDelete event, Emitter<PetState> emit) async {
    try {
      await _petRepository.deletePet(event.petId);
      emit(const PetOperationSuccess('Pet deleted successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onSubscribe(PetSubscribe event, Emitter<PetState> emit) async {
    await _petsSubscription?.cancel();
    _petsSubscription = _petRepository.watchAllPets().listen((pets) {
      add(const PetLoadAll());
    });
  }

  @override
  Future<void> close() {
    _petsSubscription?.cancel();
    return super.close();
  }
}
