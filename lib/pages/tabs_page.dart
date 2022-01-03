import 'package:flutter/material.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/pages/tab2_page.dart';
import 'package:i_news/pages/tab3_page.dart';
import 'package:i_news/search/searc_delegate.dart';
import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (_) => new _Navigation(),
        child: Scaffold(
          body: _Pages(), 
          bottomNavigationBar: _Navegar(), 
          /*appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.search_outlined) , 
                onPressed: () => showSearch(context: context, delegate: NewsSearchDelegate())
                )
            ],
          ),*/
          ));
  }
}

class _Navegar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<_Navigation>(context);

    /*return BottomNavigationBar(
      currentIndex: navigation.paginaActual,
      onTap: (i) {
        navigation.paginaAhora = i;
        print('La página actual es $i');
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Noticias"),
        BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: "Secciones"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Guardado")
      ],
    );*/

    return FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: navigation.paginaActual,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (i) {
            navigation.paginaAhora = i;
          },
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.wysiwyg_rounded),
              title: Text('Noticias'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.widgets_rounded),
              title: Text('Secciones'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.bookmark_rounded),
              title: Text('Guardado'),
            ),
          ],
        );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<_Navigation>(context);

    return PageView(
      controller: navigation.pController,
      onPageChanged: (i) {
        navigation.paginaActual;
      },
      physics: NeverScrollableScrollPhysics(),
      children: [
        //Tab1PageResponsive(),
        Tab1Page(),

        Tab3Page(),
        /*Container(
          color: Colors.yellow,
        ),*/

        Tab2Page(),

      ],
    );
  }
}

class _Navigation with ChangeNotifier {
  int _pagina = 0;
  PageController _pController = new PageController();

  int get paginaActual => this._pagina;

  set paginaAhora(int x) {
    this._pagina = x;

    _pController.animateToPage(x,
        duration: Duration(milliseconds: 200), curve: Curves.easeInQuart);

    notifyListeners();
  }

  PageController get pController => this._pController;
}
