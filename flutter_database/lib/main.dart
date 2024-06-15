import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()=> runApp(
  MaterialApp(home: Home(),
  )
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperaBancoDados() async{

    final caminhoDatabase = await getDatabasesPath();
    final localBasedados = join(caminhoDatabase, "banco.db");

    var bd = await openDatabase(
        localBasedados,
        version: 1,
      onCreate: (db,dbVersaoRecente){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER) ";
          db.execute(sql);
      }
    );
    return bd;
  }
  
  _salvar() async {
    
    Database db = await _recuperaBancoDados();
    Map<String,dynamic> dadosUsuario={
      "nome" : "Gugas yk",
      "idade" : 30
    };
    int id = await db.insert("usuarios", dadosUsuario);
    
}

_listarUsuarios() async{
  Database db = await _recuperaBancoDados();

  String sql = "SELECT * from usuarios";

  List usuarios = await db.rawQuery(sql);

  for(var usuario in usuarios){

  }

}

  @override
  Widget build(BuildContext context) {
    _salvar();
    //_recuperaBancoDados();
    return Container();
  }
}



