import 'package:equatable/equatable.dart';

import '../../../data/models/feeding_log_model.dart';

abstract class FeedingEvent extends Equatable {
  const FeedingEvent();

  @override
  List<Object?> get props => [];
}

class FeedingLoadLogs extends FeedingEvent {
  final int petId;

  const FeedingLoadLogs(this.petId);

  @override
  List<Object?> get props => [petId];
}

class FeedingAddLog extends FeedingEvent {
  final FeedingLog log;

  const FeedingAddLog(this.log);

  @override
  List<Object?> get props => [log];
}

class FeedingDeleteLog extends FeedingEvent {
  final int logId;

  const FeedingDeleteLog(this.logId);

  @override
  List<Object?> get props => [logId];
}

class FeedingLoadFoods extends FeedingEvent {
  const FeedingLoadFoods();
}
