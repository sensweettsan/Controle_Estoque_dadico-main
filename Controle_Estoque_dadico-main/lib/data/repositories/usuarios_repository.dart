import 'package:controle_estoque_dadico/data/models/usuarios_model.dart';
import '../../core/database_helper.dart';

class UsuarioRepository {
  // Método para verificar se o e-mail já existe no banco de dados
  static Future<bool> emailExists(String email) async {
    final db = await DatabaseHelper.initDb();
    final result = await db.query(
      'Usuarios',
      where: 'Email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Método para verificar se o usuário já existe pelo idUsuario
  static Future<bool> userExistsByIdUsuario(int idUsuario) async {
    final db = await DatabaseHelper.initDb();
    final result = await db.query(
      'Usuarios',
      where: 'idUsuarios = ?',
      whereArgs: [idUsuario],
    );
    return result.isNotEmpty;
  }

  // Método para login de usuário
  static Future<bool> loginUsuario(String usuario, String senha) async {
    return await verifyLogin(usuario, senha);
  }

  // Método para inserir um novo usuário
  static Future<int> insertUsuarioModel(UsuariosModel usuario) async {
    final db = await DatabaseHelper.initDb();

    // Verifica se o e-mail já existe antes de inserir
    bool emailAlreadyExists = await emailExists(usuario.email);
    if (emailAlreadyExists) {
      throw Exception('E-mail já cadastrado!');
    }

    // Insere o novo usuário
    return await db.insert('Usuarios', usuario.toMap());
  }

  // Método para obter um usuário pelo ID
  static Future<UsuariosModel?> getUsuarioById(int id) async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query(
      'Usuarios',
      where: 'idUsuarios = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UsuariosModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Método para verificar login usuarios
  static Future<bool> verifyLogin(String usuario, String senha) async {
    final db = await DatabaseHelper.initDb();
    final result = await db.query(
      'Usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [usuario, senha],
    );
    return result.isNotEmpty;
  }

  // Método para obter todos os usuários
  static Future<List<UsuariosModel>> getAllUsuarios() async {
    final db = await DatabaseHelper.initDb();
    List<Map<String, dynamic>> maps = await db.query('Usuarios');
    return List.generate(maps.length, (i) => UsuariosModel.fromMap(maps[i]));
  }

  // Método para atualizar as informações de um usuário
  static Future<int> update(UsuariosModel usuario) async {
    final db = await DatabaseHelper.initDb();
    return await db.update(
      'Usuarios',
      usuario.toMap(),
      where: 'idUsuarios = ?',
      whereArgs: [usuario.idUsuario],
    );
  }

  // Método para deletar um usuário pelo ID
  static Future<int> delete(int id) async {
    final db = await DatabaseHelper.initDb();
    return await db.delete(
      'Usuarios',
      where: 'idUsuarios = ?',
      whereArgs: [id],
    );
  }
}
