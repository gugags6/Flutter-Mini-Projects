

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' as i;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async{

  //inicializar o firebase

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;

  //Criando user com email e senha
  //String email="guga.gs67@gmail.com";
  //String senha="123456v";
  /*
  auth.createUserWithEmailAndPassword(email: email, password: senha).then((firebaseUser) {
    print("Sucesso na criacao do novo usuario");
  }).catchError((erro){
    print("Erro na criacao do usuario " + erro.toString());
  });
*/

  /*
auth.signOut();

auth.signInWithEmailAndPassword(email: email, password: senha).then((user) {
  print("Logado: " + email + senha);
}).catchError((erro){
  print(erro.toString());
});

 User user = await auth.currentUser!;
 if(user!=null){
   print("User logado");
 }else{
   print("Deslogado");
 }
*/

  //FirebaseFirestore db = FirebaseFirestore.instance;
  

  //salva ou atualiza
  //db.collection("usuarios").doc("002").set({"Sara":"250", "Thiaga":"100"});


  //adicionando e tendo o id automatico como retorno
  /*DocumentReference ref = await db.collection("noticias").add(
    {"titulo" : "Noticia 2",
    "desc":"noticia 2"}
  );

  print("item salvo:" + ref.id);

//para aduatlizar a info
  db.collection("noticias").doc("TfXfR2UYK3WdqNfGwK9V").set(
      {"titulo" : "Noticia 2 alter",
        "desc":"noticia 2 alter"}
  );
*/
  //removendo os dados
  //db.collection("noticias").doc("TfXfR2UYK3WdqNfGwK9V").delete();

  //lendo os dados
  /*DocumentSnapshot snapshot = await db.collection("usuarios").doc("001").get();

  var dados = snapshot;
 // print("dados: " + snapshot.data().toString());
  print("Dados: " + "Nome: " + dados.get("nome") + " IDADE: " + dados.get("idade") );
  */
  //revupera tudo
 /* QuerySnapshot querySnapshot = await db.collection("usuarios").get();
  for( DocumentSnapshot item in querySnapshot.docs ){
    var dados = item.data() as Map<String, dynamic>;
    print("dados de todos " + dados["nome"] + "-" + dados["idade"]);
  }*/

 /*db.collection("usuarios").snapshots().listen(
         (snapshot) {
           for(DocumentSnapshot item in snapshot.docs){
             var dados = item.data() as Map<String, dynamic>;
             print("dados usuarios:" + dados["nome"]);
           }

  }
  );*/
/*
  QuerySnapshot querySnaphot = await db.collection("usuarios")
      //.where("idade",isGreaterThan: "30")
      //.orderBy("idade", descending: false)
      //.orderBy("nome", descending: true)
      .where("nome", isGreaterThanOrEqualTo: "m")
      .where("nome", isLessThanOrEqualTo: "m" + "\uf8ff")
      .get();
  for(DocumentSnapshot item in querySnaphot.docs){
    var dados = item.data() as Map<String, dynamic>;
    print("dados usuarios:" + dados["nome"]);
}
*/
  // outra forma

  runApp( MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  XFile ?  _imagem;
  String _statusUpload = "Upload naoo iniciado";
  String _url = "null";

  Future _recuperarImagem(bool daCamera) async{
    print("imagem status: " + _imagem.toString());
    XFile ? imagemSelecionada;
    if(daCamera){
      imagemSelecionada = await _picker.pickImage(source: ImageSource.camera);
    }else{
      imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);
    }

     setState((){
      _imagem = imagemSelecionada;
    });

  }

  Future _uploadImage() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");

    if (_imagem != null) {
      i.File file = i.File(_imagem!.path);
      // Agora você tem um objeto File que pode ser usado conforme necessário
      // Por exemplo, você pode copiar, mover ou carregar o arquivo.

      // Se você deseja ler o conteúdo do arquivo em bytes, pode fazer o seguinte:
      List<int> bytes = file.readAsBytesSync();
      //fazer upload
      UploadTask task = arquivo.putFile(file );

      task.snapshotEvents.listen((TaskSnapshot event) {

        print(event.runtimeType);

        if(event.state==TaskState.running){
          setState(() {
            _statusUpload = "upload em andamento";
          });

        }else if(event.state==TaskState.success){
          setState(() {
            _statusUpload = "Upload sucesso";
          });
        }

      });

      //recypera url
       task.then((TaskSnapshot snap) {
        _recuperarUrlImagem(snap);
      } );

    }




  }

    Future _recuperarUrlImagem(TaskSnapshot snapshot) async {
      String url = await snapshot.ref.getDownloadURL();
      print("resultado url: " + url );

      setState(() {
        _url =  url;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione uma imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(_statusUpload),

            ElevatedButton (
              child:Text("Camera"),
              onPressed:(){
                _recuperarImagem(true);
              },
            ),
            ElevatedButton (
                child:Text("Galeria"),
                onPressed:(){
                  _recuperarImagem(false);
                },
            ),
            _imagem == null
                ? Container()
                : Image.file(i.File(_imagem!.path)),
              _imagem== null
                  ? Container()
                   : ElevatedButton (
                child:Text("Uplad Storage"),
                onPressed:(){
                  _uploadImage();
                },
            ),
              _url =="null"
                ?Container()
                  : Image.network(_url)
          ],
        ),
      ),
    );
  }
}



