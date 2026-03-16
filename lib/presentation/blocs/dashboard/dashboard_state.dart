import 'package:equatable/equatable.dart';

import '../../../data/models/pet_model.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/models/feeding_log_model.dart';

class DashboardData {
  final List<Pet> pets;
  final List<Reminder> upcomingReminders;
  final Map<int, double> todayKcalByPet;
  final Map<int, double> recommendedKcalByPet;

  const DashboardData({
    required this.pets,
    required this.upcomingReminders,
    required this.todayKcalByPet,
    required this.recommendedKcalByPet,
  });
}

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardData data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
