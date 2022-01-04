

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_news/db/db.dart';
import 'package:i_news/db/models_db/noticia.dart';
import 'package:i_news/models/models.dart';
import 'package:i_news/pages/noticia_web.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/services/news.dart';
import 'package:i_news/widgets/noticias_list.dart';
import 'package:i_news/widgets/noticias_saved.dart';
import 'package:provider/provider.dart';

class NewsSearchDelegate extends SearchDelegate {

  @override
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



}


class NewsSavedSearchDelegate extends SearchDelegate {

  static final List<Noticia> historial = [];


  static actualizarHistorial(Noticia noticiaHistorial) async {

    if(await DB.getNoticia(noticiaHistorial) != noticiaHistorial) {
      
      historial.add(noticiaHistorial);
    }

    else {

    }
  }

  

  @override
    String get searchFieldLabel => "Buscar......";


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
    
    

    return FutureBuilder(
      future: DB.getNoticias(),
      builder: (_ , AsyncSnapshot snapshot) {
        
        
        
        

        if(snapshot.hasData) {

          List<Noticia> articulos = snapshot.data;


          return articulos.isEmpty
          ? GrupoEstructuraTarjeta(30)
          : ListadoSaved(this.query);
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
      title: _showCountries( historial ),
    );
  }

  Widget _showCountries( List<Noticia> noticiasSuggestion ) {

    return Flexible(
      child: ListView.builder(
        
        itemCount: historial.length,
        itemBuilder: ( context , i) {
    
          final noticiaHistorial = historial[i];
    
          return Flexible(
            child: ListTile(
              leading: SizedBox(
                height: 50,
                width: 50
                ,
                child: CachedNetworkImage(imageUrl: noticiaHistorial.urlImagen, placeholder: (context, url) => new Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/loading.gif'),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                  fit: BoxFit.cover,),
              ),
              title: Text( noticiaHistorial.titulo, maxLines: 1),
              onTap: () {
                // print( pais );
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPage(noticiaHistorial.url)));
              },
            ),
          );
    
        },
      ),
    );

  }

}