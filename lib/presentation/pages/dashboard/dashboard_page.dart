import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/reminder_repository.dart';
import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../blocs/dashboard/dashboard_event.dart';
import '../../blocs/dashboard/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        getIt<PetRepository>(),
        getIt<FeedingRepository>(),
        getIt<ReminderRepository>(),
      )..add(const DashboardLoad()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Future<void> _navigateAndRefresh(BuildContext context, String route) async {
    final result = await context.push(route);
    if (result == true && context.mounted) {
      context.read<DashboardBloc>().add(const DashboardRefresh());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => _navigateAndRefresh(context, AppRoutes.foodScannerPath(null)),
            tooltip: 'Scan Food',
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DashboardBloc>().add(const DashboardLoad());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded) {
            final data = state.data;

            if (data.pets.isEmpty) {
              return _buildEmptyState(context);
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(const DashboardRefresh());
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildPetsSection(context, data),
                  const SizedBox(height: 24),
                  if (data.upcomingReminders.isNotEmpty) ...[
                    _buildRemindersSection(context, data.upcomingReminders),
                    const SizedBox(height: 24),
                  ],
                  _buildQuickActionsSection(context),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size: 100,
            color: AppColors.textHint.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to Pet Log!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first pet to get started',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => _navigateAndRefresh(context, AppRoutes.petAdd),
            icon: const Icon(Icons.add),
            label: const Text('Add Your First Pet'),
          ),
        ],
      ),
    );
  }

  Widget _buildPetsSection(BuildContext context, DashboardData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Pets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.pets),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...data.pets.take(3).map((pet) {
          final todayKcal = data.todayKcalByPet[pet.id] ?? 0;
          final recommendedKcal = data.recommendedKcalByPet[pet.id] ?? 0;
          return _PetDashboardCard(
            pet: pet,
            todayKcal: todayKcal,
            recommendedKcal: recommendedKcal,
          );
        }),
      ],
    );
  }

  Widget _buildRemindersSection(BuildContext context, List<Reminder> reminders) {
    final dateFormat = DateFormat('MMM d, h:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Reminders',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.reminders),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reminders.take(3).length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(reminder.type.icon, style: const TextStyle(fontSize: 20)),
                ),
                title: Text(reminder.title),
                subtitle: Text(
                  dateFormat.format(reminder.reminderTime),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _navigateAndRefresh(context, AppRoutes.reminderEditPath(reminder.id)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.add,
                label: 'Add Pet',
                color: AppColors.primary,
                onTap: () => _navigateAndRefresh(context, AppRoutes.petAdd),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.qr_code_scanner,
                label: 'Scan Food',
                color: AppColors.info,
                onTap: () => _navigateAndRefresh(context, AppRoutes.foodScannerPath(null)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.restaurant_menu,
                label: 'Foods',
                color: AppColors.secondary,
                onTap: () => _navigateAndRefresh(context, AppRoutes.petFoods),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PetDashboardCard extends StatelessWidget {
  final Pet pet;
  final double todayKcal;
  final double recommendedKcal;

  const _PetDashboardCard({
    required this.pet,
    required this.todayKcal,
    required this.recommendedKcal,
  });

  @override
  Widget build(BuildContext context) {
    final progress = recommendedKcal > 0 ? (todayKcal / recommendedKcal).clamp(0.0, 1.0) : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push(AppRoutes.petDetailPath(pet.id)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
                backgroundImage:
                    pet.photoPath != null ? FileImage(File(pet.photoPath!)) : null,
                child: pet.photoPath == null
                    ? Text(pet.species.emoji, style: const TextStyle(fontSize: 24))
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    if (recommendedKcal > 0) ...[
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.surfaceVariant,
                                valueColor: AlwaysStoppedAnimation(
                                  progress < 0.8
                                      ? AppColors.success
                                      : progress < 1.0
                                          ? AppColors.warning
                                          : AppColors.error,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${todayKcal.toInt()}/${recommendedKcal.toInt()} kcal',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ] else
                      Text(
                        'Set weight to track calories',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
