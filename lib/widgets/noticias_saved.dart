import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:i_news/db/models_db/noticia.dart';
import 'package:i_news/db/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_news/pages/noticia_web.dart';


class Listado extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Lista()
      );
  }
}

class Lista extends StatefulWidget {

  @override
  _MiLista createState() => _MiLista();

}

class _MiLista extends State<Lista> {

  List<Noticia> noticias = [];

  @override
  void initState() {
    cargaNoticias();
    super.initState();
  }

  cargaNoticias() async {
    List<Noticia> auxNoticia = await DB.getNoticias();

    setState(() {
      noticias = auxNoticia;
    });

  }

  @override
  Widget build(BuildContext context) {

    var noticiasReversed = new List.from(noticias.reversed);

    return ListView.builder(
        itemCount: noticias.length,
        itemBuilder:
            (context, i) =>
              Dismissible(key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container (
                    
                    color: Colors.red[400],
                    padding: EdgeInsets.only(left: 5),
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Colors.white)
                              )
                              ),
                ),
            onDismissed: (direction) async {
              await DB.delete(noticiasReversed[i]);


              final snackbarUndo = SnackBar(
                
                content: Text('Noticia eliminada!'),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Undo', 
                  textColor: Colors.white,
                  onPressed: () async {
                    await DB.insert(noticiasReversed[i]);

                    cargaNoticias();
                  }
                ),
                shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                behavior: SnackBarBehavior.floating,
                
      
              );

              ScaffoldMessenger.of(context).showSnackBar(snackbarUndo);
              

              cargaNoticias();
            },
            child: NewsCard2( noticiasReversed[i] ),
          ),
    );
  }

}


class _TarjetaImagen3 extends StatelessWidget {
  
  final Noticia noticiaSaved;

  const _TarjetaImagen3( this.noticiaSaved );


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPage(noticiaSaved.url)));
      },
      child: Container(
        height: 300,
        //margin: EdgeInsets.symmetric( vertical: 10 ),
        child: ClipRRect(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Stack(
              children: [

                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                              width: double.infinity,
                              child: Text(
                                noticiaSaved.nombreFuente,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.oswald(
                                  color: Colors.white
                                ),
                                textScaleFactor: 1.5,

                              ),
                      ),
                    ),
                    Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                          width: double.infinity,
                          child: Text(
                            noticiaSaved.titulo,
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.oswald(
                              color: Colors.white
                            ),
                            textScaleFactor: 1.5,

                          ),
                    ),
                  ),

                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),

                 /*Align(
                   alignment: Alignment.topRight,
                   child: Container(
                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    width: 60,
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        disabledColor: Colors.amber,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.bookmark_border),),
                        color: Colors.blueAccent,
                        onPressed: ()  {
                          
                          DB.delete(noticiaSaved);

                          print("NOTICIA ELIMINADA!");

                        },
                      ),
                    ),
                      
                ),
                 ),*/


                

                
                
              ],

            ),
          ),
        ),
        decoration: BoxDecoration(
                image: (noticiaSaved.urlImagen != null)
                  ? DecorationImage(image: NetworkImage(noticiaSaved.urlImagen),
                      fit: BoxFit.cover
                  )
                  : DecorationImage(image: NetworkImage('https://t4.ftcdn.net/jpg/00/38/13/73/360_F_38137330_gUbR3ZXBc5J5g4pRkaC8TYZQA62OZhx5.jpg'),
                      fit: BoxFit.cover
                  ),
                borderRadius: BorderRadius.all(Radius.circular(10)),

                gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                     /* colors: [
                        Colors.orange,
                        Colors.grey[850],
                        
                      ],*/
                      colors: [
                        Color.fromARGB(40, 24, 0, 255),
                        Color.fromARGB(100, 24, 0, 255),
                      ]

              ),
              )
      ),
    );
  }
}








class NewsCard2 extends StatefulWidget {

  final Noticia noticiaSaved;

  NewsCard2( this.noticiaSaved );

  @override
  _NewsCardState2 createState() => _NewsCardState2(this.noticiaSaved);
}

class _NewsCardState2 extends State<NewsCard2> {

  final Noticia noticiaSaved;

  _NewsCardState2( this.noticiaSaved );

  

  
  
  bool guardado = true;





  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPage(noticiaSaved.url)));

      },
      
      child: Column(
        children: [

          SizedBox(
            height: 10,
          ),

          PhysicalModel(
            
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            child: Container(

              padding: EdgeInsets.all(10),
  
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child: Container(
                          height: 100,
                          width: 120,
                          
                          child: CachedNetworkImage(
                            imageUrl: noticiaSaved.urlImagen,
                            placeholder: (context, url) => new Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/loading.gif'),
                                  fit: BoxFit.fill
                                )
                              ),
                            ),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0, height: 110),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                  widget.noticiaSaved.nombreFuente,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                          
                            
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Container(
                                width: 170,
                                child: Text(
                                  widget.noticiaSaved.titulo,
                                  maxLines: 3,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}



