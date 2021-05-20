import 'package:flutter_storage_and_database/sqlite_database/first_app/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/first_app/models/persons.dart';

class PersonsDao {
  static Future<List<Persons>> getAll() async {
    var db = await DbHelper.databaseAccess();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM persons");

    return List.generate(maps.length, (index) {
      var column = maps[index];

      return Persons(
          column["person_id"], column["person_name"], column["person_age"]);
    });
  }

  static Future<void> addPerson(Persons person) async {
    var db = await DbHelper.databaseAccess();
    var infos = Map<String, dynamic>();
    infos["person_name"] = person.person_name;
    infos["person_age"] = person.person_age;

    await db.insert("persons", infos);
  }

  static Future<void> updatePerson(Persons person) async {
    var db = await DbHelper.databaseAccess();
    var infos = Map<String, dynamic>();
    infos["person_id"] = person.person_id;
    infos["person_name"] = person.person_name;
    infos["person_age"] = person.person_age;

    await db.update("persons", infos,
        where: "person_id=?", whereArgs: [person.person_id]);
  }

  static Future<void> deletePerson(int person_id) async {
    var db = await DbHelper.databaseAccess();
    await db.delete("persons", where: "person_id=?", whereArgs: [person_id]);
  }

  static Future<int> existControl(Persons person) async{
    var db=await DbHelper.databaseAccess();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT COUNT(*) as result FROM persons WHERE person_name=?",[person.person_name]);
    return maps[0]["result"];
  }

  static Future<Persons> getById(int person_id)async{
    var db=await DbHelper.databaseAccess();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM persons WHERE person_id=?",[person_id]);
      var row=maps[0];
    return Persons(
        row["person_id"], row["person_name"], row["person_age"]);
  }




  static Future<List<Persons>> searchPerson(String searchName)async{

    var db= await DbHelper.databaseAccess();
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * FROM persons WHERE person_name LIKE '%$searchName%'");
    return List.generate(maps.length, (index) {
      var column = maps[index];

      return Persons(
          column["person_id"], column["person_name"], column["person_age"]);
    });
  }


  static Future<List<Persons>> getTwoRandom() async {
    var db = await DbHelper.databaseAccess();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM persons ORDER BY RANDOM() LIMIT 2");

    return List.generate(maps.length, (index) {
      var column = maps[index];

      return Persons(
          column["person_id"], column["person_name"], column["person_age"]);
    });
  }
}
