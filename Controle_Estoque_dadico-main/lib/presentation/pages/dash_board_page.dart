import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Controle'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bem-vindo!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Número de colunas no grid
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildDashboardCard(
                    icon: Icons.inventory,
                    label: 'Gerenciar Estoque',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/estoque');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.people,
                    label: 'Administração',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, '/pessoas');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.supervisor_account,
                    label: 'Funcionários',
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/funcionarios');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.settings,
                    label: 'Configurações',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, '/configuracoes');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.2),
                ),
                child: Icon(icon, size: 40.0, color: color),
              ),
              const SizedBox(height: 10.0),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
