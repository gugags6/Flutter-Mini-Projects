import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDDgorNQWB3ikd4mNS1HOu_kpiiEGZ9JSE";
const ID_CHANNEL = "UCkhfuyQUD5GNulpQRJOqrGg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{

  Future<List<Video>?> search(String pesquisa) async{
    http.Response response = await http.get(
        Uri.parse(
            URL_BASE + "search?part=snippet&type=video&maxResults=100&order=date"
                "&key=$CHAVE_YOUTUBE_API&channelId=$ID_CHANNEL&q=$pesquisa"));

    if(response.statusCode == 200){
      print(response.body);
      Map<String,dynamic> dados = json.decode(response.body);
      List<Video> videos = dados["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
      }

    }
  }

