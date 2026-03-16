import 'package:isar/isar.dart';

import '../datasources/database_service.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final DatabaseService _databaseService;

  ActivityRepository(this._databaseService);

  Isar get _isar => _databaseService.isar;

  Future<List<Activity>> getActivitiesForPet(int petId) async {
    return _isar.activitys
        .filter()
        .petIdEqualTo(petId)
        .sortByActivityDateDesc()
        .findAll();
  }

  Future<List<Activity>> getActivitiesForDate(int petId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _isar.activitys
        .filter()
        .petIdEqualTo(petId)
        .activityDateBetween(startOfDay, endOfDay)
        .sortByActivityDateDesc()
        .findAll();
  }

  Future<int> getTotalActivityMinutesForDate(int petId, DateTime date) async {
    final activities = await getActivitiesForDate(petId, date);
    return activities.fold<int>(0, (sum, activity) => sum + activity.durationMinutes);
  }

  Future<int> addActivity(Activity activity) async {
    return _isar.writeTxn(() async {
      return _isar.activitys.put(activity);
    });
  }

  Future<int> updateActivity(Activity activity) async {
    return _isar.writeTxn(() async {
      return _isar.activitys.put(activity);
    });
  }

  Future<bool> deleteActivity(int id) async {
    return _isar.writeTxn(() async {
      return _isar.activitys.delete(id);
    });
  }

  Stream<List<Activity>> watchActivitiesForPet(int petId) {
    return _isar.activitys
        .filter()
        .petIdEqualTo(petId)
        .sortByActivityDateDesc()
        .watch(fireImmediately: true);
  }
}
