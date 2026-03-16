import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../blocs/pet/pet_bloc.dart';
import '../../blocs/pet/pet_event.dart';
import '../../blocs/pet/pet_state.dart';

class PetDetailPage extends StatelessWidget {
  final int petId;

  const PetDetailPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetBloc(getIt<PetRepository>())..add(PetLoadOne(petId)),
      child: PetDetailView(petId: petId),
    );
  }
}

class PetDetailView extends StatelessWidget {
  final int petId;

  const PetDetailView({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PetBloc, PetState>(
      listener: (context, state) {
        if (state is PetOperationSuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is PetLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PetError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(state.message)),
          );
        }

        if (state is PetDetailLoaded) {
          final pet = state.pet;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(pet.name),
                    background: pet.photoPath != null
                        ? Image.file(
                            File(pet.photoPath!),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.primaryLight.withValues(alpha: 0.3),
                            child: Center(
                              child: Text(
                                pet.species.emoji,
                                style: const TextStyle(fontSize: 80),
                              ),
                            ),
                          ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => context.push(AppRoutes.petEditPath(pet.id)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showDeleteDialog(context, pet),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(context, pet),
                        const SizedBox(height: 16),
                        _buildQuickActions(context, pet),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, Pet pet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(context, Icons.category, 'Species', pet.species.displayName),
            if (pet.breed != null)
              _buildInfoRow(context, Icons.pets, 'Breed', pet.breed!),
            if (pet.ageDisplay != null)
              _buildInfoRow(context, Icons.cake, 'Age', pet.ageDisplay!),
            if (pet.weight != null)
              _buildInfoRow(context, Icons.monitor_weight, 'Weight', '${pet.weight} kg'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, Pet pet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.restaurant,
                label: 'Feeding',
                color: AppColors.secondary,
                onTap: () => context.push(AppRoutes.feedingListPath(pet.id)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.medical_services,
                label: 'Health',
                color: AppColors.success,
                onTap: () => context.push(AppRoutes.healthListPath(pet.id)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.notifications,
                label: 'Reminders',
                color: AppColors.warning,
                onTap: () => context.push(AppRoutes.reminderAddPath(pet.id)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.qr_code_scanner,
                label: 'Scan Food',
                color: AppColors.info,
                onTap: () => context.push(AppRoutes.foodScannerPath(pet.id)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, Pet pet) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Pet'),
        content: Text('Are you sure you want to delete ${pet.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<PetBloc>().add(PetDelete(pet.id));
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
