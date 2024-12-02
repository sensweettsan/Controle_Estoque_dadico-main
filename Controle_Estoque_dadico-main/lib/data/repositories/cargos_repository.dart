import '../../core/database_helper.dart';
import '../models/cargos_model.dart';

class CargoRepository {
  static Future<int> insert(Cargo cargo) async {
    final db = await DatabaseHelper.initDb();
    return await db.insert('Cargos', cargo.toMap());
  }

  static Future<Cargo?> getCargoById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Cargos',
      where: 'idCargos = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Cargo.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Cargo>> getAllCargos() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Cargos');
    return List.generate(maps.length, (i) => Cargo.fromMap(maps[i]));
  }

  static Future<int> update(Cargo cargo) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Cargos',
      cargo.toMap(),
      where: 'idCargos = ?',
      whereArgs: [cargo.idCargo],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Cargos',
      where: 'idCargos = ?',
      whereArgs: [id],
    );
  }
}
