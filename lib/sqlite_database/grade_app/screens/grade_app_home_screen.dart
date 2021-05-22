import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/dao/grade_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/models/grade.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/screens/grade_app_add_screen.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/screens/grade_app_detail_screen.dart';

class GradeAppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyGradeAppHomeScreen(),
    );
  }
}

class MyGradeAppHomeScreen extends StatefulWidget {
  @override
  _MyGradeAppHomeScreen createState() => _MyGradeAppHomeScreen();
}

class _MyGradeAppHomeScreen extends State<MyGradeAppHomeScreen> {
  Future<List<Grade>> getAll() async {
    var list = await GradeDao().getAll();
    return list;
  }

  Future<List<Grade>> showAllGrades() async {
    var gradeList = <Grade>[];
    var g1 = Grade(1, "lesson_name", 10, 20);
    var g2 = Grade(2, "lesson_name", 10, 20);
    var g3 = Grade(3, "lesson_name", 10, 20);
    var g4 = Grade(4, "lesson_name", 10, 20);

    gradeList.add(g1);
    gradeList.add(g2);
    gradeList.add(g3);
    gradeList.add(g4);
    return gradeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Grade App"),
            FutureBuilder<List<Grade>>(
              future: getAll(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var gradeList = snapshot.data;
                  double average = 0.0;
                  if (gradeList.isNotEmpty) {
                    double sum = 0.0;
                    for (var grade in gradeList) {
                      sum = sum + (grade.grade_1 + grade.grade_2) / 2;
                    }
                    average = sum / gradeList.length;
                  }
                  return Text("Average : $average",style: TextStyle(fontSize: 14),);
                }
                return Text("Average : 0",style:TextStyle(fontSize: 14));
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Grade>>(
        future: getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var gradeList = snapshot.data;
            return ListView.builder(
              itemCount: gradeList.length,
              itemBuilder: (context, index) {
                var grade = gradeList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GradeAppDetailPage(grade)));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            grade.lesson_name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            grade.grade_1.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            grade.grade_2.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => GradeAppAddScreen()));
        },
      ),
    );
  }
}
