import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/router/app_routes.dart';
import '../../../data/models/feeding_log_model.dart';
import '../../../data/models/pet_food_model.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../blocs/feeding/feeding_bloc.dart';
import '../../blocs/feeding/feeding_event.dart';
import '../../blocs/feeding/feeding_state.dart';

class FeedingFormPage extends StatelessWidget {
  final int petId;
  final PetFood? preselectedFood;

  const FeedingFormPage({
    super.key,
    required this.petId,
    this.preselectedFood,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedingBloc(getIt<FeedingRepository>())
        ..add(const FeedingLoadFoods()),
      child: FeedingFormView(petId: petId, preselectedFood: preselectedFood),
    );
  }
}

class FeedingFormView extends StatefulWidget {
  final int petId;
  final PetFood? preselectedFood;

  const FeedingFormView({
    super.key,
    required this.petId,
    this.preselectedFood,
  });

  @override
  State<FeedingFormView> createState() => _FeedingFormViewState();
}

class _FeedingFormViewState extends State<FeedingFormView> {
  final _formKey = GlobalKey<FormState>();
  final _portionController = TextEditingController();
  final _notesController = TextEditingController();
  final _manualFoodNameController = TextEditingController();
  final _manualKcalController = TextEditingController();

  PetFood? _selectedFood;
  DateTime _feedingTime = DateTime.now();
  bool _useManualEntry = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedFood != null) {
      _selectedFood = widget.preselectedFood;
    }
  }

  @override
  void dispose() {
    _portionController.dispose();
    _notesController.dispose();
    _manualFoodNameController.dispose();
    _manualKcalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedingBloc, FeedingState>(
      listener: (context, state) {
        if (state is FeedingOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop(true);
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
        final foods = state is FeedingFoodsLoaded ? state.foods : <PetFood>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Feeding'),
            actions: [
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () async {
                  final result = await context.push<PetFood>(
                    AppRoutes.foodScannerPath(widget.petId),
                  );
                  if (result != null) {
                    setState(() {
                      _selectedFood = result;
                      _useManualEntry = false;
                    });
                  }
                },
                tooltip: 'Scan Food',
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildFoodSelectionSection(foods),
                const SizedBox(height: 16),
                _buildPortionSection(),
                const SizedBox(height: 16),
                _buildTimeSection(),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                _buildKcalPreview(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveFeedingLog,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text('Save Feeding Log'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoodSelectionSection(List<PetFood> foods) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Food',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _useManualEntry = !_useManualEntry;
                      if (_useManualEntry) _selectedFood = null;
                    });
                  },
                  child: Text(_useManualEntry ? 'Select Food' : 'Manual Entry'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_useManualEntry) ...[
              TextFormField(
                controller: _manualFoodNameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name *',
                  prefixIcon: Icon(Icons.restaurant),
                ),
                validator: (value) {
                  if (_useManualEntry && (value == null || value.isEmpty)) {
                    return 'Please enter food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _manualKcalController,
                decoration: const InputDecoration(
                  labelText: 'Kcal per 100g *',
                  prefixIcon: Icon(Icons.local_fire_department),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (_useManualEntry) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter kcal';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
            ] else ...[
              if (foods.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const Text('No saved foods'),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () => context.push(AppRoutes.petFoodAdd),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Food'),
                      ),
                    ],
                  ),
                )
              else
                DropdownButtonFormField<PetFood>(
                  value: _selectedFood,
                  decoration: const InputDecoration(
                    labelText: 'Select Food *',
                    prefixIcon: Icon(Icons.restaurant),
                  ),
                  items: foods.map((food) {
                    return DropdownMenuItem(
                      value: food,
                      child: Text('${food.name} (${food.kcalPer100g} kcal/100g)'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedFood = value);
                  },
                  validator: (value) {
                    if (!_useManualEntry && value == null) {
                      return 'Please select a food';
                    }
                    return null;
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPortionSection() {
    return TextFormField(
      controller: _portionController,
      decoration: const InputDecoration(
        labelText: 'Portion Size (grams) *',
        prefixIcon: Icon(Icons.scale),
        suffixText: 'g',
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter portion size';
        }
        final grams = double.tryParse(value);
        if (grams == null || grams <= 0) {
          return 'Please enter a valid amount';
        }
        return null;
      },
    );
  }

  Widget _buildTimeSection() {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return InkWell(
      onTap: _selectDateTime,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Feeding Time',
          prefixIcon: Icon(Icons.access_time),
        ),
        child: Text(
          '${dateFormat.format(_feedingTime)} at ${timeFormat.format(_feedingTime)}',
        ),
      ),
    );
  }

  Widget _buildKcalPreview() {
    final portion = double.tryParse(_portionController.text) ?? 0;
    double kcalPer100g;

    if (_useManualEntry) {
      kcalPer100g = double.tryParse(_manualKcalController.text) ?? 0;
    } else {
      kcalPer100g = _selectedFood?.kcalPer100g ?? 0;
    }

    final totalKcal = (kcalPer100g / 100) * portion;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_fire_department, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            'Total: ${totalKcal.toStringAsFixed(1)} kcal',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _feedingTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_feedingTime),
      );

      if (time != null) {
        setState(() {
          _feedingTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _saveFeedingLog() {
    if (!_formKey.currentState!.validate()) return;

    final portion = double.parse(_portionController.text);
    double kcalPer100g;
    String foodName;
    int? petFoodId;

    if (_useManualEntry) {
      kcalPer100g = double.parse(_manualKcalController.text);
      foodName = _manualFoodNameController.text.trim();
    } else {
      kcalPer100g = _selectedFood!.kcalPer100g;
      foodName = _selectedFood!.name;
      petFoodId = _selectedFood!.id;
    }

    final totalKcal = (kcalPer100g / 100) * portion;

    final log = FeedingLog()
      ..petId = widget.petId
      ..petFoodId = petFoodId
      ..foodName = foodName
      ..portionGrams = portion
      ..totalKcal = totalKcal
      ..feedingTime = _feedingTime
      ..notes = _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim()
      ..createdAt = DateTime.now();

    context.read<FeedingBloc>().add(FeedingAddLog(log));
  }
}
