import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection.dart';
import '../../../data/models/pet_food_model.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../blocs/food_scanner/food_scanner_bloc.dart';
import '../../blocs/food_scanner/food_scanner_event.dart';
import '../../blocs/food_scanner/food_scanner_state.dart';

class FoodScannerPage extends StatelessWidget {
  final int? petId;

  const FoodScannerPage({super.key, this.petId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodScannerBloc(getIt<FeedingRepository>()),
      child: FoodScannerView(petId: petId),
    );
  }
}

class FoodScannerView extends StatefulWidget {
  final int? petId;

  const FoodScannerView({super.key, this.petId});

  @override
  State<FoodScannerView> createState() => _FoodScannerViewState();
}

class _FoodScannerViewState extends State<FoodScannerView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MobileScannerController _barcodeController = MobileScannerController();
  final TextRecognizer _textRecognizer = TextRecognizer();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _barcodeController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodScannerBloc, FoodScannerState>(
      listener: (context, state) {
        if (state is FoodScannerFoodSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Food saved successfully')),
          );
          context.pop(state.food);
        }
        if (state is FoodScannerError) {
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
            title: const Text('Scan Food'),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.qr_code_scanner), text: 'Barcode'),
                Tab(icon: Icon(Icons.document_scanner), text: 'Nutrition Label'),
              ],
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, FoodScannerState state) {
    if (state is FoodScannerProcessing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Processing...'),
          ],
        ),
      );
    }

    if (state is FoodScannerBarcodeFound) {
      return _buildBarcodeResult(context, state);
    }

    if (state is FoodScannerNutritionExtracted) {
      return _buildNutritionResult(context, state);
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildBarcodeScanner(),
        _buildNutritionScanner(),
      ],
    );
  }

  Widget _buildBarcodeScanner() {
    return Column(
      children: [
        Expanded(
          child: MobileScanner(
            controller: _barcodeController,
            onDetect: (capture) {
              if (_isProcessing) return;
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                setState(() => _isProcessing = true);
                context.read<FoodScannerBloc>().add(
                      FoodScannerBarcodeScanned(barcodes.first.rawValue!),
                    );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Point camera at barcode',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionScanner() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.document_scanner,
              size: 80,
              color: AppColors.textHint.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Scan Nutrition Label',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Take a photo of the nutrition facts on the pet food package',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _scanNutritionLabel(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () => _scanNutritionLabel(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeResult(BuildContext context, FoodScannerBarcodeFound state) {
    if (state.existingFood != null) {
      return _buildExistingFoodResult(context, state.existingFood!);
    }

    return _buildNewFoodForm(context, barcode: state.barcode);
  }

  Widget _buildExistingFoodResult(BuildContext context, PetFood food) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 64, color: AppColors.success),
          const SizedBox(height: 16),
          Text(
            'Food Found!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.restaurant, color: AppColors.primary),
                    title: Text(food.name),
                    subtitle: food.brand != null ? Text(food.brand!) : null,
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.local_fire_department,
                        color: AppColors.secondary),
                    title: Text('${food.kcalPer100g} kcal/100g'),
                    subtitle: const Text('Calories'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.pop(food),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Text('Use This Food'),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() => _isProcessing = false);
              context.read<FoodScannerBloc>().add(const FoodScannerReset());
            },
            child: const Text('Scan Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionResult(BuildContext context, FoodScannerNutritionExtracted state) {
    return _buildNewFoodForm(
      context,
      initialKcal: state.kcalPer100g,
      initialProtein: state.protein,
      initialFat: state.fat,
      initialFiber: state.fiber,
    );
  }

  Widget _buildNewFoodForm(
    BuildContext context, {
    String? barcode,
    double? initialKcal,
    double? initialProtein,
    double? initialFat,
    double? initialFiber,
  }) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final brandController = TextEditingController();
    final kcalController = TextEditingController(
      text: initialKcal?.toString() ?? '',
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (barcode != null) ...[
              Card(
                color: AppColors.info.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code, color: AppColors.info),
                      const SizedBox(width: 12),
                      Text('Barcode: $barcode'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              'Add New Food',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
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
              controller: brandController,
              decoration: const InputDecoration(
                labelText: 'Brand',
                prefixIcon: Icon(Icons.business),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: kcalController,
              decoration: const InputDecoration(
                labelText: 'Kcal per 100g *',
                prefixIcon: Icon(Icons.local_fire_department),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter calories';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final food = PetFood()
                    ..name = nameController.text.trim()
                    ..brand = brandController.text.trim().isEmpty
                        ? null
                        : brandController.text.trim()
                    ..barcode = barcode
                    ..kcalPer100g = double.parse(kcalController.text)
                    ..proteinPercent = initialProtein
                    ..fatPercent = initialFat
                    ..fiberPercent = initialFiber
                    ..createdAt = DateTime.now();

                  context.read<FoodScannerBloc>().add(FoodScannerSaveFood(food));
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text('Save Food'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() => _isProcessing = false);
                context.read<FoodScannerBloc>().add(const FoodScannerReset());
              },
              child: const Text('Scan Again'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scanNutritionLabel(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(source: source);
      if (image == null) return;

      setState(() => _isProcessing = true);

      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      if (mounted) {
        context.read<FoodScannerBloc>().add(
              FoodScannerTextRecognized(recognizedText.text),
            );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error scanning: $e'),
            backgroundColor: AppColors.error,
          ),
        );
        setState(() => _isProcessing = false);
      }
    }
  }
}
