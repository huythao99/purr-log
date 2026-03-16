import 'package:equatable/equatable.dart';

import '../../../data/models/reminder_model.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object?> get props => [];
}

class ReminderLoadAll extends ReminderEvent {
  const ReminderLoadAll();
}

class ReminderLoadForPet extends ReminderEvent {
  final int petId;

  const ReminderLoadForPet(this.petId);

  @override
  List<Object?> get props => [petId];
}

class ReminderAdd extends ReminderEvent {
  final Reminder reminder;

  const ReminderAdd(this.reminder);

  @override
  List<Object?> get props => [reminder];
}

class ReminderUpdate extends ReminderEvent {
  final Reminder reminder;

  const ReminderUpdate(this.reminder);

  @override
  List<Object?> get props => [reminder];
}

class ReminderDelete extends ReminderEvent {
  final int reminderId;

  const ReminderDelete(this.reminderId);

  @override
  List<Object?> get props => [reminderId];
}

class ReminderToggleActive extends ReminderEvent {
  final int reminderId;
  final bool isActive;

  const ReminderToggleActive(this.reminderId, this.isActive);

  @override
  List<Object?> get props => [reminderId, isActive];
}
