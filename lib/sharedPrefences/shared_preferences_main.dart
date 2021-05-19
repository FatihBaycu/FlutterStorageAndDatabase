import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sharedPrefences/page_a.dart';
import 'package:shared_preferences/shared_preferences.dart';

// if you want use sharedPreferences you must be add this dependency to pubspec.yaml
// dependencies:
// flutter:
// shared_preferences:

class SharedPreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<void> dataSave() async{

    var sp=await SharedPreferences.getInstance();
    sp.setString("name","john");
    sp.setInt("age", 18);
    sp.setDouble("height", 1.78);
    sp.setBool("isSingle",true);

    var friendList=<String>[];
    friendList.add("Sofia");
    friendList.add("Walker");
    sp.setStringList("friendList",friendList);
  }
  @override
  void initState() {
    dataSave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPrefences"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PageA()));
            }, child: Text("Go"))
          ]
           ),
      ),

    );
  }
}
