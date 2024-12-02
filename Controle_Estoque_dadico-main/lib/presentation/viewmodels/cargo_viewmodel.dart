import 'package:flutter/material.dart';
import '../../data/models/cargos_model.dart';
import '../../data/repositories/cargos_repository.dart';

class CargoViewModel with ChangeNotifier {
  List<Cargo> _cargos = [];
  bool _isLoading = false;

  List<Cargo> get cargos => _cargos;
  bool get isLoading => _isLoading;

  Future<void> fetchCargos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cargos = await CargoRepository.getAllCargos();
    } catch (e) {
      debugPrint('Error fetching cargos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCargo(Cargo cargo) async {
    try {
      await CargoRepository.insert(cargo);
      _cargos.add(cargo);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding cargo: $e');
    }
  }

  Future<void> updateCargo(Cargo cargo) async {
    try {
      await CargoRepository.update(cargo);
      int index = _cargos.indexWhere((c) => c.idCargo == cargo.idCargo);
      if (index != -1) {
        _cargos[index] = cargo;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating cargo: $e');
    }
  }

  Future<void> deleteCargo(int id) async {
    try {
      await CargoRepository.delete(id);
      _cargos.removeWhere((c) => c.idCargo == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting cargo: $e');
    }
  }
}
