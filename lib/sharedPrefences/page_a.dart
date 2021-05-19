import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageA extends StatefulWidget {
  const PageA({Key key}) : super(key: key);

  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> {

  Future<void> dataRead() async{

    var sp=await SharedPreferences.getInstance();
    String name=sp.getString("name")??"empty";
    int age=sp.getInt("age")??0;
    double height=sp.getDouble("height")??0;
    bool isSingle=sp.getBool("isSingle")??false;

      var friendList=sp.getStringList("friendList")??null;
      print("name:$name\nage:$age\nheight:$height\nisSingle:$isSingle\nfriendList:$friendList");

  }
  Future<void> dataDelete() async{

    var sp=await SharedPreferences.getInstance();
      sp.remove("name");

  }
  Future<void> dataUpdate() async{

    var sp=await SharedPreferences.getInstance();
    sp.setInt("age",22);
  }

  @override
  void initState() {
    dataDelete();
    dataUpdate();
    dataRead();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page A"),
      ),
      body: Center(),
    );
  }
}
