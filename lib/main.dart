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

              placeholder: NetworkImage('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/572105f1-85fd-45e2-bd43-62fc2bfd3f1f/d6ynwv2-8aa475f5-90e8-4a55-a0ae-c29b133447ba.png/v1/fill/w_600,h_600,strp/fondo_png_600x600_by_smallinthisworld_d6ynwv2-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjAwIiwicGF0aCI6IlwvZlwvNTcyMTA1ZjEtODVmZC00NWUyLWJkNDMtNjJmYzJiZmQzZjFmXC9kNnlud3YyLThhYTQ3NWY1LTkwZTgtNGE1NS1hMGFlLWMyOWIxMzM0NDdiYS5wbmciLCJ3aWR0aCI6Ijw9NjAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.WiabnzAtxeV0Drh7iMbCIbtf-wMuSUjYe2QWyc4Ly8A'), 
              image: AssetImage('assets/splash_loading.gif',)
              ),
            )

            
            
          ],
        ),
      ),
    );
  }
}