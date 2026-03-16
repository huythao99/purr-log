import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/utils/notification_service.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/repositories/reminder_repository.dart';
import '../../blocs/reminder/reminder_bloc.dart';
import '../../blocs/reminder/reminder_event.dart';
import '../../blocs/reminder/reminder_state.dart';

class ReminderListPage extends StatelessWidget {
  const ReminderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderBloc(
        getIt<ReminderRepository>(),
        getIt<NotificationService>(),
      )..add(const ReminderLoadAll()),
      child: const ReminderListView(),
    );
  }
}

class ReminderListView extends StatelessWidget {
  const ReminderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: BlocConsumer<ReminderBloc, ReminderState>(
        listener: (context, state) {
          if (state is ReminderOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ReminderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReminderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ReminderLoaded) {
            if (state.reminders.isEmpty) {
              return _buildEmptyState(context);
            }

            return _buildRemindersList(context, state.reminders);
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.reminderAddPath(null)),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: AppColors.textHint.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No reminders yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add a reminder',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersList(BuildContext context, List<Reminder> reminders) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    final now = DateTime.now();
    final upcoming = reminders.where((r) => r.reminderTime.isAfter(now)).toList();
    final past = reminders.where((r) => r.reminderTime.isBefore(now)).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (upcoming.isNotEmpty) ...[
          Text(
            'Upcoming',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...upcoming.map((reminder) => _ReminderCard(
                reminder: reminder,
                dateFormat: dateFormat,
                timeFormat: timeFormat,
                onToggle: (isActive) {
                  context.read<ReminderBloc>().add(
                        ReminderToggleActive(reminder.id, isActive),
                      );
                },
                onDelete: () {
                  context.read<ReminderBloc>().add(ReminderDelete(reminder.id));
                },
              )),
          const SizedBox(height: 24),
        ],
        if (past.isNotEmpty) ...[
          Text(
            'Past',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          ...past.map((reminder) => _ReminderCard(
                reminder: reminder,
                dateFormat: dateFormat,
                timeFormat: timeFormat,
                isPast: true,
                onToggle: (isActive) {
                  context.read<ReminderBloc>().add(
                        ReminderToggleActive(reminder.id, isActive),
                      );
                },
                onDelete: () {
                  context.read<ReminderBloc>().add(ReminderDelete(reminder.id));
                },
              )),
        ],
      ],
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final bool isPast;
  final Function(bool) onToggle;
  final VoidCallback onDelete;

  const _ReminderCard({
    required this.reminder,
    required this.dateFormat,
    required this.timeFormat,
    this.isPast = false,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isPast ? AppColors.surfaceVariant : null,
      child: InkWell(
        onTap: () => context.push(AppRoutes.reminderEditPath(reminder.id)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isPast ? AppColors.textHint : AppColors.warning)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  reminder.type.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isPast ? AppColors.textSecondary : null,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: isPast ? AppColors.textHint : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${dateFormat.format(reminder.reminderTime)} at ${timeFormat.format(reminder.reminderTime)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isPast
                                    ? AppColors.textHint
                                    : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                    if (reminder.isRecurring) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.repeat,
                            size: 14,
                            color: AppColors.info,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            reminder.recurringPattern.displayName,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.info,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                children: [
                  Switch(
                    value: reminder.isActive,
                    onChanged: isPast ? null : onToggle,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: () => _confirmDelete(context),
                    color: AppColors.textHint,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Reminder'),
        content: const Text('Are you sure you want to delete this reminder?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
