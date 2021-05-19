import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sharedPrefences/loginScreen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHomeScreen extends StatefulWidget {
  @override
  _SharedPreferencesHomeScreenState createState() =>
      _SharedPreferencesHomeScreenState();
}

class _SharedPreferencesHomeScreenState extends State<SharedPreferencesHomeScreen> {

  String spUserame="empty";
  String spPassword="empty";

  Future<void> sessionInfoRead()async{

    var sp=await SharedPreferences.getInstance();

    setState(() {
      spUserame=sp.get("username")??"no username";
      spPassword=sp.get("password")??"no password";
    });

  }

  Future<void> logout()async{

    var sp=await SharedPreferences.getInstance();

    setState(() {
      sp.remove("username");
      sp.remove("password");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SharedPreferencesLoginScreen()));
    });

  }

  @override
  void initState() {
    sessionInfoRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()=>logout()),
        ],
      )),
      drawer: Drawer(

        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(spUserame),
                accountEmail: Text(spUserame+"@gmail.com"),
                currentAccountPicture: Image.network("https://thumbs.dreamstime.com/b/admin-sign-laptop-icon-stock-vector-166205404.jpg"),
                otherAccountsPictures: [
                  CircleAvatar(child: Text("Mod"),),
                  CircleAvatar(child: Text("Cstm"),),
                ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.fiber_new_sharp),
                    title: Text("News",style: TextStyle(color: Colors.red),),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Username:"+spUserame,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "Password:"+spPassword,
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
