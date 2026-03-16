import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/pet_food_model.dart';
import '../../../data/repositories/feeding_repository.dart';

class PetFoodFormPage extends StatefulWidget {
  final int? foodId;

  const PetFoodFormPage({super.key, this.foodId});

  @override
  State<PetFoodFormPage> createState() => _PetFoodFormPageState();
}

class _PetFoodFormPageState extends State<PetFoodFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _kcalController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _notesController = TextEditingController();

  final _feedingRepository = getIt<FeedingRepository>();
  PetFood? _existingFood;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.foodId != null) {
      _loadFood();
    }
  }

  Future<void> _loadFood() async {
    setState(() => _isLoading = true);
    final food = await _feedingRepository.getPetFoodById(widget.foodId!);
    if (food != null && mounted) {
      setState(() {
        _existingFood = food;
        _nameController.text = food.name;
        _brandController.text = food.brand ?? '';
        _kcalController.text = food.kcalPer100g.toString();
        _barcodeController.text = food.barcode ?? '';
        _notesController.text = food.notes ?? '';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _kcalController.dispose();
    _barcodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.foodId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Food' : 'Add Food'),
        actions: isEditing
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _confirmDelete,
                ),
              ]
            : null,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Food Name *',
                      prefixIcon: Icon(Icons.restaurant),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter food name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      prefixIcon: Icon(Icons.business),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _kcalController,
                    decoration: const InputDecoration(
                      labelText: 'Kcal per 100g *',
                      prefixIcon: Icon(Icons.local_fire_department),
                      suffixText: 'kcal',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter calories';
                      }
                      final kcal = double.tryParse(value);
                      if (kcal == null || kcal <= 0) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _barcodeController,
                    decoration: const InputDecoration(
                      labelText: 'Barcode',
                      prefixIcon: Icon(Icons.qr_code),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      prefixIcon: Icon(Icons.note),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _saveFood,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(isEditing ? 'Save Changes' : 'Add Food'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _saveFood() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final food = PetFood()
      ..name = _nameController.text.trim()
      ..brand =
          _brandController.text.trim().isEmpty ? null : _brandController.text.trim()
      ..kcalPer100g = double.parse(_kcalController.text)
      ..barcode =
          _barcodeController.text.trim().isEmpty ? null : _barcodeController.text.trim()
      ..notes =
          _notesController.text.trim().isEmpty ? null : _notesController.text.trim()
      ..createdAt = _existingFood?.createdAt ?? DateTime.now();

    if (_existingFood != null) {
      food.id = _existingFood!.id;
      await _feedingRepository.updatePetFood(food);
    } else {
      await _feedingRepository.addPetFood(food);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _existingFood != null ? 'Food updated' : 'Food added',
          ),
        ),
      );
      context.pop(true);
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Food'),
        content: const Text('Are you sure you want to delete this food?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _feedingRepository.deletePetFood(widget.foodId!);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Food deleted')),
                );
                context.pop(true);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
