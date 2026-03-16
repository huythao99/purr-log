import 'package:isar/isar.dart';

part 'weight_record_model.g.dart';

@collection
class WeightRecord {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  late double weight;

  String? notes;

  @Index()
  late DateTime recordDate;

  late DateTime createdAt;
}
