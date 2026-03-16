import 'package:isar/isar.dart';

part 'reminder_model.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  late String title;

  String? description;

  @enumerated
  late ReminderType type;

  @Index()
  late DateTime reminderTime;

  late bool isRecurring;

  @enumerated
  RecurringPattern recurringPattern = RecurringPattern.none;

  late bool isActive;

  int? notificationId;

  late DateTime createdAt;

  late DateTime updatedAt;
}

enum ReminderType {
  feeding,
  medication,
  vet,
  grooming,
  vaccination,
  exercise,
  other,
}

extension ReminderTypeExtension on ReminderType {
  String get displayName {
    switch (this) {
      case ReminderType.feeding:
        return 'Feeding';
      case ReminderType.medication:
        return 'Medication';
      case ReminderType.vet:
        return 'Vet Appointment';
      case ReminderType.grooming:
        return 'Grooming';
      case ReminderType.vaccination:
        return 'Vaccination';
      case ReminderType.exercise:
        return 'Exercise';
      case ReminderType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case ReminderType.feeding:
        return '🍽️';
      case ReminderType.medication:
        return '💊';
      case ReminderType.vet:
        return '🏥';
      case ReminderType.grooming:
        return '✂️';
      case ReminderType.vaccination:
        return '💉';
      case ReminderType.exercise:
        return '🏃';
      case ReminderType.other:
        return '🔔';
    }
  }
}

enum RecurringPattern {
  none,
  daily,
  weekly,
  biweekly,
  monthly,
  yearly,
}

extension RecurringPatternExtension on RecurringPattern {
  String get displayName {
    switch (this) {
      case RecurringPattern.none:
        return 'None';
      case RecurringPattern.daily:
        return 'Daily';
      case RecurringPattern.weekly:
        return 'Weekly';
      case RecurringPattern.biweekly:
        return 'Bi-weekly';
      case RecurringPattern.monthly:
        return 'Monthly';
      case RecurringPattern.yearly:
        return 'Yearly';
    }
  }
}
