class Movimentacao {
  int? idMovimentacao;
  int idProduto;
  int idTurma;
  int idUsuario;
  String dataSaida;

  Movimentacao({
    this.idMovimentacao,
    required this.idProduto,
    required this.idTurma,
    required this.idUsuario,
    required this.dataSaida,
  });

  // Converter de um Map para o objeto Movimentacao
  factory Movimentacao.fromMap(Map<String, dynamic> map) {
    return Movimentacao(
      idMovimentacao: map['idMovimentacao'],
      idProduto: map['idProdutos'],
      idTurma: map['idTurma'],
      idUsuario: map['idUsuarios'],
      dataSaida: map['DataSaida'],
    );
  }

  // Converter do objeto Movimentacao para um Map
  Map<String, dynamic> toMap() {
    return {
      'idMovimentacao': idMovimentacao,
      'idProdutos': idProduto,
      'idTurma': idTurma,
      'idUsuarios': idUsuario,
      'DataSaida': dataSaida,
    };
  }
}
