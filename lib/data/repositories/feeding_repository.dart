import 'package:isar/isar.dart';

import '../datasources/database_service.dart';
import '../models/feeding_log_model.dart';
import '../models/pet_food_model.dart';

class FeedingRepository {
  final DatabaseService _databaseService;

  FeedingRepository(this._databaseService);

  Isar get _isar => _databaseService.isar;

  // Feeding Logs
  Future<List<FeedingLog>> getFeedingLogsForPet(int petId) async {
    return _isar.feedingLogs
        .filter()
        .petIdEqualTo(petId)
        .sortByFeedingTimeDesc()
        .findAll();
  }

  Future<List<FeedingLog>> getFeedingLogsForDate(int petId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _isar.feedingLogs
        .filter()
        .petIdEqualTo(petId)
        .feedingTimeBetween(startOfDay, endOfDay)
        .sortByFeedingTimeDesc()
        .findAll();
  }

  Future<double> getTotalKcalForDate(int petId, DateTime date) async {
    final logs = await getFeedingLogsForDate(petId, date);
    return logs.fold<double>(0.0, (sum, log) => sum + log.totalKcal);
  }

  Future<int> addFeedingLog(FeedingLog log) async {
    return _isar.writeTxn(() async {
      return _isar.feedingLogs.put(log);
    });
  }

  Future<bool> deleteFeedingLog(int id) async {
    return _isar.writeTxn(() async {
      return _isar.feedingLogs.delete(id);
    });
  }

  Stream<List<FeedingLog>> watchFeedingLogsForPet(int petId) {
    return _isar.feedingLogs
        .filter()
        .petIdEqualTo(petId)
        .sortByFeedingTimeDesc()
        .watch(fireImmediately: true);
  }

  // Pet Foods
  Future<List<PetFood>> getAllPetFoods() async {
    return _isar.petFoods.where().sortByName().findAll();
  }

  Future<PetFood?> getPetFoodById(int id) async {
    return _isar.petFoods.get(id);
  }

  Future<PetFood?> getPetFoodByBarcode(String barcode) async {
    return _isar.petFoods.filter().barcodeEqualTo(barcode).findFirst();
  }

  Future<int> addPetFood(PetFood food) async {
    return _isar.writeTxn(() async {
      return _isar.petFoods.put(food);
    });
  }

  Future<int> updatePetFood(PetFood food) async {
    return _isar.writeTxn(() async {
      return _isar.petFoods.put(food);
    });
  }

  Future<bool> deletePetFood(int id) async {
    return _isar.writeTxn(() async {
      return _isar.petFoods.delete(id);
    });
  }

  Stream<List<PetFood>> watchAllPetFoods() {
    return _isar.petFoods.where().sortByName().watch(fireImmediately: true);
  }

  Future<List<PetFood>> searchPetFoods(String query) async {
    return _isar.petFoods
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .brandContains(query, caseSensitive: false)
        .findAll();
  }
}
