class Medida {
  int? idMedida;
  String medida;
  String descricao;

  Medida({this.idMedida, required this.medida, required this.descricao});

  // Converter de um Map para o objeto Medida
  factory Medida.fromMap(Map<String, dynamic> map) {
    return Medida(
      idMedida: map['idMedida'],
      medida: map['Medida'],
      descricao: map['Descricao'],
    );
  }

  // Converter do objeto Medida para um Map
  Map<String, dynamic> toMap() {
    return {
      'idMedida': idMedida,
      'Medida': medida,
      'Descricao': descricao,
    };
  }
}
