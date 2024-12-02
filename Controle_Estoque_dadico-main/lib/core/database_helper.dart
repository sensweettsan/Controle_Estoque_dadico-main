import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'mydb.db'),
      onCreate: (db, version) async {
        // Criar a tabela 'Medida'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Medida (
            idMedida INTEGER PRIMARY KEY AUTOINCREMENT,
            Medida TEXT NOT NULL,
            Descricao TEXT NOT NULL
          )
        ''');

        // Criar a tabela 'Produtos'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Produtos (
            idProdutos INTEGER PRIMARY KEY AUTOINCREMENT,
            Nome TEXT NOT NULL,
            Medida INTEGER NOT NULL,
            Local TEXT NOT NULL,
            Entrada INTEGER NOT NULL,
            Saida INTEGER NOT NULL,
            Saldo INTEGER NOT NULL,
            Codigo TEXT NOT NULL,
            DataEntrada TEXT NOT NULL,
            FOREIGN KEY (Medida) REFERENCES Medida(idMedida)
          )
        ''');

        // Criar a tabela 'Cursos'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Cursos (
            idCursos INTEGER PRIMARY KEY AUTOINCREMENT,
            Nome TEXT NOT NULL,
            Turma TEXT NOT NULL
          )
        ''');

        // Criar a tabela 'Turma'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Turma (
            idTurma INTEGER PRIMARY KEY AUTOINCREMENT,
            Turma TEXT NOT NULL,
            Instrutor TEXT NOT NULL,
            Curso INTEGER NOT NULL,
            FOREIGN KEY (Curso) REFERENCES Cursos(idCursos)
          )
        ''');

        // Criar a tabela 'Cargos'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Cargos (
            idCargos INTEGER PRIMARY KEY AUTOINCREMENT,
            Cargo TEXT NOT NULL,
            Matricula TEXT NOT NULL
          )
        ''');

        // Criar a tabela 'Usuarios'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Usuarios (
            idUsuarios INTEGER PRIMARY KEY AUTOINCREMENT,
            Nome TEXT NOT NULL,
            Senha TEXT NOT NULL,
            Telefone TEXT NOT NULL,
            Email TEXT NOT NULL,
            Endereco TEXT NOT NULL,
            Cargo INTEGER NOT NULL,
            FOREIGN KEY (Cargo) REFERENCES Cargos(idCargos)
          )
        ''');

        // Criar a tabela 'Movimentacao'
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Movimentacao (
            idMovimentacao INTEGER PRIMARY KEY AUTOINCREMENT,
            idProdutos INTEGER NOT NULL,
            idTurma INTEGER NOT NULL,
            idUsuarios INTEGER NOT NULL,
            DataSaida TEXT NOT NULL,
            FOREIGN KEY (idProdutos) REFERENCES Produtos(idProdutos),
            FOREIGN KEY (idTurma) REFERENCES Turma(idTurma),
            FOREIGN KEY (idUsuarios) REFERENCES Usuarios(idUsuarios)
          )
        ''');
      },
      version: 1,
    );
  }
}
