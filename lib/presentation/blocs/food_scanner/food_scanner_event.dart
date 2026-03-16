import 'package:equatable/equatable.dart';

import '../../../data/models/pet_food_model.dart';

abstract class FoodScannerEvent extends Equatable {
  const FoodScannerEvent();

  @override
  List<Object?> get props => [];
}

class FoodScannerReset extends FoodScannerEvent {
  const FoodScannerReset();
}

class FoodScannerBarcodeScanned extends FoodScannerEvent {
  final String barcode;

  const FoodScannerBarcodeScanned(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class FoodScannerTextRecognized extends FoodScannerEvent {
  final String recognizedText;

  const FoodScannerTextRecognized(this.recognizedText);

  @override
  List<Object?> get props => [recognizedText];
}

class FoodScannerSaveFood extends FoodScannerEvent {
  final PetFood food;

  const FoodScannerSaveFood(this.food);

  @override
  List<Object?> get props => [food];
}
