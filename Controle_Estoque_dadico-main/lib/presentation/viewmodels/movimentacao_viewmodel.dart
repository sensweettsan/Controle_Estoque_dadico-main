import 'package:flutter/material.dart';
import '../../data/models/movimentacao_model.dart';
import '../../data/repositories/movimentacao_repository.dart';

class MovimentacaoViewModel with ChangeNotifier {
  List<Movimentacao> _movimentacoes = [];
  bool _isLoading = false;

  List<Movimentacao> get movimentacoes => _movimentacoes;
  bool get isLoading => _isLoading;

  Future<void> fetchMovimentacoes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _movimentacoes = await MovimentacaoRepository.getAllMovimentacoes();
    } catch (e) {
      debugPrint('Error fetching movimentacoes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMovimentacao(Movimentacao movimentacao) async {
    try {
      await MovimentacaoRepository.insert(movimentacao);
      _movimentacoes.add(movimentacao);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding movimentacao: $e');
    }
  }

  Future<void> deleteMovimentacao(int id) async {
    try {
      await MovimentacaoRepository.delete(id);
      _movimentacoes.removeWhere((m) => m.idMovimentacao == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting movimentacao: $e');
    }
  }
}
