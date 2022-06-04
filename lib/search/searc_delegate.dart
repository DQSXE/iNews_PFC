


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_news/db/db.dart';
import 'package:i_news/db/models_db/noticia.dart';
import 'package:i_news/models/models.dart';
import 'package:i_news/services/news.dart';
import 'package:i_news/widgets/noticias_list.dart';
import 'package:i_news/widgets/noticias_saved.dart';

class NewsSearchDelegate extends SearchDelegate {

  final snackbarEmpty = SnackBar(
          
    content: Text('Debe introduci algún valor en el campo!'),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.amber,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    behavior: SnackBarBehavior.floating,
          

  );

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

      //ScaffoldMessenger.of(context).showSnackBar(snackbarEmpty);
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Debes introducir algún valor en el campo!',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              decorationThickness: 20,
              color: Colors.black.withOpacity(0.5)
            ),
          ),
        ),
      );
    }
    
    final noticiasTitularService = new News();

    return FutureBuilder(
      future: noticiasTitularService.getnoticiaTitular(this.query),
      builder: (_ , AsyncSnapshot snapshot) {
        
        
        
        

        if(snapshot.hasData) {

          List<Article> articulos = snapshot.data;



          return articulos.isEmpty
          ? Container(
            color: Colors.white,
            child: Column(
              
              children: [

                Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'No se han encontrado resultados!',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        decorationThickness: 20,
                        color: Colors.black.withOpacity(0.5)
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 255,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: 
                    AssetImage("assets/404_3.gif"),
                    fit: BoxFit.fitWidth
                    ),
                    

                  ),
                  ),
              ],
            ),
          )
          : Noticias(snapshot.data);
        }

        else {


          return Container(
            height: 670,
            
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: 
              AssetImage("assets/loading.gif"),
              
              ),
              
              

            ),
          );
        }
        

        
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(

        children: [

          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              
              

            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Busca noticias de todo el mundo!',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  decorationThickness: 20,
                  color: Colors.black.withOpacity(0.5)
                ),
              ),
            ),
          ),

          Container(
            height: 255,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: 
              AssetImage("assets/suggestions_recortada.gif"),
              fit: BoxFit.fitWidth
              ),
              

            ),
            ),
        ],
      ),
    );
    
  }



}


class NewsSavedSearchDelegate extends SearchDelegate {

  final snackbarEmpty = SnackBar(
          
    content: Text('Debe introducir algún valor en el campo!'),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.amber,
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    behavior: SnackBarBehavior.floating,
          

  );

  static final List<Noticia> historial = [];




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
        onPressed: () {

          return this.close(context, null);
        } 
      );
  }


  @override
  Widget buildResults(BuildContext context) {
  
    if(query.trim().length == 0 ) {

      
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Debes introducir algún valor en el campo!',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              decorationThickness: 20,
              color: Colors.black.withOpacity(0.5)
            ),
          ),
        ),
      );
    }
    
    

    return FutureBuilder(
      future: DB.getNoticias(),
      builder: (_ , AsyncSnapshot snapshot) {
        
        
        
        

        if(snapshot.hasData) {

          List<Noticia> articulos = snapshot.data;
          

          

          return comprobarResultaddos(articulos).isEmpty
          ? Container(
            color: Colors.white,
            child: Column(
              
              children: [

                Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'No se han encontrado resultados!',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        decorationThickness: 20,
                        color: Colors.black.withOpacity(0.5)
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 255,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: 
                    AssetImage("assets/404_3.gif"),
                    fit: BoxFit.fitWidth
                    ),
                    

                  ),
                  ),
              ],
            ),
          )
          : ListadoSaved(this.query);
        }

        else {


          return Container(
            height: 670,
            
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: 
              AssetImage("assets/loading.gif"),
              
              ),
              
              

            ),
          );
        }
        

        
      }
    );
  }

  List<Noticia> comprobarResultaddos(List<Noticia> articulos) {
    
    String queryParseada = this.query.trim().toLowerCase();

    List<Noticia> articulosBusqueda = [];
    

    for (var i = 0; i < articulos.length; i++) {
      
      String titularParseado = articulos[i].titulo.trim().toLowerCase();

      if(titularParseado.contains(queryParseada)) {

        articulosBusqueda.add(articulos[i]);
      }
    }

    return articulosBusqueda;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    

    return Container(
      color: Colors.white,
      child: Column(

        children: [

          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              
              

            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Busca en tus noticias guardadas!',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  decorationThickness: 20,
                  color: Colors.black.withOpacity(0.5)
                ),
              ),
            ),
          ),

          Container(
            height: 255,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: 
              AssetImage("assets/saved_suggestions.gif"),
              fit: BoxFit.fitWidth
              ),
              

            ),
            ),
        ],
      ),
    );
   
  }


    

}