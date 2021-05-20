import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/data_access/flag_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/models/flag.dart';
import 'package:flutter_storage_and_database/sqlite_database/flag_quiz_app/screens/result_screen.dart';

class FlagQuizScreen extends StatefulWidget {
  const FlagQuizScreen({Key key}) : super(key: key);

  @override
  _FlagQuizScreenState createState() => _FlagQuizScreenState();
}

class _FlagQuizScreenState extends State<FlagQuizScreen> {

    var quesitons=<Flag>[];
    var wrongOptions=<Flag>[];
    Flag trueQuesiton;
    var allOptions=HashSet<Flag>();

    int questionCounter=0;
    int trueCounter=0;
    int falseCounter=0;
    String  flagImageName="placeholder.png";

    String  buttonAText="";
    String  buttonBText="";
    String  buttonCText="";
    String  buttonDText="";

    Future<void> getQuestions() async{
      quesitons=await FlagDao().getRandomFiveRow();
      loadQuestions();
    }

    Future<void> loadQuestions() async{
      quesitons=await FlagDao().getRandomFiveRow();
      trueQuesiton=quesitons[questionCounter];
      flagImageName=trueQuesiton.flag_image;
      wrongOptions=await FlagDao().getRandomThereeWrongRow(trueQuesiton.flag_id);
      allOptions.clear();
      allOptions.add(trueQuesiton);
      allOptions.add(wrongOptions[0]);
      allOptions.add(wrongOptions[1]);
      allOptions.add(wrongOptions[2]);

      buttonAText=allOptions.elementAt(0).flag_name;
      buttonBText=allOptions.elementAt(1).flag_name;
      buttonCText=allOptions.elementAt(2).flag_name;
      buttonDText=allOptions.elementAt(3).flag_name;

      setState(() {

      });

    }

    questionCounterControl(){
      questionCounter++;
      if(questionCounter!=5){
        loadQuestions();
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuizResultScreen(trueNumber:trueCounter,)));
      }
    }

    trueControl(String buttonText){

      if(trueQuesiton.flag_name==buttonText){
        trueCounter++;
      }
      else{
        falseCounter++;
      }
    }
    @override
  void initState() {

getQuestions();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flag Quiz Screen "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "True: $trueCounter",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "False: $falseCounter",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text(
              questionCounter!=5?"Quesiton :${questionCounter+1}":"Quesiton 5",
              style: TextStyle(fontSize: 16),
            ),
            Image.asset("assets/images/flag_images/$flagImageName"),
            SizedBox(height: 50,width: 250,child: ElevatedButton(child: Text(buttonAText),onPressed: (){trueControl(buttonAText); questionCounterControl();}),),
            SizedBox(height: 50,width: 250,child: ElevatedButton(child: Text(buttonBText),onPressed: (){trueControl(buttonBText);questionCounterControl();}),),
            SizedBox(height: 50,width: 250,child: ElevatedButton(child: Text(buttonCText),onPressed: (){trueControl(buttonCText);questionCounterControl();}),),
            SizedBox(height: 50,width: 250,child: ElevatedButton(child: Text(buttonDText),onPressed: (){trueControl(buttonDText);questionCounterControl();}),),
          ],
        ),
      ),
    );
  }
}
