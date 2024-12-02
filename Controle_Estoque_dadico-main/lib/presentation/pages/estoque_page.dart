import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/database_helper.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  EstoquePageState createState() => EstoquePageState();
}

class EstoquePageState extends State<EstoquePage> {
  late Database database;
  List<Map<String, dynamic>> estoque = [];

  // Controladores de texto
  late TextEditingController _nomeController;
  late TextEditingController _medidaController;
  late TextEditingController _localController;
  late TextEditingController _quantidadeController;
  late TextEditingController _quantidadeEditController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _medidaController = TextEditingController();
    _localController = TextEditingController();
    _quantidadeController = TextEditingController();
    _quantidadeEditController = TextEditingController();
    _initDatabase();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _medidaController.dispose();
    _localController.dispose();
    _quantidadeController.dispose();
    _quantidadeEditController.dispose();
    super.dispose();
  }

  Future<void> _initDatabase() async {
    database = await DatabaseHelper.initDb();
    _fetchEstoque();
  }

  Future<void> _fetchEstoque() async {
    final List<Map<String, dynamic>> produtos =
        await database.query('Produtos');
    setState(() {
      estoque = produtos;
    });
  }

  Future<void> _addProduto(
      String nome, int medida, String local, int saldo) async {
    await database.insert(
      'Produtos',
      {
        'Nome': nome,
        'Medida': medida,
        'Local': local,
        'Entrada': saldo,
        'Saida': 0,
        'Saldo': saldo,
        'Codigo': 'AUTO',
        'DataEntrada': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _fetchEstoque();
  }

  Future<void> _updateQuantidade(int id, int novaQuantidade) async {
    await database.update(
      'Produtos',
      {'Saldo': novaQuantidade},
      where: 'idProdutos = ?',
      whereArgs: [id],
    );
    _fetchEstoque();
  }

  Future<void> _deleteProduto(int id) async {
    await database.delete(
      'Produtos',
      where: 'idProdutos = ?',
      whereArgs: [id],
    );
    _fetchEstoque();
  }

  void _showEditQuantidadeDialog(int id, int quantidadeAtual) {
    _quantidadeEditController.text = quantidadeAtual.toString();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar Quantidade'),
          content: TextField(
            controller: _quantidadeEditController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nova Quantidade'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final novaQuantidade =
                    int.tryParse(_quantidadeEditController.text) ??
                        quantidadeAtual;
                _updateQuantidade(id, novaQuantidade);
                Navigator.pop(dialogContext);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Estoque'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Fechar o aplicativo
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: estoque.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nenhum produto no estoque!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showAddProdutoDialog,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    child: const Text('Adicionar Produto'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: estoque.length,
                    itemBuilder: (context, index) {
                      final item = estoque[index];
                      return ListTile(
                        title: Text('${item['Nome']} (${item['Local']})'),
                        subtitle: Text('Quantidade: ${item['Saldo']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _showEditQuantidadeDialog(
                                    item['idProdutos'], item['Saldo']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                _updateQuantidade(
                                    item['idProdutos'], item['Saldo'] + 1);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                if (item['Saldo'] > 0) {
                                  _updateQuantidade(
                                      item['idProdutos'], item['Saldo'] - 1);
                                }
                              },
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.grey),
                              onPressed: () {
                                _deleteProduto(item['idProdutos']);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddProdutoDialog();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    child: const Text('Adicionar Produto'),
                  ),
                ),
              ],
            ),
    );
  }

  void _showAddProdutoDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar Produto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _medidaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Medida (ID)'),
              ),
              TextField(
                controller: _localController,
                decoration: const InputDecoration(labelText: 'Local'),
              ),
              TextField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final nome = _nomeController.text;
                final medida = int.tryParse(_medidaController.text) ?? 0;
                final local = _localController.text;
                final quantidade =
                    int.tryParse(_quantidadeController.text) ?? 0;

                _addProduto(nome, medida, local, quantidade);

                // Para Limpar os campos após adicionar
                _nomeController.clear();
                _medidaController.clear();
                _localController.clear();
                _quantidadeController.clear();

                Navigator.pop(dialogContext);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
