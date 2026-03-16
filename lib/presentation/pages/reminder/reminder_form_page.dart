import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/notification_service.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/repositories/reminder_repository.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../blocs/reminder/reminder_bloc.dart';
import '../../blocs/reminder/reminder_event.dart';
import '../../blocs/reminder/reminder_state.dart';

class ReminderFormPage extends StatelessWidget {
  final int? petId;
  final int? reminderId;

  const ReminderFormPage({
    super.key,
    this.petId,
    this.reminderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReminderBloc(
        getIt<ReminderRepository>(),
        getIt<NotificationService>(),
      ),
      child: ReminderFormView(petId: petId, reminderId: reminderId),
    );
  }
}

class ReminderFormView extends StatefulWidget {
  final int? petId;
  final int? reminderId;

  const ReminderFormView({
    super.key,
    this.petId,
    this.reminderId,
  });

  @override
  State<ReminderFormView> createState() => _ReminderFormViewState();
}

class _ReminderFormViewState extends State<ReminderFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _petRepository = getIt<PetRepository>();
  final _reminderRepository = getIt<ReminderRepository>();

  List<Pet> _pets = [];
  Pet? _selectedPet;
  ReminderType _selectedType = ReminderType.other;
  DateTime _reminderTime = DateTime.now().add(const Duration(hours: 1));
  bool _isRecurring = false;
  RecurringPattern _recurringPattern = RecurringPattern.none;
  bool _isActive = true;
  Reminder? _existingReminder;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _pets = await _petRepository.getAllPets();

    if (widget.reminderId != null) {
      final reminder = await _reminderRepository.getReminderById(widget.reminderId!);
      if (reminder != null && mounted) {
        setState(() {
          _existingReminder = reminder;
          _titleController.text = reminder.title;
          _descriptionController.text = reminder.description ?? '';
          _selectedPet = _pets.firstWhere(
            (p) => p.id == reminder.petId,
            orElse: () => _pets.first,
          );
          _selectedType = reminder.type;
          _reminderTime = reminder.reminderTime;
          _isRecurring = reminder.isRecurring;
          _recurringPattern = reminder.recurringPattern;
          _isActive = reminder.isActive;
        });
      }
    } else if (widget.petId != null) {
      _selectedPet = _pets.firstWhere(
        (p) => p.id == widget.petId,
        orElse: () => _pets.first,
      );
    } else if (_pets.isNotEmpty) {
      _selectedPet = _pets.first;
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.reminderId != null;
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return BlocConsumer<ReminderBloc, ReminderState>(
      listener: (context, state) {
        if (state is ReminderOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop(true);
        }
        if (state is ReminderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Reminder' : 'Add Reminder'),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _pets.isEmpty
                  ? _buildNoPetsState(context)
                  : Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          DropdownButtonFormField<Pet>(
                            value: _selectedPet,
                            decoration: const InputDecoration(
                              labelText: 'Pet *',
                              prefixIcon: Icon(Icons.pets),
                            ),
                            items: _pets.map((pet) {
                              return DropdownMenuItem(
                                value: pet,
                                child: Text('${pet.species.emoji} ${pet.name}'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedPet = value);
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a pet';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<ReminderType>(
                            value: _selectedType,
                            decoration: const InputDecoration(
                              labelText: 'Type *',
                              prefixIcon: Icon(Icons.category),
                            ),
                            items: ReminderType.values.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text('${type.icon} ${type.displayName}'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedType = value);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title *',
                              prefixIcon: Icon(Icons.title),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              prefixIcon: Icon(Icons.description),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: _selectDateTime,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Reminder Time *',
                                prefixIcon: Icon(Icons.access_time),
                              ),
                              child: Text(
                                '${dateFormat.format(_reminderTime)} at ${timeFormat.format(_reminderTime)}',
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Recurring'),
                            subtitle: const Text('Repeat this reminder'),
                            value: _isRecurring,
                            onChanged: (value) {
                              setState(() {
                                _isRecurring = value;
                                if (!value) _recurringPattern = RecurringPattern.none;
                              });
                            },
                          ),
                          if (_isRecurring) ...[
                            const SizedBox(height: 8),
                            DropdownButtonFormField<RecurringPattern>(
                              value: _recurringPattern == RecurringPattern.none
                                  ? RecurringPattern.daily
                                  : _recurringPattern,
                              decoration: const InputDecoration(
                                labelText: 'Repeat Pattern',
                                prefixIcon: Icon(Icons.repeat),
                              ),
                              items: RecurringPattern.values
                                  .where((p) => p != RecurringPattern.none)
                                  .map((pattern) {
                                return DropdownMenuItem(
                                  value: pattern,
                                  child: Text(pattern.displayName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _recurringPattern = value);
                                }
                              },
                              validator: (value) {
                                if (_isRecurring && (value == null || value == RecurringPattern.none)) {
                                  return 'Please select a pattern';
                                }
                                return null;
                              },
                            ),
                          ],
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Active'),
                            subtitle: const Text('Enable notifications'),
                            value: _isActive,
                            onChanged: (value) {
                              setState(() => _isActive = value);
                            },
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _saveReminder,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(isEditing ? 'Save Changes' : 'Add Reminder'),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }

  Widget _buildNoPetsState(BuildContext context) {
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
            'Add a pet first to create reminders',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_reminderTime),
      );

      if (time != null) {
        setState(() {
          _reminderTime = DateTime(
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

  void _saveReminder() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final reminder = Reminder()
      ..petId = _selectedPet!.id
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim()
      ..type = _selectedType
      ..reminderTime = _reminderTime
      ..isRecurring = _isRecurring
      ..recurringPattern = _recurringPattern
      ..isActive = _isActive
      ..createdAt = _existingReminder?.createdAt ?? now
      ..updatedAt = now;

    if (_existingReminder != null) {
      reminder.id = _existingReminder!.id;
      context.read<ReminderBloc>().add(ReminderUpdate(reminder));
    } else {
      context.read<ReminderBloc>().add(ReminderAdd(reminder));
    }
  }
}
