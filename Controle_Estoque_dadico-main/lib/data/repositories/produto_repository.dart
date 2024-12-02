import 'package:controle_estoque_dadico/data/models/produto_model.dart';
import '../../core/database_helper.dart';

class ProdutoRepository {
  static Future<int> insert(Produto produto) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Produtos', produto.toMap());
  }

  static Future<Produto?> getProdutoById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Produtos',
      where: 'idProdutos = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Produto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Produto>> getAllProdutos() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Produtos');
    return List.generate(maps.length, (i) => Produto.fromMap(maps[i]));
  }

  static Future<int> update(Produto produto) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Produtos',
      produto.toMap(),
      where: 'idProdutos = ?',
      whereArgs: [produto.idProduto],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Produtos',
      where: 'idProdutos = ?',
      whereArgs: [id],
    );
  }
}
