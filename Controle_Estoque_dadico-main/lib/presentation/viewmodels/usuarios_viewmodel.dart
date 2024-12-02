import '../../data/models/usuarios_model.dart';
import '../../data/repositories/usuarios_repository.dart';

class UsuarioViewModel {
  final UsuarioRepository repository;

  UsuarioViewModel(this.repository);

  Future<String> registerUsuario(
      String email, String nomeUsuario, String senha, String cargo) async {
    try {
      final emailExists = await UsuarioRepository.emailExists(email);

      if (emailExists) {
        return 'Email já cadastrado.';
      }

      final usuarioModel = UsuariosModel(
        nome: nomeUsuario,
        senha: senha,
        telefone: '123456789',
        email: email,
        endereco: 'Rua exemplo',
        cargo: 1,
      );

      await UsuarioRepository.insertUsuarioModel(usuarioModel);

      return 'Usuário cadastrado com sucesso';
    } catch (e) {
      return 'Erro ao cadastrar usuário: $e';
    }
  }

  Future<bool> loginUser(String usuario, String senha) async {
    try {
      return await UsuarioRepository.verifyLogin(usuario, senha);
    } catch (e) {
      return false;
    }
  }
}
