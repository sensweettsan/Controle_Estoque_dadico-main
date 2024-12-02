class UsuariosModel {
  int? idUsuario;
  String nome;
  String telefone;
  String email;
  String endereco;
  int cargo;
  String senha; // Campo senha adicionado aqui

  // Construtor ajustado
  UsuariosModel({
    this.idUsuario,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.endereco,
    required this.cargo,
    required this.senha,
  });

  factory UsuariosModel.fromMap(Map<String, dynamic> map) {
    return UsuariosModel(
      idUsuario: map['idUsuarios'],
      nome: map['Nome'],
      telefone: map['Telefone'],
      email: map['Email'],
      endereco: map['Endereco'],
      cargo: map['Cargo'],
      senha: map['Senha'],
    );
  }

  // Método toMap para salvar o usuário no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'idUsuarios': idUsuario,
      'Nome': nome,
      'Telefone': telefone,
      'Email': email,
      'Endereco': endereco,
      'Cargo': cargo,
      'Senha': senha,
    };
  }
}
