import 'package:flutter/material.dart';

import '../../data/models/cursos_model.dart';
import '../../data/repositories/cursos_repository.dart';

class CursoViewModel with ChangeNotifier {
  List<Curso> _cursos = [];
  bool _isLoading = false;

  List<Curso> get cursos => _cursos;
  bool get isLoading => _isLoading;

  Future<void> fetchCursos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cursos = await CursoRepository.getAllCursos();
    } catch (e) {
      debugPrint('Error fetching cursos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCurso(Curso curso) async {
    try {
      await CursoRepository.insert(curso);
      _cursos.add(curso);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding curso: $e');
    }
  }

  Future<void> updateCurso(Curso curso) async {
    try {
      await CursoRepository.update(curso);
      int index = _cursos.indexWhere((c) => c.idCurso == curso.idCurso);
      if (index != -1) {
        _cursos[index] = curso;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating curso: $e');
    }
  }

  Future<void> deleteCurso(int id) async {
    try {
      await CursoRepository.delete(id);
      _cursos.removeWhere((c) => c.idCurso == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting curso: $e');
    }
  }
}
