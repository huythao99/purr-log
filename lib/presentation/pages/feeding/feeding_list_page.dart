import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/feeding_log_model.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../blocs/feeding/feeding_bloc.dart';
import '../../blocs/feeding/feeding_event.dart';
import '../../blocs/feeding/feeding_state.dart';

class FeedingListPage extends StatelessWidget {
  final int petId;

  const FeedingListPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedingBloc(getIt<FeedingRepository>())
        ..add(FeedingLoadLogs(petId)),
      child: FeedingListView(petId: petId),
    );
  }
}

class FeedingListView extends StatelessWidget {
  final int petId;

  const FeedingListView({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeding Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => context.push(AppRoutes.foodScannerPath(petId)),
            tooltip: 'Scan Food',
          ),
        ],
      ),
      body: BlocConsumer<FeedingBloc, FeedingState>(
        listener: (context, state) {
          if (state is FeedingOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is FeedingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FeedingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FeedingLogsLoaded) {
            return Column(
              children: [
                _buildTodaySummary(context, state.todayTotalKcal),
                Expanded(
                  child: state.logs.isEmpty
                      ? _buildEmptyState(context)
                      : _buildLogsList(context, state.logs),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.feedingAddPath(petId)),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodaySummary(BuildContext context, double todayKcal) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_fire_department, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\'s Calories',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Text(
                '${todayKcal.toInt()} kcal',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: 80,
            color: AppColors.textHint.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No feeding logs yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add a feeding log',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsList(BuildContext context, List<FeedingLog> logs) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    final groupedLogs = <String, List<FeedingLog>>{};
    for (final log in logs) {
      final dateKey = dateFormat.format(log.feedingTime);
      groupedLogs.putIfAbsent(dateKey, () => []).add(log);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: groupedLogs.length,
      itemBuilder: (context, index) {
        final dateKey = groupedLogs.keys.elementAt(index);
        final dayLogs = groupedLogs[dateKey]!;
        final dayTotal = dayLogs.fold(0.0, (sum, log) => sum + log.totalKcal);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateKey,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '${dayTotal.toInt()} kcal',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            ...dayLogs.map((log) => _FeedingLogCard(
                  log: log,
                  timeFormat: timeFormat,
                  onDelete: () {
                    context.read<FeedingBloc>().add(FeedingDeleteLog(log.id));
                  },
                )),
          ],
        );
      },
    );
  }
}

class _FeedingLogCard extends StatelessWidget {
  final FeedingLog log;
  final DateFormat timeFormat;
  final VoidCallback onDelete;

  const _FeedingLogCard({
    required this.log,
    required this.timeFormat,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.restaurant, color: AppColors.secondary),
        ),
        title: Text(log.foodName ?? 'Food'),
        subtitle: Text(
          '${log.portionGrams.toInt()}g - ${timeFormat.format(log.feedingTime)}',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${log.totalKcal.toInt()} kcal',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () => _confirmDelete(context),
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Log'),
        content: const Text('Are you sure you want to delete this feeding log?'),
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
