import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/health_repository.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthRepository _healthRepository;
  int? _currentPetId;

  HealthBloc(this._healthRepository) : super(const HealthInitial()) {
    on<HealthLoadRecords>(_onLoadRecords);
    on<HealthAddRecord>(_onAddRecord);
    on<HealthUpdateRecord>(_onUpdateRecord);
    on<HealthDeleteRecord>(_onDeleteRecord);
  }

  Future<void> _onLoadRecords(
    HealthLoadRecords event,
    Emitter<HealthState> emit,
  ) async {
    emit(const HealthLoading());
    _currentPetId = event.petId;
    try {
      final records = await _healthRepository.getHealthRecordsForPet(event.petId);
      emit(HealthRecordsLoaded(records));
    } catch (e) {
      emit(HealthError(e.toString()));
    }
  }

  Future<void> _onAddRecord(
    HealthAddRecord event,
    Emitter<HealthState> emit,
  ) async {
    try {
      await _healthRepository.addHealthRecord(event.record);
      emit(const HealthOperationSuccess('Health record added'));
      if (_currentPetId != null) {
        add(HealthLoadRecords(_currentPetId!));
      }
    } catch (e) {
      emit(HealthError(e.toString()));
    }
  }

  Future<void> _onUpdateRecord(
    HealthUpdateRecord event,
    Emitter<HealthState> emit,
  ) async {
    try {
      await _healthRepository.updateHealthRecord(event.record);
      emit(const HealthOperationSuccess('Health record updated'));
      if (_currentPetId != null) {
        add(HealthLoadRecords(_currentPetId!));
      }
    } catch (e) {
      emit(HealthError(e.toString()));
    }
  }

  Future<void> _onDeleteRecord(
    HealthDeleteRecord event,
    Emitter<HealthState> emit,
  ) async {
    try {
      await _healthRepository.deleteHealthRecord(event.recordId);
      emit(const HealthOperationSuccess('Health record deleted'));
      if (_currentPetId != null) {
        add(HealthLoadRecords(_currentPetId!));
      }
    } catch (e) {
      emit(HealthError(e.toString()));
    }
  }
}
