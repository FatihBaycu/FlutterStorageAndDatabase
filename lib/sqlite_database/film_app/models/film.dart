import 'package:flutter_storage_and_database/sqlite_database/film_app/models/category.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_app/models/director.dart';

class Film{
 int film_id;
 String film_name;
 int film_year;
 String film_image;
 Category category;
 Director director;


 Film(this.film_id, this.film_name, this.film_year, this.film_image,
      this.category, this.director);
}