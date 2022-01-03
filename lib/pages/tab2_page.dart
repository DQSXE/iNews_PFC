import 'package:flutter/material.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/widgets/noticias_saved.dart';





class Tab2Page extends StatefulWidget {
  

  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> with AutomaticKeepAliveClientMixin{

  bool _isLoading;


  @override
  void initState() {
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    Listado listado = new Listado();
 

    return Scaffold(
      
      body: _isLoading
          ? GrupoEstructuraTarjeta(35)
          : Listado(),

      backgroundColor: _isLoading
          ? Colors.black.withOpacity(0.02)
          : Colors.white,
   );
  }

  @override
  bool get wantKeepAlive => true;
}



