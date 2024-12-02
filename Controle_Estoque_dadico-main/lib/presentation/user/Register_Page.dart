import 'package:flutter/material.dart';

import '../../data/repositories/usuarios_repository.dart';
import '../../data/models/usuarios_model.dart';
import '../../presentation/user/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController cargoController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmasenhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Função de registro
  Future<void> registerUsuario() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = emailController.text;
      final nome = nomeController.text;
      final telefone = telefoneController.text;
      final endereco = enderecoController.text;
      final cargo = int.parse(cargoController.text);
      final senha = senhaController.text;

      final usuario = UsuariosModel(
        idUsuario: null,
        nome: nome,
        email: email,
        telefone: telefone,
        endereco: endereco,
        cargo: cargo,
        senha: senha,
      );

      try {
        await UsuarioRepository.insertUsuarioModel(usuario);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Usuário registrado com sucesso!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Registro de Usuário'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crie sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Nome
                _buildTextField(
                  controller: nomeController,
                  label: 'Nome',
                  icon: Icons.person,
                ),

                // Campo Email
                _buildTextField(
                  controller: emailController,
                  label: 'E-mail',
                  icon: Icons.email,
                ),

                // Campo Telefone
                _buildTextField(
                  controller: telefoneController,
                  label: 'Telefone',
                  icon: Icons.phone,
                ),

                // Campo Endereço
                _buildTextField(
                  controller: enderecoController,
                  label: 'Endereço',
                  icon: Icons.home,
                ),

                // Campo Cargo
                _buildTextField(
                  controller: cargoController,
                  label: 'Cargo (ID)',
                  icon: Icons.work,
                  keyboardType: TextInputType.number,
                ),

                // Campo Senha
                _buildTextField(
                  controller: senhaController,
                  label: 'Senha',
                  icon: Icons.lock,
                  obscureText: true,
                ),

                // Campo Confirmar Senha
                _buildTextField(
                  controller: confirmasenhaController,
                  label: 'Confirmar Senha',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value != senhaController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Botão Registrar
                ElevatedButton(
                  onPressed: registerUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 10),

                // Botão Voltar
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Insira $label';
              }
              return null;
            },
      ),
    );
  }
}
