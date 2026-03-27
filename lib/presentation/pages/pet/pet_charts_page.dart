import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/health_repository.dart';
import '../../blocs/chart/chart_bloc.dart';
import '../../blocs/chart/chart_event.dart';
import '../../blocs/chart/chart_state.dart';
import '../../widgets/charts/weight_trend_chart.dart';
import '../../widgets/charts/feeding_bar_chart.dart';

class PetChartsPage extends StatelessWidget {
  final int petId;

  const PetChartsPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartBloc(
        getIt<PetRepository>(),
        getIt<FeedingRepository>(),
        getIt<HealthRepository>(),
      )..add(ChartLoadAll(petId: petId)),
      child: const PetChartsView(),
    );
  }
}

class PetChartsView extends StatelessWidget {
  const PetChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Charts'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Weight'),
              Tab(text: 'Feeding'),
            ],
          ),
        ),
        body: BlocBuilder<ChartBloc, ChartState>(
          builder: (context, state) {
            if (state is ChartLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ChartError) {
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
                        // Retry would need petId - handled in initial load
                        Navigator.of(context).pop();
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            if (state is ChartLoaded) {
              return TabBarView(
                children: [
                  _buildWeightTab(context, state),
                  _buildFeedingTab(context, state),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildWeightTab(BuildContext context, ChartLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: WeightTrendChart(data: state.weightData),
            ),
          ),
          const SizedBox(height: 16),
          if (state.weightData.isNotEmpty) _buildWeightStats(context, state),
        ],
      ),
    );
  }

  Widget _buildFeedingTab(BuildContext context, ChartLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FeedingBarChart(data: state.feedingData),
            ),
          ),
          const SizedBox(height: 16),
          if (state.feedingData.isNotEmpty) _buildFeedingStats(context, state),
        ],
      ),
    );
  }

  Widget _buildWeightStats(BuildContext context, ChartLoaded state) {
    final sortedData = List.from(state.weightData)
      ..sort((a, b) => a.date.compareTo(b.date));

    if (sortedData.isEmpty) return const SizedBox.shrink();

    final latestWeight = sortedData.last.weight;
    final earliestWeight = sortedData.first.weight;
    final minWeight = state.weightData.map((e) => e.weight).reduce((a, b) => a < b ? a : b);
    final maxWeight = state.weightData.map((e) => e.weight).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Current',
                    value: '${latestWeight.toStringAsFixed(1)} kg',
                    icon: Icons.monitor_weight,
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Starting',
                    value: '${earliestWeight.toStringAsFixed(1)} kg',
                    icon: Icons.history,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Lowest',
                    value: '${minWeight.toStringAsFixed(1)} kg',
                    icon: Icons.arrow_downward,
                    color: AppColors.info,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Highest',
                    value: '${maxWeight.toStringAsFixed(1)} kg',
                    icon: Icons.arrow_upward,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedingStats(BuildContext context, ChartLoaded state) {
    final totalKcal = state.feedingData.fold<double>(0, (sum, e) => sum + e.totalKcal);
    final avgKcal = totalKcal / state.feedingData.length;
    final onTargetDays = state.feedingData.where((e) => e.percentage >= 90 && e.percentage <= 110).length;
    final recommended = state.feedingData.isNotEmpty ? state.feedingData.first.recommendedKcal : 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Daily Average',
                    value: '${avgKcal.toInt()} kcal',
                    icon: Icons.restaurant,
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Target',
                    value: '${recommended.toInt()} kcal',
                    icon: Icons.flag,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Days on Target',
                    value: '$onTargetDays / ${state.feedingData.length}',
                    icon: Icons.check_circle,
                    color: AppColors.success,
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Total This Week',
                    value: '${totalKcal.toInt()} kcal',
                    icon: Icons.calculate,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
