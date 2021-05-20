import 'package:flutter/cupertino.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/data_access/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/models/flag.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FlagDao {
  Future<List<Flag>> getRandomFiveRow() async {
    var db = await DbHelper.accessDatabase();
  
  List<Map<String,dynamic>> maps=await db.rawQuery("select *  from flags order by random() limit 5");

  return List.generate(maps.length, (index){
    var row=maps[index];
    return Flag(row["flag_id"], row["flag_name"], row["flag_image"]);
  });
    
  }

  Future<List<Flag>> getRandomThereeWrongRow(int flag_id) async {
    var db = await DbHelper.accessDatabase();

    List<Map<String,dynamic>> maps=await db.rawQuery("select * from flags where flag_id!=$flag_id order by random() limit 3");

    return List.generate(maps.length, (index){
      var row=maps[index];
      return Flag(row["flag_id"], row["flag_name"], row["flag_image"]);
    });

  }

}
