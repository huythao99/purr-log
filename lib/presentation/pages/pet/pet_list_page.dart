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

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetBloc(getIt<PetRepository>())..add(const PetLoadAll()),
      child: const PetListView(),
    );
  }
}

class PetListView extends StatelessWidget {
  const PetListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pets'),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PetError) {
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
                      context.read<PetBloc>().add(const PetLoadAll());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is PetLoaded) {
            if (state.pets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 80,
                      color: AppColors.textHint.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No pets yet',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first pet to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textHint,
                          ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push(AppRoutes.petAdd),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Pet'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pets.length,
              itemBuilder: (context, index) {
                final pet = state.pets[index];
                return PetCard(pet: pet);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.petAdd),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push(AppRoutes.petDetailPath(pet.id)),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
                backgroundImage:
                    pet.photoPath != null ? FileImage(File(pet.photoPath!)) : null,
                child: pet.photoPath == null
                    ? Text(
                        pet.species.emoji,
                        style: const TextStyle(fontSize: 28),
                      )
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
                    Text(
                      '${pet.species.displayName}${pet.breed != null ? ' - ${pet.breed}' : ''}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    if (pet.ageDisplay != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        pet.ageDisplay!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textHint,
                            ),
                      ),
                    ],
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
