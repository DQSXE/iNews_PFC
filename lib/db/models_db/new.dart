final String tableNews = 'news';


class NewsFields {

  static final List<String> values = [

    id, titulo, nombreFuente, contenido, urlImagen, url
  ];

  
  static final String id = '_id';
  static final String titulo = 'titulo';
  static final String nombreFuente = 'nombre_fuente';
  static final String contenido = 'contenido';
  static final String urlImagen = 'urlImagen';
  static final String url = 'url';
}


class New {

  final int id;
  final String titulo;
  final String nombreFuente;
  final String contenido;
  final String urlImagen;
  final String url;

  const New({
    this.id,
    /*required*/ this.titulo,
    /*required*/ this.nombreFuente, 
    /*required*/ this.contenido, 
    /*required*/ this.urlImagen, 
    /*required*/ this.url
    });

    New copy({
      int id,
      String titulo,
      String nombreFuente,
      String contenido,
      String urlImagen,
      String url,
    }) =>

      New(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        nombreFuente: nombreFuente ?? this.nombreFuente,
        contenido:  contenido ?? this.contenido,
        urlImagen: urlImagen ?? this.urlImagen,
        url: url ?? this.url,

      );


    static New fromJson(Map<String, Object> json) => New(
           id: json[NewsFields.id] as int,
           titulo: json[NewsFields.titulo] as String,
           nombreFuente: json[NewsFields.nombreFuente] as String,
           contenido: json[NewsFields.contenido] as String,
           urlImagen: json[NewsFields.urlImagen] as String,
           url: json[NewsFields.url] as String,
    );

    Map<String, Object> toJson() => {
      NewsFields.id: id,
      NewsFields.titulo: titulo,
      NewsFields.nombreFuente: nombreFuente,
      NewsFields.contenido: contenido,
      NewsFields.urlImagen: urlImagen,
      NewsFields.url: url,
      
    }; 
}