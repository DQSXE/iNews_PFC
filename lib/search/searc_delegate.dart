

import 'package:flutter/material.dart';
import 'package:i_news/models/models.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/services/news.dart';
import 'package:i_news/widgets/noticias_list.dart';
import 'package:provider/provider.dart';

class NewsSearchDelegate extends SearchDelegate {

  @override
    // TODO: implement searchFieldLabel
    String get searchFieldLabel => "Buscar...";


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear_rounded),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => this.close(context, null),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
  
    if(query.trim().length == 0 ) {


      return Text('no hay valor en la query');
    }
    
    final noticiasTitularService = new News();

    return FutureBuilder(
      future: noticiasTitularService.getnoticiaTitular(this.query),
      builder: (_ , AsyncSnapshot snapshot) {
        
        
        
        

        if(snapshot.hasData) {

          List<Article> articulos = snapshot.data;



          return articulos.isEmpty
          ? GrupoEstructuraTarjeta(30)
          : Noticias(snapshot.data);
        }

        else {


          return GrupoEstructuraTarjeta(30);
        }
        

        
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return ListTile(
      title: Text('Suggestions'),
    );
  }



  Widget _showNoticias(List<Article> noticias) {
    

    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (_, i) {


        return Noticias(noticias);
      });
  }

}