import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/health_record_model.dart';
import '../../../data/repositories/health_repository.dart';
import '../../blocs/health/health_bloc.dart';
import '../../blocs/health/health_event.dart';
import '../../blocs/health/health_state.dart';

class HealthListPage extends StatelessWidget {
  final int petId;

  const HealthListPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthBloc(getIt<HealthRepository>())
        ..add(HealthLoadRecords(petId)),
      child: HealthListView(petId: petId),
    );
  }
}

class HealthListView extends StatelessWidget {
  final int petId;

  const HealthListView({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
      ),
      body: BlocConsumer<HealthBloc, HealthState>(
        listener: (context, state) {
          if (state is HealthOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is HealthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HealthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HealthRecordsLoaded) {
            if (state.records.isEmpty) {
              return _buildEmptyState(context);
            }

            return _buildRecordsList(context, state.records);
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.healthAddPath(petId)),
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
            Icons.medical_services,
            size: 80,
            color: AppColors.textHint.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No health records yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add a health record',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsList(BuildContext context, List<HealthRecord> records) {
    final dateFormat = DateFormat('MMM d, yyyy');

    final groupedRecords = <HealthRecordType, List<HealthRecord>>{};
    for (final record in records) {
      groupedRecords.putIfAbsent(record.type, () => []).add(record);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedRecords.length,
      itemBuilder: (context, index) {
        final type = groupedRecords.keys.elementAt(index);
        final typeRecords = groupedRecords[type]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(type.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    type.displayName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            ...typeRecords.map((record) => _HealthRecordCard(
                  record: record,
                  dateFormat: dateFormat,
                  petId: petId,
                  onDelete: () {
                    context.read<HealthBloc>().add(HealthDeleteRecord(record.id));
                  },
                )),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class _HealthRecordCard extends StatelessWidget {
  final HealthRecord record;
  final DateFormat dateFormat;
  final int petId;
  final VoidCallback onDelete;

  const _HealthRecordCard({
    required this.record,
    required this.dateFormat,
    required this.petId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => context.push(
          AppRoutes.healthEditPath(petId, record.id),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
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
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    dateFormat.format(record.recordDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  if (record.nextDueDate != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.event, size: 16, color: AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${dateFormat.format(record.nextDueDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ],
              ),
              if (record.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  record.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (record.veterinarianName != null || record.clinicName != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_hospital, size: 16, color: AppColors.info),
                    const SizedBox(width: 4),
                    Text(
                      [record.veterinarianName, record.clinicName]
                          .where((e) => e != null)
                          .join(' - '),
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
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Are you sure you want to delete this health record?'),
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
