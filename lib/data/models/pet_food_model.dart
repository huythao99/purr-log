import 'package:isar/isar.dart';

part 'pet_food_model.g.dart';

@collection
class PetFood {
  Id id = Isar.autoIncrement;

  late String name;

  String? brand;

  @Index()
  String? barcode;

  late double kcalPer100g;

  double? proteinPercent;

  double? fatPercent;

  double? fiberPercent;

  String? photoPath;

  String? notes;

  late DateTime createdAt;

  double calculateKcal(double grams) {
    return (kcalPer100g / 100) * grams;
  }
}
