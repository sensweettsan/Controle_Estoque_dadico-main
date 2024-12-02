class Turma {
  int? idTurma;
  String turma;
  String instrutor;
  int curso;

  Turma(
      {this.idTurma,
      required this.turma,
      required this.instrutor,
      required this.curso});

  // Converter de um Map para o objeto Turma
  factory Turma.fromMap(Map<String, dynamic> map) {
    return Turma(
      idTurma: map['idTurma'],
      turma: map['Turma'],
      instrutor: map['Instrutor'],
      curso: map['Curso'],
    );
  }

  // Converter do objeto Turma para um Map
  Map<String, dynamic> toMap() {
    return {
      'idTurma': idTurma,
      'Turma': turma,
      'Instrutor': instrutor,
      'Curso': curso,
    };
  }
}
