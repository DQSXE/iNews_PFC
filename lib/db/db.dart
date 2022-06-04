import 'package:i_news/db/models_db/noticia.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DB {

  static Future<Database> _openDB() async {


    return openDatabase(join(await getDatabasesPath(), 'noticiass.db'),
      onCreate: (db, version) {

        return db.execute(
          "CREATE TABLE noticiass (id TEXT PRIMARY KEY NOT NULL, titulo TEXT, nombreFuente TEXT, contenido TEXT, urlImagen TEXT, url TEXT)"
        );
      }, 
      version: 1);

    
  }

  static Future<void> insert(Noticia noticia) async {

    Database database = await _openDB();


    return database.insert("noticiass", noticia.toMap());
  }

  static Future<void> delete(Noticia noticia) async {

    Database database = await _openDB();



    return database.delete("noticiass", where: "id = ?", whereArgs: [noticia.id]);
  }

  static Future<void> update(Noticia noticia) async {

    Database database = await _openDB();


    return database.update("noticiass", noticia.toMap(), where: "id = ?", whereArgs: [noticia.id]);
  }


  static Future<List<Noticia>> getNoticias() async {

    Database database = await _openDB();

    final List<Map<String, dynamic>> noticiasMap = await database.query("noticiass");


    return List.generate(noticiasMap.length, (i) => 

      Noticia(
        id: noticiasMap[i]['id'],
        titulo: noticiasMap[i]['titulo'],
        nombreFuente: noticiasMap[i]['nombreFuente'],
        contenido: noticiasMap[i]['contenido'],
        urlImagen: noticiasMap[i]['urlImagen'],
        url: noticiasMap[i]['url']
      )
    );
  }


  static Future<Noticia> getNoticia(Noticia noticia) async {

    Database database = await _openDB();

    
    //final Noticia noticia = await database.query("noticiass", where: "id = ?", whereArgs: [noticia.id]);
    List<Map<String,dynamic>> resultadoMap = await database.rawQuery('SELECT * FROM noticiass WHERE id = "${noticia.id}"');

    var resultadoFinal = List.generate(resultadoMap.length, (i) => 
        Noticia(
        id: resultadoMap[i]['id'],
        titulo: resultadoMap[i]['titulo'],
        nombreFuente: resultadoMap[i]['nombreFuente'],
        contenido: resultadoMap[i]['contenido'],
        urlImagen: resultadoMap[i]['urlImagen'],
        url: resultadoMap[i]['url']));

    return resultadoFinal[0];
  }

  static Future<List<Noticia>> getNoticiaNombre(Noticia noticia) async {

    Database database = await _openDB();

    
    //final Noticia noticia = await database.query("noticiass", where: "id = ?", whereArgs: [noticia.id]);
    List<Map<String,dynamic>> resultadoMap = await database.rawQuery('SELECT * FROM noticiass WHERE titulo = "%${noticia.titulo}%"');

    var resultadoFinalNombre = List.generate(resultadoMap.length, (i) => 
        Noticia(
        id: resultadoMap[i]['id'],
        titulo: resultadoMap[i]['titulo'],
        nombreFuente: resultadoMap[i]['nombreFuente'],
        contenido: resultadoMap[i]['contenido'],
        urlImagen: resultadoMap[i]['urlImagen'],
        url: resultadoMap[i]['url']));

    return resultadoFinalNombre;
  }

  static Future<List<Noticia>> getNoticiasNombres(String titular) async {

    Database database = await _openDB();

    
    //final Noticia noticia = await database.query("noticiass", where: "id = ?", whereArgs: [noticia.id]);
    List<Map<String,dynamic>> resultadoMap = await database.rawQuery('SELECT * FROM noticiass WHERE titulo = "%${titular}%"');

    var resultadoFinalNombre = List.generate(resultadoMap.length, (i) => 
        Noticia(
        id: resultadoMap[i]['id'],
        titulo: resultadoMap[i]['titulo'],
        nombreFuente: resultadoMap[i]['nombreFuente'],
        contenido: resultadoMap[i]['contenido'],
        urlImagen: resultadoMap[i]['urlImagen'],
        url: resultadoMap[i]['url']));

    return resultadoFinalNombre;
  }
}