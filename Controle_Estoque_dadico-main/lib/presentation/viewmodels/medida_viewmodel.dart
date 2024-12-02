import 'package:flutter/material.dart';
import '../../data/models/medida_model.dart';
import '../../data/repositories/medida_repository.dart';

class MedidaViewModel with ChangeNotifier {
  List<Medida> _medidas = [];
  bool _isLoading = false;

  List<Medida> get medidas => _medidas;
  bool get isLoading => _isLoading;

  Future<void> fetchMedidas() async {
    _isLoading = true;
    notifyListeners();

    try {
      _medidas = await MedidaRepository.getAllMedidas();
    } catch (e) {
      debugPrint('Error fetching medidas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMedida(Medida medida) async {
    try {
      await MedidaRepository.insert(medida);
      _medidas.add(medida);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding medida: $e');
    }
  }

  Future<void> updateMedida(Medida medida) async {
    try {
      await MedidaRepository.update(medida);
      int index = _medidas.indexWhere((m) => m.idMedida == medida.idMedida);
      if (index != -1) {
        _medidas[index] = medida;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating medida: $e');
    }
  }

  Future<void> deleteMedida(int id) async {
    try {
      await MedidaRepository.delete(id);
      _medidas.removeWhere((m) => m.idMedida == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting medida: $e');
    }
  }
}
