import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/models/dictionary.dart';

class DictionaryDetailScreen extends StatefulWidget {
  Word word;
  DictionaryDetailScreen({this.word});

  @override
  _DictionaryDetailScreenState createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  var englishWord = TextEditingController();
  var turkishWord = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dictionary Detail Screen"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
      Text(
        widget.word.english,
        style: TextStyle(
            fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold),
      ),
      Text(
        widget.word.turkish,
        style: TextStyle(
          fontSize: 40,
        ),
      ),
            ],
          ),
        ),
    );
  }
}
