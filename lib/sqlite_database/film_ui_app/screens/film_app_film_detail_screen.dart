import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/film_detail.dart';

class FilmAppFilmDetailScreen extends StatefulWidget {
  FilmDetail filmDetail;
  FilmAppFilmDetailScreen(this.filmDetail);

  @override
  _FilmAppFilmDetailScreenState createState() =>
      _FilmAppFilmDetailScreenState();
}

class _FilmAppFilmDetailScreenState extends State<FilmAppFilmDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.filmDetail.film_name),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 500,child: 
                           Image.asset("assets/images/film_images/${widget.filmDetail.film_image}.jpg"),
            ),
            Text(widget.filmDetail.film_year.toString(),style: TextStyle(fontSize: 30),),
            Text(widget.filmDetail.film_name,style: TextStyle(fontSize: 30)),
          ],
      ),
    ),
        ));
  }
}
