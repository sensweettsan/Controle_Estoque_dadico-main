import '../../core/database_helper.dart';
import '../models/movimentacao_model.dart';

class MovimentacaoRepository {
  static Future<int> insert(Movimentacao movimentacao) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Movimentacao', movimentacao.toMap());
  }

  static Future<Movimentacao?> getMovimentacaoById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Movimentacao',
      where: 'idMovimentacao = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Movimentacao.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Movimentacao>> getAllMovimentacoes() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Movimentacao');
    return List.generate(maps.length, (i) => Movimentacao.fromMap(maps[i]));
  }

  static Future<int> update(Movimentacao movimentacao) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Movimentacao',
      movimentacao.toMap(),
      where: 'idMovimentacao = ?',
      whereArgs: [movimentacao.idMovimentacao],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Movimentacao',
      where: 'idMovimentacao = ?',
      whereArgs: [id],
    );
  }
}
