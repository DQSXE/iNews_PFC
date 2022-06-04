import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_news/search/searc_delegate.dart';
import 'package:i_news/services/news.dart';
import 'package:i_news/widgets/noticias_list.dart';
import 'package:provider/provider.dart';



class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();
}


class _Tab1PageState extends State<Tab1Page> {

  bool _isLoading;


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

    final headlines = Provider.of<News>(context).headlines;

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(20, 5),
          )
          ),

        actions: [
          IconButton(
            icon: Icon( Icons.search_rounded ),
            onPressed: () => showSearch(context: context, delegate: NewsSearchDelegate()).then((value) => setState((){_isLoading = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                _isLoading = false;
              });
            });}))),
          
        ],
      ),

      body: /*( headlines.length == 0 )
          ? Center(child: CircularProgressIndicator() )
          : Loader(headlines),*/
          _isLoading || headlines.length == 0
          ? GrupoEstructuraTarjeta(15)
          : Noticias(headlines),
      
      backgroundColor: 
        _isLoading || headlines.length == 0
          ? Colors.black.withOpacity(0.02)
          : Colors.white,
   );
  }

}






class GrupoEstructuraTarjeta extends StatelessWidget {

  final double topMargin;

  GrupoEstructuraTarjeta( this.topMargin );
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: topMargin),
      child: Container(

        child: Column(
          children: [
            CartaEstructuraTarjeta(),
            CartaEstructuraTarjeta(),
            CartaEstructuraTarjeta(),
            CartaEstructuraTarjeta(),
            CartaEstructuraTarjeta(),
          ],
        ),
      ),
    );
  }
}



class CartaEstructuraTarjeta extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        PhysicalModel(

          color: Colors.white,
          elevation: 0.3,
          borderRadius: BorderRadius.circular(20),

          child: Container(

            padding: EdgeInsets.all(10),

            child: Row(
                    children: [
                      const SizedBox(width: 16.0),
                      const EstructuraTarjeta(100, 100),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 32.0 / 2),
                              const EstructuraTarjeta(20, 50),
                              const SizedBox(height: 16.0 / 2),
                              const EstructuraTarjeta(20, 170),
                              const SizedBox(height: 16.0 / 2),
                              const EstructuraTarjeta(20, 140),
                              const SizedBox(height: 8.0 / 2),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
          ),
        ),

        SizedBox(
          height: 20,
        )
      ],
    );
  }
}





class EstructuraTarjeta extends StatelessWidget {

  final double height, width;


  const EstructuraTarjeta(this.height, this.width);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
              const BorderRadius.all(Radius.circular(16))),
    );
  }
}









class LoaderGroup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30),
      child: Container(

        child: Column(
          children: [
            Loader(),
            Loader(),
            Loader(),
          ],
        ),
      ),
    );
  }
}



class Loader extends StatelessWidget {

 

  
  @override
  Widget build(BuildContext context) {

    return Container(
        height: 300,
        
        decoration: BoxDecoration(
          
          image: DecorationImage(
            image: NetworkImage('https://www.icegif.com/wp-content/uploads/loading-icegif.gif'),
            fit: BoxFit.cover
          ),
          

          color: Colors.black.withOpacity(0.04),
            borderRadius:
                const BorderRadius.all(Radius.circular(5))
        ),
    );
  }
}


