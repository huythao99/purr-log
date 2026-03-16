import 'package:isar/isar.dart';

import '../datasources/database_service.dart';
import '../models/health_record_model.dart';
import '../models/weight_record_model.dart';

class HealthRepository {
  final DatabaseService _databaseService;

  HealthRepository(this._databaseService);

  Isar get _isar => _databaseService.isar;

  // Health Records
  Future<List<HealthRecord>> getHealthRecordsForPet(int petId) async {
    return _isar.healthRecords
        .filter()
        .petIdEqualTo(petId)
        .sortByRecordDateDesc()
        .findAll();
  }

  Future<List<HealthRecord>> getHealthRecordsByType(
    int petId,
    HealthRecordType type,
  ) async {
    return _isar.healthRecords
        .filter()
        .petIdEqualTo(petId)
        .typeEqualTo(type)
        .sortByRecordDateDesc()
        .findAll();
  }

  Future<List<HealthRecord>> getUpcomingDueRecords() async {
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));

    return _isar.healthRecords
        .filter()
        .nextDueDateIsNotNull()
        .nextDueDateBetween(now, thirtyDaysLater)
        .sortByNextDueDate()
        .findAll();
  }

  Future<int> addHealthRecord(HealthRecord record) async {
    return _isar.writeTxn(() async {
      return _isar.healthRecords.put(record);
    });
  }

  Future<int> updateHealthRecord(HealthRecord record) async {
    return _isar.writeTxn(() async {
      return _isar.healthRecords.put(record);
    });
  }

  Future<bool> deleteHealthRecord(int id) async {
    return _isar.writeTxn(() async {
      return _isar.healthRecords.delete(id);
    });
  }

  Stream<List<HealthRecord>> watchHealthRecordsForPet(int petId) {
    return _isar.healthRecords
        .filter()
        .petIdEqualTo(petId)
        .sortByRecordDateDesc()
        .watch(fireImmediately: true);
  }

  // Weight Records
  Future<List<WeightRecord>> getWeightRecordsForPet(int petId) async {
    return _isar.weightRecords
        .filter()
        .petIdEqualTo(petId)
        .sortByRecordDateDesc()
        .findAll();
  }

  Future<WeightRecord?> getLatestWeightRecord(int petId) async {
    return _isar.weightRecords
        .filter()
        .petIdEqualTo(petId)
        .sortByRecordDateDesc()
        .findFirst();
  }

  Future<int> addWeightRecord(WeightRecord record) async {
    return _isar.writeTxn(() async {
      return _isar.weightRecords.put(record);
    });
  }

  Future<bool> deleteWeightRecord(int id) async {
    return _isar.writeTxn(() async {
      return _isar.weightRecords.delete(id);
    });
  }

  Stream<List<WeightRecord>> watchWeightRecordsForPet(int petId) {
    return _isar.weightRecords
        .filter()
        .petIdEqualTo(petId)
        .sortByRecordDateDesc()
        .watch(fireImmediately: true);
  }
}
