import 'package:controle_estoque_dadico/data/models/medida_model.dart';
import '../../core/database_helper.dart';

class MedidaRepository {
  static Future<int> insert(Medida medida) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Medida', medida.toMap());
  }

  static Future<Medida?> getMedidaById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Medida',
      where: 'idMedida = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Medida.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Medida>> getAllMedidas() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Medida');
    return List.generate(maps.length, (i) => Medida.fromMap(maps[i]));
  }

  static Future<int> update(Medida medida) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Medida',
      medida.toMap(),
      where: 'idMedida = ?',
      whereArgs: [medida.idMedida],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Medida',
      where: 'idMedida = ?',
      whereArgs: [id],
    );
  }
}
