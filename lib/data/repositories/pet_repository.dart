import 'package:isar/isar.dart';

import '../datasources/database_service.dart';
import '../models/pet_model.dart';

class PetRepository {
  final DatabaseService _databaseService;

  PetRepository(this._databaseService);

  Isar get _isar => _databaseService.isar;

  Future<List<Pet>> getAllPets() async {
    return _isar.pets.where().sortByUpdatedAtDesc().findAll();
  }

  Future<Pet?> getPetById(int id) async {
    return _isar.pets.get(id);
  }

  Future<int> addPet(Pet pet) async {
    return _isar.writeTxn(() async {
      return _isar.pets.put(pet);
    });
  }

  Future<int> updatePet(Pet pet) async {
    pet.updatedAt = DateTime.now();
    return _isar.writeTxn(() async {
      return _isar.pets.put(pet);
    });
  }

  Future<bool> deletePet(int id) async {
    return _isar.writeTxn(() async {
      return _isar.pets.delete(id);
    });
  }

  Stream<List<Pet>> watchAllPets() {
    return _isar.pets.where().sortByUpdatedAtDesc().watch(fireImmediately: true);
  }

  Stream<Pet?> watchPet(int id) {
    return _isar.pets.watchObject(id, fireImmediately: true);
  }

  Future<int> getPetCount() async {
    return _isar.pets.count();
  }
}
