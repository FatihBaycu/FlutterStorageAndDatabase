import 'package:flutter_storage_and_database/sqlite_database/film_console_app/data_access/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_console_app/models/category.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_console_app/models/director.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_console_app/models/film.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_console_app/models/film_detail.dart';

class FilmDao{

    Future<List<Film>> getAll()async{
        var db = await DbHelper.databaseAccess();

        List<Map<String,dynamic>> maps=await db.rawQuery(
            "select * from films,categories,directors WHERE films.category_id=categories.category_id and films.director_id=directors.director_id"
        );

        return List.generate(maps.length, (index) {
            var row=maps[index];
            var category=Category(row["category_id"], row["category_name"]);
            var director=Director(row["director_id"], row["director_name"]);
            var film= Film(row["film_id"], row["film_name"], row["film_year"], row["film_image"],category,director);
            return film;
        });
    }


    Future<List<FilmDetail>> getAllDifferentWay()async{
        var db = await DbHelper.databaseAccess();

        List<Map<String,dynamic>> maps=await db.rawQuery(
            "select * from films,categories,directors WHERE films.category_id=categories.category_id and films.director_id=directors.director_id"
        );

        return List.generate(maps.length, (index) {
            var row=maps[index];
            var filmDetail=FilmDetail(
                row["film_id"],
                row["film_name"],
                row["film_year"],
                row["film_image"],
                row["category_id"],
                row["category_name"],
                row["director_id"],
                row["director_name"]
            );
            return filmDetail;
        });
    }


}