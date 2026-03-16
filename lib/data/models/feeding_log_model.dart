import 'package:isar/isar.dart';

part 'feeding_log_model.g.dart';

@collection
class FeedingLog {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  int? petFoodId;

  String? foodName;

  late double portionGrams;

  late double totalKcal;

  @Index()
  late DateTime feedingTime;

  String? notes;

  late DateTime createdAt;
}
