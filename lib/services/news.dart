import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_news/models/category_model.dart';
import 'package:i_news/models/models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
//const _APIKEY = 'be07a2439b2f4a77a1316677396236d9';
// Primera KEY: 
const _APIKEY = '0282eff951e747f99f04443ee4804198';


class News with ChangeNotifier {
  List<Article> headlines = [];
  List<String> titles = [];
  String _selectedCategory = 'general';

  bool _isLoading = true;

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.headSideVirus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( FontAwesomeIcons.volleyballBall, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];

  Map<String, List<Article>> categoryArticles = {};

  News() {
    this.getHead();
    this.getTitles();

    categories.forEach( (item) {
      this.categoryArticles[item.name] = [];
    });

    this.getArticlesByCategory( 'business' );
    this.getArticlesByCategory( 'entertainment' );
    this.getArticlesByCategory( 'general' );
    this.getArticlesByCategory( 'health' );
    this.getArticlesByCategory( 'science' );
    this.getArticlesByCategory( 'sports' );
    this.getArticlesByCategory( 'technology' );
    
  }

  bool get isLoading => this._isLoading;
  set isLoading ( bool valor ) {

    this._isLoading = valor;
  }


  get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory( valor );
    notifyListeners();
  }

  List<Article> getArticulosCategoriaSeleccionada(String categoria) => this.categoryArticles[ categoria ];

  getHead() async{

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us');
    //final url = Uri.parse("https://newsapi.org/v2/top-headlines?apiKey=0282eff951e747f99f04443ee4804198&country=us");
    final resp = await http.get(url);

    final newsRes = newsReponseFromJson(resp.body);

    this.headlines.addAll(newsRes.articles);

    
    print(headlines);
    
    notifyListeners();
  }

  getTitles() async {

    for (var item in this.headlines) {
      
      this.titles.add(item.title);

    }

    notifyListeners();
  }

  getArticlesByCategory(String category) async {

    _selectedCategory = category;

      if ( this.categoryArticles[category].length > 0 ) {
        this._isLoading = false;
        notifyListeners();
        return this.categoryArticles[category];
      }

      final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category');
      final resp = await http.get(url);

      final newsResponse = newsReponseFromJson( resp.body );

      this.categoryArticles[category].addAll( newsResponse.articles );

      print(newsResponse.articles.first.url);

      this._isLoading = false;
      notifyListeners();
  }

  
}
