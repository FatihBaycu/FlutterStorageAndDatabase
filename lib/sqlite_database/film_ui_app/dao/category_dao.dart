import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/dao/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/category.dart';

class CategoryDao{


      static Future<List<Category>> getAllCategories()async{
        var db =await FilmDbHelper.accessDatabase();
        List<Map<String,dynamic>> maps=await db.rawQuery("select * from categories");
        return List.generate(maps.length, (index){
          var row=maps[index];
          return Category(row["category_id"], row["category_name"]);
        } );
      }


}