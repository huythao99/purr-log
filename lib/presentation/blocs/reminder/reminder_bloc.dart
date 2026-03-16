import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/notification_service.dart';
import '../../../data/repositories/reminder_repository.dart';
import 'reminder_event.dart';
import 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderRepository _reminderRepository;
  final NotificationService _notificationService;

  ReminderBloc(this._reminderRepository, this._notificationService)
      : super(const ReminderInitial()) {
    on<ReminderLoadAll>(_onLoadAll);
    on<ReminderLoadForPet>(_onLoadForPet);
    on<ReminderAdd>(_onAdd);
    on<ReminderUpdate>(_onUpdate);
    on<ReminderDelete>(_onDelete);
    on<ReminderToggleActive>(_onToggleActive);
  }

  Future<void> _onLoadAll(
    ReminderLoadAll event,
    Emitter<ReminderState> emit,
  ) async {
    emit(const ReminderLoading());
    try {
      final reminders = await _reminderRepository.getAllReminders();
      emit(ReminderLoaded(reminders));
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onLoadForPet(
    ReminderLoadForPet event,
    Emitter<ReminderState> emit,
  ) async {
    emit(const ReminderLoading());
    try {
      final reminders = await _reminderRepository.getRemindersForPet(event.petId);
      emit(ReminderLoaded(reminders));
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onAdd(
    ReminderAdd event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      final id = await _reminderRepository.addReminder(event.reminder);

      if (event.reminder.isActive) {
        await _notificationService.scheduleNotification(
          id: id,
          title: event.reminder.title,
          body: event.reminder.description ?? 'Reminder for your pet',
          scheduledTime: event.reminder.reminderTime,
        );
      }

      emit(const ReminderOperationSuccess('Reminder added'));
      add(const ReminderLoadAll());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    ReminderUpdate event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      await _reminderRepository.updateReminder(event.reminder);

      await _notificationService.cancelNotification(event.reminder.id);
      if (event.reminder.isActive) {
        await _notificationService.scheduleNotification(
          id: event.reminder.id,
          title: event.reminder.title,
          body: event.reminder.description ?? 'Reminder for your pet',
          scheduledTime: event.reminder.reminderTime,
        );
      }

      emit(const ReminderOperationSuccess('Reminder updated'));
      add(const ReminderLoadAll());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onDelete(
    ReminderDelete event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      await _notificationService.cancelNotification(event.reminderId);
      await _reminderRepository.deleteReminder(event.reminderId);
      emit(const ReminderOperationSuccess('Reminder deleted'));
      add(const ReminderLoadAll());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _onToggleActive(
    ReminderToggleActive event,
    Emitter<ReminderState> emit,
  ) async {
    try {
      final reminder = await _reminderRepository.getReminderById(event.reminderId);
      if (reminder != null) {
        if (event.isActive) {
          await _notificationService.scheduleNotification(
            id: reminder.id,
            title: reminder.title,
            body: reminder.description ?? 'Reminder for your pet',
            scheduledTime: reminder.reminderTime,
          );
        } else {
          await _notificationService.cancelNotification(reminder.id);
        }
      }

      await _reminderRepository.toggleReminderActive(event.reminderId, event.isActive);
      add(const ReminderLoadAll());
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }
}
