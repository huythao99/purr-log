import 'package:equatable/equatable.dart';

import '../../../data/models/pet_model.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object?> get props => [];
}

class PetLoadAll extends PetEvent {
  const PetLoadAll();
}

class PetLoadOne extends PetEvent {
  final int petId;

  const PetLoadOne(this.petId);

  @override
  List<Object?> get props => [petId];
}

class PetAdd extends PetEvent {
  final Pet pet;

  const PetAdd(this.pet);

  @override
  List<Object?> get props => [pet];
}

class PetUpdate extends PetEvent {
  final Pet pet;

  const PetUpdate(this.pet);

  @override
  List<Object?> get props => [pet];
}

class PetDelete extends PetEvent {
  final int petId;

  const PetDelete(this.petId);

  @override
  List<Object?> get props => [petId];
}

class PetSubscribe extends PetEvent {
  const PetSubscribe();
}
