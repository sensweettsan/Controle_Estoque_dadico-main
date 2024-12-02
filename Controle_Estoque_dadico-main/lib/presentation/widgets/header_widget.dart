import 'package:flutter/material.dart';
import 'package:controle_estoque_dadico/data/models/usuarios_model.dart';

class HeaderWidget extends StatelessWidget {
  final UsuariosModel nome;

  const HeaderWidget({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.teal.shade200,
          child: Text(
            nome.nome[0], // Primeira letra do name
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            nome.nome,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
