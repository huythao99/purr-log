import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/pet_food_model.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../blocs/feeding/feeding_bloc.dart';
import '../../blocs/feeding/feeding_event.dart';
import '../../blocs/feeding/feeding_state.dart';

class PetFoodListPage extends StatelessWidget {
  const PetFoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedingBloc(getIt<FeedingRepository>())
        ..add(const FeedingLoadFoods()),
      child: const PetFoodListView(),
    );
  }
}

class PetFoodListView extends StatelessWidget {
  const PetFoodListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Foods'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => context.push(AppRoutes.foodScannerPath(null)),
            tooltip: 'Scan Food',
          ),
        ],
      ),
      body: BlocBuilder<FeedingBloc, FeedingState>(
        builder: (context, state) {
          if (state is FeedingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FeedingFoodsLoaded) {
            if (state.foods.isEmpty) {
              return _buildEmptyState(context);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final food = state.foods[index];
                return _PetFoodCard(food: food);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.petFoodAdd),
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
            Icons.restaurant_menu,
            size: 80,
            color: AppColors.textHint.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No foods saved',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Scan or add foods to track calories',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.push(AppRoutes.petFoodAdd),
            icon: const Icon(Icons.add),
            label: const Text('Add Food'),
          ),
        ],
      ),
    );
  }
}

class _PetFoodCard extends StatelessWidget {
  final PetFood food;

  const _PetFoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push(AppRoutes.petFoodEditPath(food.id)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.restaurant, color: AppColors.secondary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (food.brand != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        food.brand!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${food.kcalPer100g} kcal/100g',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (food.barcode != null)
                const Icon(Icons.qr_code, color: AppColors.textHint, size: 20),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }
}
