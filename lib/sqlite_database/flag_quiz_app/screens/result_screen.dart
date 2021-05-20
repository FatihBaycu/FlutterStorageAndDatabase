import 'package:flutter/material.dart';

class QuizResultScreen extends StatefulWidget {

  int trueNumber;
    QuizResultScreen({this.trueNumber});
  @override
  _QuizResultScreenState createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flag Quiz Result "),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "True: ${widget.trueNumber} False: ${5-widget.trueNumber}",
              style: TextStyle(fontSize: 30),
            ),

            Text("%${(widget.trueNumber*100)/5.toInt()} Success.",style: TextStyle(fontSize: 30,color: Colors.pink),),
            SizedBox(height:50,width: 250,child: ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("Try Again"))),
          ],
        ),
      ),
    );
  }
}
