import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/reminder_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final PetRepository _petRepository;
  final FeedingRepository _feedingRepository;
  final ReminderRepository _reminderRepository;

  DashboardBloc(
    this._petRepository,
    this._feedingRepository,
    this._reminderRepository,
  ) : super(const DashboardInitial()) {
    on<DashboardLoad>(_onLoad);
    on<DashboardRefresh>(_onRefresh);
  }

  Future<void> _onLoad(DashboardLoad event, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());
    await _loadData(emit);
  }

  Future<void> _onRefresh(DashboardRefresh event, Emitter<DashboardState> emit) async {
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<DashboardState> emit) async {
    try {
      final pets = await _petRepository.getAllPets();
      final upcomingReminders = await _reminderRepository.getUpcomingReminders(days: 7);

      final today = DateTime.now();
      final todayKcalByPet = <int, double>{};
      final recommendedKcalByPet = <int, double>{};

      for (final pet in pets) {
        final todayKcal = await _feedingRepository.getTotalKcalForDate(pet.id, today);
        todayKcalByPet[pet.id] = todayKcal;

        final recommendedKcal = _calculateRecommendedKcal(pet);
        recommendedKcalByPet[pet.id] = recommendedKcal;
      }

      emit(DashboardLoaded(DashboardData(
        pets: pets,
        upcomingReminders: upcomingReminders,
        todayKcalByPet: todayKcalByPet,
        recommendedKcalByPet: recommendedKcalByPet,
      )));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
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
