import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../blocs/pet/pet_bloc.dart';
import '../../blocs/pet/pet_event.dart';
import '../../blocs/pet/pet_state.dart';

class PetFormPage extends StatelessWidget {
  final int? petId;

  const PetFormPage({super.key, this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = PetBloc(getIt<PetRepository>());
        if (petId != null) {
          bloc.add(PetLoadOne(petId!));
        }
        return bloc;
      },
      child: PetFormView(petId: petId),
    );
  }
}

class PetFormView extends StatefulWidget {
  final int? petId;

  const PetFormView({super.key, this.petId});

  @override
  State<PetFormView> createState() => _PetFormViewState();
}

class _PetFormViewState extends State<PetFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();

  PetSpecies _selectedSpecies = PetSpecies.dog;
  DateTime? _dateOfBirth;
  String? _photoPath;
  Pet? _existingPet;

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _populateForm(Pet pet) {
    _existingPet = pet;
    _nameController.text = pet.name;
    _breedController.text = pet.breed ?? '';
    _weightController.text = pet.weight?.toString() ?? '';
    _selectedSpecies = pet.species;
    _dateOfBirth = pet.dateOfBirth;
    _photoPath = pet.photoPath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PetBloc, PetState>(
      listener: (context, state) {
        if (state is PetDetailLoaded && _existingPet == null) {
          setState(() => _populateForm(state.pet));
        }
        if (state is PetOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop(true);
        }
        if (state is PetError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is PetLoading;
        final isEditing = widget.petId != null;

        return Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Pet' : 'Add Pet'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildPhotoSection(),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    prefixIcon: Icon(Icons.pets),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<PetSpecies>(
                  value: _selectedSpecies,
                  decoration: const InputDecoration(
                    labelText: 'Species *',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: PetSpecies.values.map((species) {
                    return DropdownMenuItem(
                      value: species,
                      child: Text('${species.emoji} ${species.displayName}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedSpecies = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _breedController,
                  decoration: const InputDecoration(
                    labelText: 'Breed',
                    prefixIcon: Icon(Icons.pets_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    prefixIcon: Icon(Icons.monitor_weight),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final weight = double.tryParse(value);
                      if (weight == null || weight <= 0) {
                        return 'Please enter a valid weight';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDateOfBirthField(),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? null : _savePet,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEditing ? 'Save Changes' : 'Add Pet'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoSection() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
          backgroundImage: _photoPath != null ? FileImage(File(_photoPath!)) : null,
          child: _photoPath == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 32,
                      color: AppColors.primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    final dateFormat = DateFormat('MMM d, yyyy');

    return InkWell(
      onTap: _selectDateOfBirth,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date of Birth',
          prefixIcon: Icon(Icons.cake),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dateOfBirth != null
                  ? dateFormat.format(_dateOfBirth!)
                  : 'Select date',
              style: TextStyle(
                color: _dateOfBirth != null
                    ? AppColors.textPrimary
                    : AppColors.textHint,
              ),
            ),
            if (_dateOfBirth != null)
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () => setState(() => _dateOfBirth = null),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() => _photoPath = image.path);
    }
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? now,
      firstDate: DateTime(now.year - 30),
      lastDate: now,
    );

    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  void _savePet() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final pet = Pet()
      ..name = _nameController.text.trim()
      ..species = _selectedSpecies
      ..breed = _breedController.text.trim().isEmpty ? null : _breedController.text.trim()
      ..weight = _weightController.text.isEmpty ? null : double.tryParse(_weightController.text)
      ..dateOfBirth = _dateOfBirth
      ..photoPath = _photoPath
      ..createdAt = _existingPet?.createdAt ?? now
      ..updatedAt = now;

    if (_existingPet != null) {
      pet.id = _existingPet!.id;
      context.read<PetBloc>().add(PetUpdate(pet));
    } else {
      context.read<PetBloc>().add(PetAdd(pet));
    }
  }
}
