

class Noticia {


  String id;
  String titulo;
  String nombreFuente;
  String contenido;
  String urlImagen;
  String url;



  Noticia({this.id, this.titulo, this.nombreFuente, this.contenido, this.urlImagen, this.url});

  Map<String, dynamic> toMap() {


    return { 'id': id, 'titulo': titulo, 'nombreFuente': nombreFuente, 'contenido': contenido, 'urlImagen': urlImagen, 'url': url};
  }

}