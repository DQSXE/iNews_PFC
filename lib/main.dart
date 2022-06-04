import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_news/pages/tabs_page.dart';
import 'package:provider/provider.dart';
import 'package:i_news/services/news.dart';

Future main() async => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new News()),
      ],
      child: MaterialApp(
        title: "Material App",
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => TabsPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            
              
            Center(
              child: Row(
                children: [ 
                  Icon(
                    FontAwesomeIcons.newspaper,
                    size: 60.0,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "iNEWS",
                    style: GoogleFonts.quicksand(
                      fontSize: 40
                    )
                    )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            SizedBox(
              height: 1,
            ),

            Container(

              height: 300,
              child: FadeInImage(
              placeholder: AssetImage('assets/cuadro_blanco.png'), 
              image: AssetImage('assets/splash_loading.gif',)
              ),
            )

            
            
          ],
        ),
      ),
    );
  }
}