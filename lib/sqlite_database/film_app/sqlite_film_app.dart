import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_app/data_access/film_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_app/models/film.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_app/models/film_detail.dart';

class SqLiteFilmAppScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySqLiteFilmAppScreen(),
    );
  }
}

class MySqLiteFilmAppScreen extends StatefulWidget {

  @override
  _SqLiteFilmAppScreen createState() => _SqLiteFilmAppScreen();
}

class _SqLiteFilmAppScreen extends State<MySqLiteFilmAppScreen> {

  Future<void>getAllFilms()async{
    var list = await FilmDao().getAll();
    for(Film film in list ){
      print(
          """
          **********
          film id:${film.film_id}
          film name:${film.film_name}
          film year:${film.film_year}
          film resim:${film.film_image}
          film category:${film.category.category_name}
          film director:${film.director.director_name}
          """
      );
    }
  }

  Future<void>getAllFilmsDifferentWay()async{
    var list = await FilmDao().getAllDifferentWay();
    for(FilmDetail filmDetail in list ){
      print(
          """
          **********
          film id:${filmDetail.film_id}
          film name:${filmDetail.film_name}
          film year:${filmDetail.film_year}
          film resim:${filmDetail.film_image}
          film category:${filmDetail.category_id}
          film category:${filmDetail.category_name}
          film category:${filmDetail.director_id}
          film director:${filmDetail.director_name}
          """
      );
    }
  }

  @override
  void initState() {
    getAllFilmsDifferentWay();
    //getAllFilms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Film App with SqLite")),
    );
  }
}