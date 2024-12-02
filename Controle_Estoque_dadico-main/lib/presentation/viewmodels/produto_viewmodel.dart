import 'package:flutter/material.dart';
import '../../data/models/produto_model.dart';
import '../../data/repositories/produto_repository.dart';

class ProdutoViewModel with ChangeNotifier {
  List<Produto> _produtos = [];
  bool _isLoading = false;

  List<Produto> get produtos => _produtos;
  bool get isLoading => _isLoading;

  Future<void> fetchProdutos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _produtos = await ProdutoRepository.getAllProdutos();
    } catch (e) {
      debugPrint('Error fetching produtos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduto(Produto produto) async {
    try {
      await ProdutoRepository.insert(produto);
      _produtos.add(produto);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding produto: $e');
    }
  }

  Future<void> updateProduto(Produto produto) async {
    try {
      await ProdutoRepository.update(produto);
      int index = _produtos.indexWhere((p) => p.idProduto == produto.idProduto);
      if (index != -1) {
        _produtos[index] = produto;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating produto: $e');
    }
  }

  Future<void> deleteProduto(int id) async {
    try {
      await ProdutoRepository.delete(id);
      _produtos.removeWhere((p) => p.idProduto == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting produto: $e');
    }
  }
}
