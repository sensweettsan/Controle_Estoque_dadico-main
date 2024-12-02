class Cargo {
  int? idCargo;
  String cargo;
  String matricula;

  Cargo({this.idCargo, required this.cargo, required this.matricula});

  // Converter de um Map para o objeto Cargo
  factory Cargo.fromMap(Map<String, dynamic> map) {
    return Cargo(
      idCargo: map['idCargos'],
      cargo: map['Cargo'],
      matricula: map['Matricula'],
    );
  }

  // Converter do objeto Cargo para um Map
  Map<String, dynamic> toMap() {
    return {
      'idCargos': idCargo,
      'Cargo': cargo,
      'Matricula': matricula,
    };
  }
}
