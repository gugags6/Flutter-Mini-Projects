import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";

   void _opcaoSelecionada(String userChoice){
     var opcoes = ["pedra", "papel", "tesoura"];
     var numero = Random().nextInt(3);
     var escolhaApp = opcoes[numero];
      print(userChoice);
     print(escolhaApp);

     //exibir imagem escolhida pelo app
     setState(() {
       this._imagemApp = AssetImage("images/"+escolhaApp+".png");
     });

     //Valida ganhador
     if(
          (userChoice == "pedra" && escolhaApp == "tesoura") ||
          (userChoice == "tesoura" && escolhaApp == "papel")||
          (userChoice == "papel" && escolhaApp == "pedra")
     ){
       setState(() {
         this._mensagem = "Parabens voce ganhou, cachorra!";
       });

     }else if(
           (escolhaApp == "pedra" && userChoice == "tesoura")||
           (escolhaApp == "tesoura" && userChoice == "papel")||
           (escolhaApp == "papel" && userChoice == "pedra")
     ){
       setState(() {
         this._mensagem = "Pena, você perdeu vadia!";
       });
     }else{
       setState(() {
         this._mensagem = "Eita!Empatou essa caralha";
       });
     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joken Po"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:32, bottom: 16),
          child: Text(
            "Escolha do App",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          ),
          Image(
            image: this._imagemApp,
          ),
          Padding(
            padding: EdgeInsets.only(top:32, bottom: 16),
            child: Text(
              this._mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             GestureDetector(
               onTap: ()=>_opcaoSelecionada("pedra"),
               child: Image.asset("images/pedra.png", height: 95,),
             ),
             GestureDetector(
               onTap: ()=>_opcaoSelecionada("papel"),
               child: Image.asset("images/papel.png", height: 95,),
             ),
             GestureDetector(
               onTap: ()=>_opcaoSelecionada("tesoura"),
               child: Image.asset("images/tesoura.png", height: 95,),
             )
             /*
             Image.asset("images/pedra.png", height: 95,),
             Image.asset("images/papel.png", height: 95,),
             Image.asset("images/tesoura.png", height: 95,)*/

           ],
         )
        ],
      ),
    );
  }
}
