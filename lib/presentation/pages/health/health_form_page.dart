import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/health_record_model.dart';
import '../../../data/repositories/health_repository.dart';
import '../../blocs/health/health_bloc.dart';
import '../../blocs/health/health_event.dart';
import '../../blocs/health/health_state.dart';

class HealthFormPage extends StatelessWidget {
  final int petId;
  final int? recordId;

  const HealthFormPage({
    super.key,
    required this.petId,
    this.recordId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthBloc(getIt<HealthRepository>()),
      child: HealthFormView(petId: petId, recordId: recordId),
    );
  }
}

class HealthFormView extends StatefulWidget {
  final int petId;
  final int? recordId;

  const HealthFormView({
    super.key,
    required this.petId,
    this.recordId,
  });

  @override
  State<HealthFormView> createState() => _HealthFormViewState();
}

class _HealthFormViewState extends State<HealthFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _vetNameController = TextEditingController();
  final _clinicNameController = TextEditingController();
  final _costController = TextEditingController();

  final _healthRepository = getIt<HealthRepository>();
  HealthRecordType _selectedType = HealthRecordType.vetVisit;
  DateTime _recordDate = DateTime.now();
  DateTime? _nextDueDate;
  HealthRecord? _existingRecord;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.recordId != null) {
      _loadRecord();
    }
  }

  Future<void> _loadRecord() async {
    setState(() => _isLoading = true);
    final records = await _healthRepository.getHealthRecordsForPet(widget.petId);
    final record = records.firstWhere(
      (r) => r.id == widget.recordId,
      orElse: () => throw Exception('Record not found'),
    );

    if (mounted) {
      setState(() {
        _existingRecord = record;
        _titleController.text = record.title;
        _descriptionController.text = record.description ?? '';
        _vetNameController.text = record.veterinarianName ?? '';
        _clinicNameController.text = record.clinicName ?? '';
        _costController.text = record.cost?.toString() ?? '';
        _selectedType = record.type;
        _recordDate = record.recordDate;
        _nextDueDate = record.nextDueDate;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _vetNameController.dispose();
    _clinicNameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.recordId != null;
    final dateFormat = DateFormat('MMM d, yyyy');

    return BlocConsumer<HealthBloc, HealthState>(
      listener: (context, state) {
        if (state is HealthOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop(true);
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
        return Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Health Record' : 'Add Health Record'),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      DropdownButtonFormField<HealthRecordType>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type *',
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: HealthRecordType.values.map((type) {
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
                      InkWell(
                        onTap: () => _selectDate(isRecordDate: true),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date *',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(dateFormat.format(_recordDate)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(isRecordDate: false),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Next Due Date',
                            prefixIcon: Icon(Icons.event),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _nextDueDate != null
                                    ? dateFormat.format(_nextDueDate!)
                                    : 'Not set',
                                style: TextStyle(
                                  color: _nextDueDate != null
                                      ? null
                                      : AppColors.textHint,
                                ),
                              ),
                              if (_nextDueDate != null)
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () {
                                    setState(() => _nextDueDate = null);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _vetNameController,
                        decoration: const InputDecoration(
                          labelText: 'Veterinarian Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _clinicNameController,
                        decoration: const InputDecoration(
                          labelText: 'Clinic Name',
                          prefixIcon: Icon(Icons.local_hospital),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _costController,
                        decoration: const InputDecoration(
                          labelText: 'Cost',
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid amount';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _saveRecord,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(isEditing ? 'Save Changes' : 'Add Record'),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> _selectDate({required bool isRecordDate}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isRecordDate ? _recordDate : (_nextDueDate ?? now),
      firstDate: isRecordDate ? DateTime(now.year - 10) : now,
      lastDate: isRecordDate ? now : DateTime(now.year + 10),
    );

    if (picked != null) {
      setState(() {
        if (isRecordDate) {
          _recordDate = picked;
        } else {
          _nextDueDate = picked;
        }
      });
    }
  }

  void _saveRecord() {
    if (!_formKey.currentState!.validate()) return;

    final record = HealthRecord()
      ..petId = widget.petId
      ..type = _selectedType
      ..title = _titleController.text.trim()
      ..description = _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim()
      ..recordDate = _recordDate
      ..nextDueDate = _nextDueDate
      ..veterinarianName = _vetNameController.text.trim().isEmpty
          ? null
          : _vetNameController.text.trim()
      ..clinicName = _clinicNameController.text.trim().isEmpty
          ? null
          : _clinicNameController.text.trim()
      ..cost = _costController.text.isEmpty
          ? null
          : double.tryParse(_costController.text)
      ..createdAt = _existingRecord?.createdAt ?? DateTime.now();

    if (_existingRecord != null) {
      record.id = _existingRecord!.id;
      context.read<HealthBloc>().add(HealthUpdateRecord(record));
    } else {
      context.read<HealthBloc>().add(HealthAddRecord(record));
    }
  }
}
