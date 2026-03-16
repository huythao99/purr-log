import 'package:equatable/equatable.dart';

import '../../../data/models/feeding_log_model.dart';
import '../../../data/models/pet_food_model.dart';

abstract class FeedingState extends Equatable {
  const FeedingState();

  @override
  List<Object?> get props => [];
}

class FeedingInitial extends FeedingState {
  const FeedingInitial();
}

class FeedingLoading extends FeedingState {
  const FeedingLoading();
}

class FeedingLogsLoaded extends FeedingState {
  final List<FeedingLog> logs;
  final double todayTotalKcal;

  const FeedingLogsLoaded({
    required this.logs,
    required this.todayTotalKcal,
  });

  @override
  List<Object?> get props => [logs, todayTotalKcal];
}

class FeedingFoodsLoaded extends FeedingState {
  final List<PetFood> foods;

  const FeedingFoodsLoaded(this.foods);

  @override
  List<Object?> get props => [foods];
}

class FeedingOperationSuccess extends FeedingState {
  final String message;

  const FeedingOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class FeedingError extends FeedingState {
  final String message;

  const FeedingError(this.message);

  @override
  List<Object?> get props => [message];
}
