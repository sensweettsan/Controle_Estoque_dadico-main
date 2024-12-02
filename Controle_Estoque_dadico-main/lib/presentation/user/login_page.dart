// O login e basicamente o home page mas serve para o homepage funcionar por isso nao deletei entao nao mecham.
import 'package:controle_estoque_dadico/presentation/pages/main_home_page.dart';
import 'package:controle_estoque_dadico/presentation/user/register_page.dart';

import 'package:controle_estoque_dadico/presentation/viewmodels/usuarios_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/usuarios_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final UsuarioViewModel usuarioViewmodel =
      UsuarioViewModel(UsuarioRepository());

  final _formKey = GlobalKey<FormState>();

  // Função de Login
  loginUsuario() async {
    if (_formKey.currentState?.validate() ?? false) {
      final usuario = usuarioController.text;
      final senha = senhaController.text;

      final loginSuccess = await usuarioViewmodel.loginUser(usuario, senha);

      if (mounted) {
        if (loginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário ou senha incorreto.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login de Usuário'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuário',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome de usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo de Senha
              TextFormField(
                controller: senhaController,
                obscureText: true, // Ocultar a senha enquanto digita
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Botão de Login
              ElevatedButton(
                onPressed: loginUsuario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 16),
              // Link para a tela de cadastro, caso o usuário não tenha uma conta
              TextButton(
                onPressed: () {
                  // Navegar para a tela de registro
                  // Exemplo (substitua RegisterPage com a sua tela de registro):
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
