import 'package:isar/isar.dart';

part 'activity_model.g.dart';

@collection
class Activity {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  @enumerated
  late ActivityType type;

  late int durationMinutes;

  String? notes;

  double? distance;

  @Index()
  late DateTime activityDate;

  late DateTime createdAt;
}

enum ActivityType {
  walk,
  play,
  training,
  grooming,
  bath,
  nailTrim,
  brushing,
  swimming,
  other,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
      case ActivityType.walk:
        return 'Walk';
      case ActivityType.play:
        return 'Play';
      case ActivityType.training:
        return 'Training';
      case ActivityType.grooming:
        return 'Grooming';
      case ActivityType.bath:
        return 'Bath';
      case ActivityType.nailTrim:
        return 'Nail Trim';
      case ActivityType.brushing:
        return 'Brushing';
      case ActivityType.swimming:
        return 'Swimming';
      case ActivityType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case ActivityType.walk:
        return '🚶';
      case ActivityType.play:
        return '🎾';
      case ActivityType.training:
        return '🎓';
      case ActivityType.grooming:
        return '✂️';
      case ActivityType.bath:
        return '🛁';
      case ActivityType.nailTrim:
        return '💅';
      case ActivityType.brushing:
        return '🪮';
      case ActivityType.swimming:
        return '🏊';
      case ActivityType.other:
        return '📝';
    }
  }
}
