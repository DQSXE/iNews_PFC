import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class ShowPage extends StatefulWidget {

  final String ruta;

  const ShowPage(this.ruta);
  

  @override
  _ShowPageState createState() => _ShowPageState(this.ruta);
}

class _ShowPageState extends State<ShowPage> {

  final String ruta;

  _ShowPageState(this.ruta);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },

          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text("Noticias Web"),
        ),
      ),

      body: WebView(
      initialUrl: this.ruta,
      ),
    );
  }


  
}