import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/dao/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/models/dictionary.dart';

class WordDao{

      Future<List<Word>> getAll()async{

        var db=await DbHelper.accessDatabase();
        
        List<Map<String,dynamic>> maps= await db.rawQuery("select * from words");
        return List.generate(
          maps.length,
          (index){
            var row=maps[index];
            return Word(row["word_id"], row["english"], row["turkish"]);
          }

        );
      }



      Future<List<Word>> getSearchingResult(String searchText)async{

        var db=await DbHelper.accessDatabase();
        
        List<Map<String,dynamic>> maps= await db.rawQuery("select * from words where english like '%$searchText%'");
        return List.generate(
          maps.length,
          (index){
            var row=maps[index];
            return Word(row["word_id"], row["english"], row["turkish"]);
          }

        );
      }

     static Future<void> insertWord(Word word) async{
        var db =await DbHelper.accessDatabase();
        var infos=Map<String,dynamic>();
        infos["english"]=word.english;
        infos["turkish"]=word.turkish;
        db.insert("words", infos);
      }


}