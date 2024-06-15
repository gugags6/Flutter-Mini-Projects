import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCampo = TextEditingController();
  String _textosalvo = "Nada salvo";
  _salvar() async{
    String valorDigitado = _controllerCampo.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

    print("valor digitado: $valorDigitado");
  }

  _recuperar() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textosalvo = prefs.getString("nome") ?? "Sem Valor";
    });

    print("valor recuperado: $_textosalvo");

  }

  _remover() async{
    final prefs =  await SharedPreferences.getInstance();
    prefs.remove("nome");



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Manipulation"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(_textosalvo,
            style: TextStyle(
              fontSize: 20
            ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Tytpe something"
            ),
              controller: _controllerCampo,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _salvar,
                child: Text('Salvar', style: TextStyle(
                  fontSize: 20
                ),
                ),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue))

                ),
                ElevatedButton(
                    onPressed: _recuperar,
                    child: Text('Recuperar', style: TextStyle(
                        fontSize: 20
                    ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue))

                ),
                ElevatedButton(
                    onPressed: _remover,
                    child: Text('Remover', style: TextStyle(
                        fontSize: 20
                    ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue))

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
