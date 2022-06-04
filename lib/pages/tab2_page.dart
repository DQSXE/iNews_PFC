import 'package:flutter/material.dart';
import 'package:i_news/db/db.dart';
import 'package:i_news/db/models_db/noticia.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/search/searc_delegate.dart';
import 'package:i_news/widgets/noticias_saved.dart';





class Tab2Page extends StatefulWidget {
  

  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> {

    bool _isLoading;

    List<Noticia> noticias;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    
 

    return Scaffold(

      appBar:AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => showSearch(context: context, delegate: NewsSavedSearchDelegate()).then((value) => setState((){_isLoading = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _isLoading = false;
              });
            });}))),
        ],
      ),
      
      body: _isLoading
          ? GrupoEstructuraTarjeta(15)
          : Listado(),

      backgroundColor: _isLoading
          ? Colors.black.withOpacity(0.02)
          : Colors.white,
   );
  }

}



