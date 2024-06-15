class Video{
   String? id;
    String? imagem;
   String? titulo;
   String? canal;
   String? descricao;

  Video({this.id, this.imagem, this.titulo, this.canal, this.descricao});

  /*static convertVideo(Map<String, dynamic>json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],

    );
  }*/

  factory Video.fromJson(Map<String, dynamic>json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelTitle"],
      descricao: json["snippet"]["description"]

    );
  }
}