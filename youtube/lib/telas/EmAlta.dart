import 'package:flutter/material.dart';

import '../api.dart';
import '../model/Video.dart';
import 'VideoScreen.dart';

class EmAlta extends StatefulWidget {

  String pesquisa;
  EmAlta(this.pesquisa);


  @override
  State<EmAlta> createState() => _EmAltaState();
}

class _EmAltaState extends State<EmAlta> {
  get imagem => null;

  _listarVideos(String pesquisa){
    Future<List<Video>?> videos;
    Api api = Api();
    videos = api.search(pesquisa)  ;

    return videos;
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>?>(
      future: _listarVideos(widget.pesquisa),
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasData){
              return ListView.separated(
                  itemBuilder: (context,index){
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];


                    return GestureDetector(



                      onTap:()=>Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_)=> VideoScreen( video.id!),
                        ),
                      ),


                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(video.imagem ?? "")
                                )
                            ),
                          ),
                          ListTile(
                            title: Text(video.titulo ?? ""),
                            subtitle: Text(video.canal ?? ""),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index)=> Divider(
                    height: 3,
                    color: Colors.red,
                  ),
                  itemCount: snapshot.data!.length);
            }else{
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
