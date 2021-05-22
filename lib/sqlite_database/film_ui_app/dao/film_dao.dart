import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/dao/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/film_detail.dart';

class FilmDao{
  static Future<List<FilmDetail>> getAll() async {
    var db = await FilmDbHelper.accessDatabase();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select * from films,directors,categories where films.category_id=categories.category_id and films.director_id=directors.director_id;");
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return FilmDetail(
        row["film_id"],
        row["film_name"],
        row["film_year"],
        row["film_image"],
        row["category_id"],
        row["category_name"],
        row["director_id"],
        row["director_name"],
      );
    });
  }

  static Future<List<FilmDetail>> getFilmsByCategory(int categoryId) async {
    var db = await FilmDbHelper.accessDatabase();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select * from films,directors,categories where films.category_id=categories.category_id and films.director_id=directors.director_id and  categories.category_id=$categoryId");
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return FilmDetail(
        row["film_id"],
        row["film_name"],
        row["film_year"],
        row["film_image"],
        row["category_id"],
        row["category_name"],
        row["director_id"],
        row["director_name"],
      );
    });
  }
}
