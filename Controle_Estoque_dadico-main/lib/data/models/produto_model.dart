class Produto {
  int? idProduto;
  String nome;
  int medida;
  String local;
  int entrada;
  int saida;
  int saldo;
  String codigo;
  String dataEntrada;

  Produto({
    this.idProduto,
    required this.nome,
    required this.medida,
    required this.local,
    required this.entrada,
    required this.saida,
    required this.saldo,
    required this.codigo,
    required this.dataEntrada,
  });

  // Converter de um Map para o objeto Produto
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      idProduto: map['idProdutos'],
      nome: map['Nome'],
      medida: map['Medida'],
      local: map['Local'],
      entrada: map['Entrada'],
      saida: map['Saida'],
      saldo: map['Saldo'],
      codigo: map['Codigo'],
      dataEntrada: map['DataEntrada'],
    );
  }

  // Converter do objeto Produto para um Map
  Map<String, dynamic> toMap() {
    return {
      'idProdutos': idProduto,
      'Nome': nome,
      'Medida': medida,
      'Local': local,
      'Entrada': entrada,
      'Saida': saida,
      'Saldo': saldo,
      'Codigo': codigo,
      'DataEntrada': dataEntrada,
    };
  }
}
