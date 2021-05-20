import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/screens/quiz_screen.dart';

class FlagQuizHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFlagQuizHomeScreen(),
    );
  }
}

class MyFlagQuizHomeScreen extends StatefulWidget {
  @override
  _MyFlagQuizHomeScreen createState() => _MyFlagQuizHomeScreen();
}

class _MyFlagQuizHomeScreen extends State<MyFlagQuizHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flag Quiz App "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Welcome to quiz",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FlagQuizScreen()));
                }, child: Text("Start"))),
          ],
        ),
      ),
    );
  }
}
