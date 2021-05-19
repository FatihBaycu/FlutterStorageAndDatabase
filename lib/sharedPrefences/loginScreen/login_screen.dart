import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SharedPreferencesLoginScreen extends StatelessWidget {

  Future<bool> sessionControl()async{

    var sp=await SharedPreferences.getInstance();

    String spUserame=sp.get("username")??"no username";
    String spPassword=sp.get("password")??"no password";
    if(spUserame=="admin" && spPassword=="123"){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: sessionControl(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool passPermit=snapshot.data;
            return passPermit?SharedPreferencesHomeScreen():MyLoginScreen();
          }
          else{
                      return Container();
          }
        },
      ),
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  @override
  _MyLoginScreen createState() => _MyLoginScreen();
}

class _MyLoginScreen extends State<MyLoginScreen> {



  var usernameTxt = TextEditingController();
  var passwordTxt = TextEditingController();

  var scaffoldkey = GlobalKey<ScaffoldState>();

  Future<void> loginControl()async{
    var username=usernameTxt.text;
    var password=passwordTxt.text;
    if(username=="admin" && password=="123"){

      var sp=await SharedPreferences.getInstance();
      sp.setString("username", username);
      sp.setString("password", password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SharedPreferencesHomeScreen()));
    }
    else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed"),));
    }
  }

  @override
  void initState() {
    loginControl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameTxt,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Username",
                      hintText: "Username"),
                ),
                Divider(height: 10,),
                TextFormField(
                  controller: passwordTxt,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: "Password"),

                ),
                ElevatedButton(onPressed: ()=>loginControl(), child: Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
