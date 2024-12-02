import 'package:controle_estoque_dadico/presentation/user/register_page.dart';

import 'package:flutter/material.dart';

import 'dash_board_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // Função para navegação para a página de cadastro
  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const RegisterPage()), // Redireciona para a RegisterPage
    );
  }

  // Função para navegação para o Dashboard após o login
  void _navigateToDashboard() {
    if (usuarioController.text.isNotEmpty && senhaController.text.isNotEmpty) {
      // Validar usuário e senha, se necessário
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const DashboardPage()), // Altere para a página que deseja após login
      );
    } else {
      // Exibir erro caso não tenha preenchido os campos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Estoque'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/images.png', // Coloque o caminho da sua imagem do logo
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Bem-vindo ao App de Controle de Estoque!',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed:
                    _navigateToDashboard, // Função para navegação ao dashboard
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tem conta? '),
                  TextButton(
                    onPressed:
                        _navigateToRegister, // Função para navegação ao cadastro
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.orange), // Cor do link
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
