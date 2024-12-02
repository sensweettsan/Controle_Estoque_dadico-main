import '../../core/database_helper.dart';
import '../models/turma_model.dart';

class TurmaRepository {
  static Future<int> insert(Turma turma) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Turma', turma.toMap());
  }

  static Future<Turma?> getTurmaById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Turma',
      where: 'idTurma = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Turma.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Turma>> getAllTurmas() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Turma');
    return List.generate(maps.length, (i) => Turma.fromMap(maps[i]));
  }

  static Future<int> update(Turma turma) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Turma',
      turma.toMap(),
      where: 'idTurma = ?',
      whereArgs: [turma.idTurma],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Turma',
      where: 'idTurma = ?',
      whereArgs: [id],
    );
  }
}
