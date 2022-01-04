import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:i_news/pages/tab1_page.dart';
import 'package:i_news/services/news.dart';
import 'package:i_news/widgets/noticias_list.dart';
import 'package:provider/provider.dart';





class Tab3Page extends StatefulWidget {

  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> with AutomaticKeepAliveClientMixin{

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
    final newsService = Provider.of<News>(context);

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(20, 5),
          )
          ),
          bottom: TabBar(
            isScrollable: true,
            indicator: CircleTabIndicator(color: Colors.white, radius: 3),
            labelStyle: new TextStyle(fontSize: 17.0),
            unselectedLabelStyle: new TextStyle(fontSize: 12.0),
            unselectedLabelColor: Colors.grey[400],
            dragStartBehavior: DragStartBehavior.start,
            tabs: [
              new Tab(text: "Business"),
              new Tab(text: "Entertainment"),
              new Tab(text: "General"),
              new Tab(text: "Health"),
              new Tab(text: "Science"),
              new Tab(text: "Sports"),
              new Tab(text: "Tech"),

            ],
          ),
        ),
        body: new TabBarView(
      
          children: [
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('business')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('entertainment')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('general')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('health')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('science')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('sports')),
            _isLoading 
              ? GrupoEstructuraTarjeta(10)
              : new Noticias(newsService.getArticulosCategoriaSeleccionada('technology')),
            //new Text("General"),
          ],
      ),
    
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}