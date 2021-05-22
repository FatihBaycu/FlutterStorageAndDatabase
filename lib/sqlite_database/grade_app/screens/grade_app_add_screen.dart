import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/dao/grade_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/models/grade.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/screens/grade_app_home_screen.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/validators/grade_validator.dart';

class GradeAppAddScreen extends StatefulWidget {
  @override
  _GradeAppAddScreenState createState() => _GradeAppAddScreenState();
}

class _GradeAppAddScreenState extends State<GradeAppAddScreen>{
  var lessonName = TextEditingController();
  var grade_1 = TextEditingController();
  var grade_2 = TextEditingController();
  var formKey = GlobalKey<FormState>();

    Grade grade=new Grade(0, "", 0, 0);
    GradeValidator gradeValidator=GradeValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: lessonName,
                    onSaved: (String value){
                      grade.lesson_name=lessonName.text;

                    },
                    validator: (value) {

                    return  GradeValidator.checkLessonName(value);

                    },
                    decoration: InputDecoration(
                        labelText: "Lesson Name", border: OutlineInputBorder()),
                  ),
                  Divider(),
                  TextFormField(
                    controller: grade_1,
                    onSaved: (String value){
                      grade.grade_1=int.tryParse(grade_1.text);
                    },
                    validator:(value){
                     int g=int.tryParse(value);
                     if(g==null)
                       {
                         return "cant be null";
                       }
                     else if(g<0|| g>100)
                     return "grade number must be 0 between 100";

                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Grade 1", border: OutlineInputBorder()),
                  ),
                  Divider(),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: grade_2,
                    onSaved: (String value){
                      grade.grade_2=int.tryParse(grade_2.text);

                    },

                    validator:(value){
                      int g=int.tryParse(value);
                      if(g==null)
                      {
                        return "cant be null";
                      }
                      else if(g<0|| g>100)
                        return "grade number must be 0 between 100";

                    },

                    decoration: InputDecoration(
                        labelText: "Grade 2", border: OutlineInputBorder()),
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                        child: Text("Add"),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            GradeDao().addGrade(grade);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GradeAppHomeScreen()));
                          } else {}
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
