
import 'package:anotacoes_app/model/Anotacao.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helper/AnotacaoHelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = <Anotacao>[];

  _exibirTelaCadastro( { Anotacao? anotacao}){

    String textosalvaratualizar = "";
    if(anotacao==null){//salvando
      _tituloController.text = "";
      _descricaoController.text="";
      textosalvaratualizar="Salvar";
    }else{//atualiza
      _tituloController.text = anotacao.titulo;
      _descricaoController.text=anotacao.descricao;
      textosalvaratualizar="Atualizar";
    }

    showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("$textosalvaratualizar"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tituloController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Type title"
                  ),
                ),
                TextField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Type description"
                  ),
                )
              ],
            ),
            
            actions: [
              TextButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text("Cancel")
              ),
              TextButton(
                  onPressed: (){

                    _saveUpdateNote(anotacaoSel:anotacao);

                    Navigator.pop(context);

                  },
                  child: Text("$textosalvaratualizar")
              )
            ],
            
          );
        });

  }

_recuperaanotacoes() async{
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<Anotacao>? listaTemporaria = <Anotacao>[];
    for(var item in anotacoesRecuperadas){
        Anotacao anotacao = Anotacao.fromMap(item);
        listaTemporaria.add(anotacao);
    }

    setState(() {
      _anotacoes = listaTemporaria!;
    });
    listaTemporaria=null;

}

  _saveUpdateNote({Anotacao? anotacaoSel}) async{
    String title = _tituloController.text;
    String descricao = _descricaoController.text;

    if(anotacaoSel==null){//nova nota
      Anotacao anotacao = Anotacao(title,descricao, DateTime.now().toString());
      int resultado = await _db.salvaranotacao(anotacao);
    }else{//atualiza
      anotacaoSel.titulo = title;
      anotacaoSel.descricao = descricao;
      anotacaoSel.data = DateTime.now().toString();
      int resultado = await _db.atualizaNota(anotacaoSel);
    }

    _tituloController.clear();
    _descricaoController.clear();

    _recuperaanotacoes();
  }

  _removeNote( {required Anotacao anotacao}) async{
    await _db.removeNote(anotacao);
    _recuperaanotacoes();
  }

  _formatdate(String data){
    initializeDateFormatting('pt_BR', null);

   // var formatador = DateFormat("d/M/y - EEEE");
    var formatador = DateFormat.yMMMMEEEEd("pt_BR");


    DateTime dtConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dtConvertida);
    print( dataFormatada);
    return dataFormatada;


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperaanotacoes();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: _anotacoes.length,
              itemBuilder: (context,index){
                final note = _anotacoes[index];
                return Card(
                  child: ListTile(
                    title: Text(note.titulo),
                    subtitle: Text("${_formatdate(note.data)} - ${note.descricao}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (){
                            _exibirTelaCadastro(anotacao:note);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right:16),
                            child: Icon(
                              Icons.edit,
                              color:Colors.green
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _removeNote(anotacao:note);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right:0),
                            child: Icon(
                                Icons.remove_circle,
                                color:Colors.red
                            ),
                          ),
                        )
                      ],
                    ),


                  ),
                );
              }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro();
        },
      ),
    );
  }
}
