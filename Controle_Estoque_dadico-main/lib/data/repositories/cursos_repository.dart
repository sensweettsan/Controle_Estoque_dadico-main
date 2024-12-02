import '../../core/database_helper.dart';
import '../models/cursos_model.dart';

class CursoRepository {
  static Future<int> insert(Curso curso) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Cursos', curso.toMap());
  }

  static Future<Curso?> getCursoById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Cursos',
      where: 'idCursos = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Curso.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Curso>> getAllCursos() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Cursos');
    return List.generate(maps.length, (i) => Curso.fromMap(maps[i]));
  }

  static Future<int> update(Curso curso) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Cursos',
      curso.toMap(),
      where: 'idCursos = ?',
      whereArgs: [curso.idCurso],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Cursos',
      where: 'idCursos = ?',
      whereArgs: [id],
    );
  }
}
