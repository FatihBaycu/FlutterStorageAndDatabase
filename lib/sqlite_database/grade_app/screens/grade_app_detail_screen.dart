import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/dao/grade_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/models/grade.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/screens/grade_app_home_screen.dart';

class GradeAppDetailPage extends StatefulWidget {

    Grade grade;
    GradeAppDetailPage(this.grade);

  @override
  _GradeAppDetailPageState createState() => _GradeAppDetailPageState();
}

class _GradeAppDetailPageState extends State<GradeAppDetailPage> {

  var lessonName = TextEditingController();
  var grade_1 = TextEditingController();
  var grade_2 = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    var grade=widget.grade;
    lessonName.text=grade.lesson_name;
    grade_1.text=grade.grade_1.toString();
    grade_2.text=grade.grade_2.toString();

  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: Text("Grade DetailPage"),
        actions: [
          IconButton(
              onPressed: (){
                GradeDao().deleteGrade(widget.grade.grade_id);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GradeAppHomeScreen()));

              }, icon: Icon(Icons.delete)
          ),
          IconButton(icon: Icon(Icons.update), onPressed: (){
            if(formKey.currentState.validate()){
              Grade newGrade=Grade(widget.grade.grade_id, lessonName.text, int.tryParse(grade_1.text),int.tryParse(grade_2.text));
              GradeDao().updateGrade(newGrade);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GradeAppHomeScreen()));
            }

          }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child:Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  TextFormField(
                    controller: lessonName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Lesson Name",
                    ),
                  ),
                  Divider(),
                  TextFormField(
                    controller: grade_1,
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
                      border: OutlineInputBorder(),
                      hintText: "Grade 1",
                    ),
                  ),
                  Divider(),

                  TextFormField(
                    controller: grade_2,
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
                      border: OutlineInputBorder(),
                      hintText: "Grade 2",
                    ),
                  ),

                ],
              ),
            ) ,
          ),
        ),
      ),
    );
  }

  }
