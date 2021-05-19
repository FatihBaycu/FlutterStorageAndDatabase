import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int counter;

  Future<void> countControl() async {
    var sp = await SharedPreferences.getInstance();
    counter = sp.getInt("counter") ?? 0;
    setState(() {
      counter++;
    });
    sp.setInt("counter", counter);
  }

  @override
  void initState() {
    countControl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Opened $counter times.",style: TextStyle(fontSize: 50),),
          ],
        ),
      ),
    );
  }
}
