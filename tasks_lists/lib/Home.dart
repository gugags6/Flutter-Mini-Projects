import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  Map <String,dynamic> _ultimoRemovido = Map();
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }


  _salvarArquivo() async {

    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);

    arquivo.writeAsString(dados);

  }

  _lerArquivo() async{
    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();
    }catch(e){
      return null;
    }
  }

  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;

    Map<String,dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });


    _salvarArquivo();
    _controllerTarefa.text="";

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lerArquivo().then((dados){
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

Widget criarItemLista(context,index){

  //final item = _listaTarefas[index]["titulo"] ;

  return  Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),


      onDismissed: (direction){
        //recuperas item excluido
        _ultimoRemovido = _listaTarefas[index];

        //remove item
        _listaTarefas.removeAt(index);
        _salvarArquivo();

        //exibe snackbar
        final snackbar = SnackBar(
          backgroundColor: Colors.greenAccent,
            duration: Duration(seconds: 5),
            content: Text("Tarefa removida"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: (){

              //insere na lista de novo
              setState(() {
                _listaTarefas.insert(index, _ultimoRemovido);
                _salvarArquivo();
              });

            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      child: CheckboxListTile(
        title: Text(_listaTarefas[index]['titulo']),
        value: _listaTarefas[index]['realizada'],
        onChanged: (valorAlterado){
          setState(() {
            _listaTarefas[index]['realizada'] = valorAlterado;
          });

          _salvarArquivo();
        },
      )
  );
}

  @override
  Widget build(BuildContext context) {
    //_salvarArquivo();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(


          elevation: 15,
          //mini: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar tarefa"),
                    content: TextField(
                      controller: _controllerTarefa,
                      decoration: InputDecoration(
                        labelText: "Digite sua tarefa"
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: [
                      TextButton(
                          onPressed: ()=>Navigator.pop(context),
                          child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: (){
                          _salvarTarefa();
                          Navigator.pop(context);
                        },
                        child: Text("Salvar"),
                      )
                    ],
                  );
                }
                );
          },
        ),
      body: Column(
        children: [
         Expanded(
           child: ListView.builder(
             itemCount: _listaTarefas.length,
             itemBuilder: criarItemLista
           ),
         )
        ],
      )
    );
  }



}

