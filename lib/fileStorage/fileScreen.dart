// if you want use sharedPreferences you must be add this dependency to pubspec.yaml
// dependencies:
// flutter:
//    sdk: flutter
// path_provider:

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:MyFileStorageScreen(),
    );
  }
}

class MyFileStorageScreen extends StatefulWidget{
  @override
  _MyFileStorageScreen createState()=>_MyFileStorageScreen();
}
class _MyFileStorageScreen extends State<MyFileStorageScreen>{

  var enterTxt=TextEditingController();

  Future<void> writeData() async{
    var name=await getApplicationDocumentsDirectory();
    var appFilePath=await name.path;
    var file=File("$appFilePath/myFile.txt");
    file.writeAsString(enterTxt.text);
    enterTxt.text="";
  }


  Future<void> readData() async{
    try{
      var name=await getApplicationDocumentsDirectory();
      var appFilePath=await name.path;
      var file=File("$appFilePath/myFile.txt");

      String readData=await file.readAsString();
      enterTxt.text=readData;

    }
   catch(e){return e.toString();}
  }

  Future<void> deleteData() async{
    try{
      var name=await getApplicationDocumentsDirectory();
      var appFilePath=await name.path;
      var file=File("$appFilePath/myFile.txt");

     if(file.existsSync()){
       file.delete();
       enterTxt.text="";
     }

    }
    catch(e){return e.toString();}
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("File Storage"),),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller:enterTxt,
                  decoration: InputDecoration(hintText: "Enter data"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){writeData();}, child: Text("Write")),
                    ElevatedButton(onPressed: (){readData();}, child: Text("Read")),
                    ElevatedButton(onPressed: (){deleteData();}, child: Text("Delete"))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

}