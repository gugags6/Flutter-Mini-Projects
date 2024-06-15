
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperaPreco() async{
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String,dynamic> retorno = json.decode(response.body);
    print(retorno.toString());

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(padding: EdgeInsets.only(top:30, bottom: 30),
              child: Text(
                "R\$ " + _preco,
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              ),
              ElevatedButton(
                onPressed: _recuperaPreco,
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.fromLTRB(30,15,30,15),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
