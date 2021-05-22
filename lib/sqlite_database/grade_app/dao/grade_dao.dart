import 'package:flutter_storage_and_database/sqlite_database/grade_app/dao/db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/models/grade.dart';

class GradeDao {
  Future<List<Grade>> getAll() async {
    var db = await GradeDbHelper.accessDatabase();
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from grades");
    return List.generate(maps.length, (index) {
      var row = maps[index];
      var grades = Grade(
          row["grade_id"], row["lesson_name"], row["grade_1"], row["grade_2"]);
      return grades;
    });
  }


    Future<void> addGrade(Grade grade)async{

      var db=await GradeDbHelper.accessDatabase();
      var infos=Map<String,dynamic>();
      infos["lesson_name"]=grade.lesson_name;
      infos["grade_1"]=grade.grade_1;
      infos["grade_2"]=grade.grade_2;
      await db.insert("grades", infos);
    }

    Future<void> updateGrade(Grade grade)async{
      var db=await GradeDbHelper.accessDatabase();
      var infos=Map<String,dynamic>();
      infos["lesson_name"]=grade.lesson_name;
      infos["grade_1"]=grade.grade_1;
      infos["grade_2"]=grade.grade_2;
      await db.update("grades", infos,where: "grade_id=?",whereArgs: [grade.grade_id]);
    }

      Future<void> deleteGrade(int grade_id)async{
        var db=await GradeDbHelper.accessDatabase();
        db.delete("grades",where: "grade_id=?",whereArgs: [grade_id]);
      }
}
