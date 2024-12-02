import 'package:flutter/material.dart';

import '../../data/models/turma_model.dart';
import '../../data/repositories/turma_repository.dart';

class TurmaViewModel with ChangeNotifier {
  List<Turma> _turmas = [];
  bool _isLoading = false;

  List<Turma> get turmas => _turmas;
  bool get isLoading => _isLoading;

  Future<void> fetchTurmas() async {
    _isLoading = true;
    notifyListeners();

    try {
      _turmas = await TurmaRepository.getAllTurmas();
    } catch (e) {
      debugPrint('Error fetching turmas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTurma(Turma turma) async {
    try {
      await TurmaRepository.insert(turma);
      _turmas.add(turma);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding turma: $e');
    }
  }

  Future<void> updateTurma(Turma turma) async {
    try {
      await TurmaRepository.update(turma);
      int index = _turmas.indexWhere((t) => t.idTurma == turma.idTurma);
      if (index != -1) {
        _turmas[index] = turma;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating turma: $e');
    }
  }

  Future<void> deleteTurma(int id) async {
    try {
      await TurmaRepository.delete(id);
      _turmas.removeWhere((t) => t.idTurma == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting turma: $e');
    }
  }
}
