import 'package:equatable/equatable.dart';

import '../../../data/models/health_record_model.dart';

abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object?> get props => [];
}

class HealthInitial extends HealthState {
  const HealthInitial();
}

class HealthLoading extends HealthState {
  const HealthLoading();
}

class HealthRecordsLoaded extends HealthState {
  final List<HealthRecord> records;

  const HealthRecordsLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

class HealthRecordLoaded extends HealthState {
  final HealthRecord record;

  const HealthRecordLoaded(this.record);

  @override
  List<Object?> get props => [record];
}

class HealthOperationSuccess extends HealthState {
  final String message;

  const HealthOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class HealthError extends HealthState {
  final String message;

  const HealthError(this.message);

  @override
  List<Object?> get props => [message];
}
