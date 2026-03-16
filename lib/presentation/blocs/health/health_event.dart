import 'package:equatable/equatable.dart';

import '../../../data/models/health_record_model.dart';

abstract class HealthEvent extends Equatable {
  const HealthEvent();

  @override
  List<Object?> get props => [];
}

class HealthLoadRecords extends HealthEvent {
  final int petId;

  const HealthLoadRecords(this.petId);

  @override
  List<Object?> get props => [petId];
}

class HealthAddRecord extends HealthEvent {
  final HealthRecord record;

  const HealthAddRecord(this.record);

  @override
  List<Object?> get props => [record];
}

class HealthUpdateRecord extends HealthEvent {
  final HealthRecord record;

  const HealthUpdateRecord(this.record);

  @override
  List<Object?> get props => [record];
}

class HealthDeleteRecord extends HealthEvent {
  final int recordId;

  const HealthDeleteRecord(this.recordId);

  @override
  List<Object?> get props => [recordId];
}
