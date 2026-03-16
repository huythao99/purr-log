import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/pet_model.dart';
import '../../../data/repositories/pet_repository.dart';
import 'pet_event.dart';
import 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final PetRepository _petRepository;
  StreamSubscription<List<Pet>>? _petsSubscription;

  PetBloc(this._petRepository) : super(const PetInitial()) {
    on<PetLoadAll>(_onLoadAll);
    on<PetLoadOne>(_onLoadOne);
    on<PetAdd>(_onAdd);
    on<PetUpdate>(_onUpdate);
    on<PetDelete>(_onDelete);
    on<PetSubscribe>(_onSubscribe);
  }

  Future<void> _onLoadAll(PetLoadAll event, Emitter<PetState> emit) async {
    emit(const PetLoading());
    try {
      final pets = await _petRepository.getAllPets();
      emit(PetLoaded(pets));
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onLoadOne(PetLoadOne event, Emitter<PetState> emit) async {
    emit(const PetLoading());
    try {
      final pet = await _petRepository.getPetById(event.petId);
      if (pet != null) {
        emit(PetDetailLoaded(pet));
      } else {
        emit(const PetError('Pet not found'));
      }
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onAdd(PetAdd event, Emitter<PetState> emit) async {
    try {
      await _petRepository.addPet(event.pet);
      emit(const PetOperationSuccess('Pet added successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onUpdate(PetUpdate event, Emitter<PetState> emit) async {
    try {
      await _petRepository.updatePet(event.pet);
      emit(const PetOperationSuccess('Pet updated successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onDelete(PetDelete event, Emitter<PetState> emit) async {
    try {
      await _petRepository.deletePet(event.petId);
      emit(const PetOperationSuccess('Pet deleted successfully'));
      add(const PetLoadAll());
    } catch (e) {
      emit(PetError(e.toString()));
    }
  }

  Future<void> _onSubscribe(PetSubscribe event, Emitter<PetState> emit) async {
    await _petsSubscription?.cancel();
    _petsSubscription = _petRepository.watchAllPets().listen((pets) {
      add(const PetLoadAll());
    });
  }

  @override
  Future<void> close() {
    _petsSubscription?.cancel();
    return super.close();
  }
}
