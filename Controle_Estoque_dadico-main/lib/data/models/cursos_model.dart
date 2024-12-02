class Curso {
  int? idCurso;
  String nome;
  String turma;

  Curso({this.idCurso, required this.nome, required this.turma});

  // Converter de um Map para o objeto Curso
  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      idCurso: map['idCursos'],
      nome: map['Nome'],
      turma: map['Turma'],
    );
  }

  // Converter do objeto Curso para um Map
  Map<String, dynamic> toMap() {
    return {
      'idCursos': idCurso,
      'Nome': nome,
      'Turma': turma,
    };
  }
}
