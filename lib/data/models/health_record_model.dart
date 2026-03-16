import 'package:isar/isar.dart';

part 'health_record_model.g.dart';

@collection
class HealthRecord {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  @enumerated
  late HealthRecordType type;

  late String title;

  String? description;

  late DateTime recordDate;

  DateTime? nextDueDate;

  String? documentPath;

  String? veterinarianName;

  String? clinicName;

  double? cost;

  late DateTime createdAt;
}

enum HealthRecordType {
  vaccination,
  vetVisit,
  medication,
  checkup,
  surgery,
  labTest,
  other,
}

extension HealthRecordTypeExtension on HealthRecordType {
  String get displayName {
    switch (this) {
      case HealthRecordType.vaccination:
        return 'Vaccination';
      case HealthRecordType.vetVisit:
        return 'Vet Visit';
      case HealthRecordType.medication:
        return 'Medication';
      case HealthRecordType.checkup:
        return 'Checkup';
      case HealthRecordType.surgery:
        return 'Surgery';
      case HealthRecordType.labTest:
        return 'Lab Test';
      case HealthRecordType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case HealthRecordType.vaccination:
        return '💉';
      case HealthRecordType.vetVisit:
        return '🏥';
      case HealthRecordType.medication:
        return '💊';
      case HealthRecordType.checkup:
        return '🩺';
      case HealthRecordType.surgery:
        return '🔪';
      case HealthRecordType.labTest:
        return '🧪';
      case HealthRecordType.other:
        return '📋';
    }
  }
}
