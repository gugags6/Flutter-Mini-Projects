import 'package:flutter/material.dart';

 class CustomSearchDelegate extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            close(context, "");
          }
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List <String>? lista = [];
    if(query.isNotEmpty){
      lista = ["Voldemort", "Harry", "Hermione", "Dumbledore"].where(
          (texto)=> texto.startsWith(query.toLowerCase())
      ).toList();
      return ListView.builder(
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                close(context, lista![index]);
              },
              title: Text(lista![index])
            );
          },
          itemCount: lista.length
      );
    }else{
      return Center(
        child: Text("No results")
      );
    }

  }

}