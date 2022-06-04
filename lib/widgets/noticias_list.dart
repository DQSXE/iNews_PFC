import 'package:flutter/material.dart';
import 'package:i_news/db/db.dart';
import 'package:i_news/db/models_db/noticia.dart';
import 'package:i_news/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_news/pages/noticia_web.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';


class Noticias extends StatelessWidget {

  final List<Article> noticias;

  const Noticias( this.noticias );


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {


        return _Noticia( noticia: this.noticias[index], index: index );
     }
    );
  }
}


class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({ 
    this.noticia, 
    this.index 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        //TarjetaImagen9(noticia),

        NewsCard(noticia)

        /*SizedBox( height: 10 ),
        Divider(),*/
        

      ],
    );
  }
}



class _TarjetaImagen2 extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen2( this.noticia );


  @override
  Widget build(BuildContext context) {
    return Container(
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
                              noticia.source.name,
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
                          noticia.title,
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

               Align(
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
                        child: Icon(Icons.bookmark),
                        ),
                      color: Colors.blueAccent,
                      onPressed: ()  async {
                        

                        Noticia noticiaTemp = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

                        

                        const snackbarSucess = SnackBar(
                          content: Text('Noticia guardada!'),
                        );

                        const snackbarError = SnackBar(
                          content: Text('La noticia ya había sido guardada!'),
                        );
                        

                        try {
                          
                          await DB.insert(noticiaTemp);

                          ScaffoldMessenger.of(context).showSnackBar(snackbarSucess);

                          

                        } catch (e) {
                          
                          ScaffoldMessenger.of(context).showSnackBar(snackbarError);
                          print(e);
                        }



                        

                        

                      },
                    ),
                  ),
                    
              ),
               ),


              

              
              
            ],

          ),
        ),
      ),
      decoration: BoxDecoration(
              image: (noticia.urlToImage != null)
                ? DecorationImage(image: NetworkImage(noticia.urlToImage),
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
    );
  }
}

class TarjetaImagen3 extends StatefulWidget {
  
  final Article noticia;

  const TarjetaImagen3( this.noticia );

  @override
  _TarjetaImagen3State createState() => _TarjetaImagen3State( this.noticia );
}




class _TarjetaImagen3State extends State<TarjetaImagen3> {
  
  final Article noticia;

  _TarjetaImagen3State( this.noticia );


  


  Future<bool> comprobarNoticia(bool guardado) async {

    Noticia noticiaTemp2 = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

    var comprobacion = await DB.getNoticia(noticiaTemp2);

    if(noticiaTemp2 == comprobacion) {

      guardado = false;


      return guardado;
    }

    else {

      return guardado;
    }
  }
  
  bool guardado = true;




  @override
  Widget build(BuildContext context) {

    return Container(
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
                              noticia.source.name,
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
                          noticia.title,
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

               Align(
                 alignment: Alignment.topRight,
                 child: Container(
                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 60,
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Ink(
                      decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: guardado ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark),
                      //icon: const Icon(Icons.bookmark),
                      color: Colors.amber,
                      onPressed: () async {

                        Noticia noticiaTemp = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

                        

                        const snackbarSucess = SnackBar(
                          content: Text('Noticia guardada!'),
                        );

                        const snackbarError = SnackBar(
                          content: Text('Noticia eliminada!'),
                        );

                        
                        

                        try {
                          
                          await DB.insert(noticiaTemp);

                          ScaffoldMessenger.of(context).showSnackBar(snackbarSucess);


                          guardado = !guardado;
                          

                        } catch (e) {
                          
                          DB.delete(noticiaTemp);
                          
                          guardado = !guardado;
                          ScaffoldMessenger.of(context).showSnackBar(snackbarError);
                          

                        }

                        

                        

                        
                        

                        setState(() {});
                      },
                    ),
                  ),
                    
              ),
                 ),
               ),


              

              
              
            ],

          ),
        ),
      ),
      decoration: BoxDecoration(
              image: (noticia.urlToImage != null)
                ? DecorationImage(image: NetworkImage(noticia.urlToImage),
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
    );
  }
}


//TARJETA DEFINITIVA
class TarjetaImagen9 extends StatefulWidget {
  
  final Article noticia;

  const TarjetaImagen9( this.noticia );

  @override
  _TarjetaImagen9State createState() => _TarjetaImagen9State( this.noticia );
}


class _TarjetaImagen9State extends State<TarjetaImagen9> {
  
  final Article noticia;

  _TarjetaImagen9State( this.noticia );


  // ignore: missing_return
  Future<bool> comprobarNoticia(bool guardadoTemp) async {

    Noticia noticiaTemp2 = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

    var comprobacion = await DB.getNoticia(noticiaTemp2);

    if(noticiaTemp2 == comprobacion) {

      print("NO ES IGUAAAAL");

      guardado = true;

      return guardado;
    }

    else {
      
      print("ES IGUAAAAL");
       guardado = false;
    }
  }
  
  bool guardado = true;



  reflejarNoticia() async {

    Noticia noticiaTemp = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

                                

    const snackbarSucess = SnackBar(
      content: Text('Noticia guardada!'),
      backgroundColor: Colors.blue,
      
    );

    const snackbarError = SnackBar(
      content: Text('Noticia eliminada!'),
      backgroundColor: Colors.blue,
    );

    
    

    try {
      
      await DB.insert(noticiaTemp);

      ScaffoldMessenger.of(context).showSnackBar(snackbarSucess);


      guardado = !guardado;
      

    } catch (e) {
      
      DB.delete(noticiaTemp);
      
      guardado = !guardado;
      ScaffoldMessenger.of(context).showSnackBar(snackbarError);
      

    }
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPage(noticia.url)));

      },

      onDoubleTap: () async {

        await reflejarNoticia();

        setState(() {});

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
                        noticia.source.name,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.center,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                              Colors.blue[800].withOpacity(0.2),
                              Colors.blue[800].withOpacity(0.2),
                              Colors.blue[800].withOpacity(0.3),
                              Colors.blue[800].withOpacity(0.4),
                              Colors.blue[800].withOpacity(0.4),
                              Colors.blue[800].withOpacity(1.0),
                              ],
                              tileMode: TileMode.clamp,
                              stops: [
                                0.3,
                                0.4,
                                0.5,
                                0.6,
                                0.6,
                                0.9
                              ]
                            )
                          ),
                                width: double.infinity,
                                child: Text(
                                  noticia.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: GoogleFonts.oswald(
                                    color: Colors.grey[50]
                                  ),
                                  textScaleFactor: 1.5,

                                ),
                          ),
                      ),
                      ),

                      /*Container(
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black,
                            ],
                            stops: [
                            0.0,
                            1.0
                            ]
                          )
                        ),
                      )*/

                  ],
                    
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                ),

                 Align(
                   alignment: Alignment.topRight,
                   child: Container(
                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    width: 60,
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,        
                      child: FutureBuilder(
                        future: comprobarNoticia(guardado),
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

                            return IconButton(
                              icon: guardado ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark),
                              color: Colors.amber,
                              onPressed: () async {

                                reflejarNoticia();

                                setState(() {});
                              },
                            );
                        }
                      ),
                  ),
                    
              ),
                  ),


              

              ],

              
      

            ),
          ),
        ),
        decoration: BoxDecoration(
          image: (noticia.urlToImage != null)
            ? DecorationImage(image: NetworkImage(noticia.urlToImage),
                fit: BoxFit.cover,
                
            )
            : DecorationImage(image: NetworkImage('https://www.linianclip.co.uk/wp-content/uploads/2021/09/Loading-Gif.gif'),
                fit: BoxFit.cover
            ),
          borderRadius: BorderRadius.all(Radius.circular(10)),


                

        ),
        
      ),
    );
  }
}






















class NewsCard extends StatefulWidget {

  final Article noticia;

  NewsCard( this.noticia );

  @override
  _NewsCardState createState() => _NewsCardState(this.noticia);
}

class _NewsCardState extends State<NewsCard> {

  final Article noticia;
  bool canVibrate = false;

  _NewsCardState( this.noticia );

  @override
  void initState() {
    super.initState();
    
  }

  
  

  // ignore: missing_return
  Future<bool> comprobarNoticia(bool guardadoTemp) async {

    Noticia noticiaTemp2 = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

    var comprobacion = await DB.getNoticia(noticiaTemp2);

    if(noticiaTemp2 == comprobacion) {

      print("NO ES IGUAAAAL");

      guardado = true;

      return guardado;
    }

    else {
      
      print("ES IGUAAAAL");
       guardado = false;
    }
  }
  
  bool guardado = true;



  reflejarNoticia() async {

    Noticia noticiaTemp = new Noticia(id: noticia.title ,titulo: noticia.title, nombreFuente: noticia.source.name, contenido: noticia.content, urlImagen: noticia.urlToImage, url: noticia.url);

    const snackbarSucess = SnackBar(
      content: Text('Noticia guardada!'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 1),
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      behavior: SnackBarBehavior.floating,
    );

    var snackbarError = SnackBar(
      content: Text('Noticia eliminada!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
      shape: RoundedRectangleBorder( 
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      behavior: SnackBarBehavior.floating,
      
    );

    
    

    try {
      
      await DB.insert(noticiaTemp);

      ScaffoldMessenger.of(context).showSnackBar(snackbarSucess);


      guardado = !guardado;
      

    } catch (e) {
      
      DB.delete(noticiaTemp);
      
      guardado = !guardado;
      ScaffoldMessenger.of(context).showSnackBar(snackbarError);
      

    }
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPage(noticia.url)));

      },

      onDoubleTap: () async {

        await reflejarNoticia();

        setState(() {});

      },


      onLongPress: () {
        
        Share.share("Mira esta noticia: \n\n ${noticia.title} \n\n ${noticia.url} \n\n ${noticia.source.name}");
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
                            imageUrl: noticia.urlToImage,
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
                      /*Container(
                        height: 100,
                        width: 120,
                        child: Image(
                          image: CachedNetworkImage(
                            imageUrl: 'assets',
                          )),*/
                        /*decoration: BoxDecoration(
                          image: (noticia.urlToImage != null)
                            ? DecorationImage(
                              image: NetworkImage('',
                              ),
                              fit: BoxFit.cover,
                              
                            )
                            : DecorationImage(
                              image: AssetImage('assets/loading.gif'),
                                fit: BoxFit.cover
                            ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),*/
                    //),
                      const SizedBox(width: 16.0, height: 110),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  widget.noticia.source.name,
                                  style: Theme.of(context).textTheme.caption,
                                ),

                                Container(
                                  height: 30,
                                  margin: EdgeInsets.only(left: 160, bottom: 5),
              
                                  child: FutureBuilder(
                                    future: comprobarNoticia(guardado),
                                    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

                                    return IconButton(
                                      splashRadius: 1,
                                      icon: guardado ? Icon(Icons.bookmark_border) : Icon(Icons.bookmark),
                                      color: Colors.amber,
                                      onPressed: () async {

                                        reflejarNoticia();

                                        setState(() {});
                                      },
                                    );
                                    }           
                                  )
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Container(
                                width: 170,
                                child: Text(
                                  widget.noticia.title,
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
            height: 10,
          )
        ],
      ),
    );
  }
}