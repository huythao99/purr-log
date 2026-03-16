import 'package:isar/isar.dart';

part 'pet_model.g.dart';

@collection
class Pet {
  Id id = Isar.autoIncrement;

  late String name;

  @enumerated
  late PetSpecies species;

  String? breed;

  DateTime? dateOfBirth;

  double? weight;

  String? photoPath;

  late DateTime createdAt;

  late DateTime updatedAt;

  int? get ageInMonths {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    return (now.year - dateOfBirth!.year) * 12 +
        (now.month - dateOfBirth!.month);
  }

  String? get ageDisplay {
    final months = ageInMonths;
    if (months == null) return null;
    if (months < 12) {
      return '$months month${months == 1 ? '' : 's'}';
    }
    final years = months ~/ 12;
    final remainingMonths = months % 12;
    if (remainingMonths == 0) {
      return '$years year${years == 1 ? '' : 's'}';
    }
    return '$years year${years == 1 ? '' : 's'}, $remainingMonths month${remainingMonths == 1 ? '' : 's'}';
  }
}

enum PetSpecies {
  dog,
  cat,
  bird,
  fish,
  rabbit,
  hamster,
  guineaPig,
  turtle,
  snake,
  other,
}

extension PetSpeciesExtension on PetSpecies {
  String get displayName {
    switch (this) {
      case PetSpecies.dog:
        return 'Dog';
      case PetSpecies.cat:
        return 'Cat';
      case PetSpecies.bird:
        return 'Bird';
      case PetSpecies.fish:
        return 'Fish';
      case PetSpecies.rabbit:
        return 'Rabbit';
      case PetSpecies.hamster:
        return 'Hamster';
      case PetSpecies.guineaPig:
        return 'Guinea Pig';
      case PetSpecies.turtle:
        return 'Turtle';
      case PetSpecies.snake:
        return 'Snake';
      case PetSpecies.other:
        return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case PetSpecies.dog:
        return '🐕';
      case PetSpecies.cat:
        return '🐈';
      case PetSpecies.bird:
        return '🐦';
      case PetSpecies.fish:
        return '🐟';
      case PetSpecies.rabbit:
        return '🐰';
      case PetSpecies.hamster:
        return '🐹';
      case PetSpecies.guineaPig:
        return '🐹';
      case PetSpecies.turtle:
        return '🐢';
      case PetSpecies.snake:
        return '🐍';
      case PetSpecies.other:
        return '🐾';
    }
  }
}
