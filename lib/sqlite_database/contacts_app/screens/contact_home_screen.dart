import 'package:flutter/material.dart';

class ContactsHomeScreen extends StatelessWidget {
  const ContactsHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyContactsHomeScreen(),
    );
  }
}

class MyContactsHomeScreen extends StatefulWidget{
  @override
  _MyContactsHomeScreen createState() =>_MyContactsHomeScreen();
}

class _MyContactsHomeScreen extends State<MyContactsHomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Contacts"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(""),
                  Text(""),
                  Text(""),
                ],
              )
            )
          ],
        ),
      ),
    );
  }

}
