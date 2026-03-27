import 'package:equatable/equatable.dart';

import '../../../data/models/pet_model.dart';
import '../../../domain/entities/wellness_score.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object?> get props => [];
}

class PetInitial extends PetState {
  const PetInitial();
}

class PetLoading extends PetState {
  const PetLoading();
}

class PetLoaded extends PetState {
  final List<Pet> pets;

  const PetLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

class PetDetailLoaded extends PetState {
  final Pet pet;
  final WellnessScore? wellnessScore;

  const PetDetailLoaded(this.pet, {this.wellnessScore});

  @override
  List<Object?> get props => [pet, wellnessScore];
}

class PetOperationSuccess extends PetState {
  final String message;

  const PetOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PetError extends PetState {
  final String message;

  const PetError(this.message);

  @override
  List<Object?> get props => [message];
}
