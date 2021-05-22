import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/dao/dictionary_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/models/dictionary.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/screens/dictionary_home_page_screen.dart';

class DictionaryAddScreen extends StatefulWidget {
  @override
  _DictionaryAddScreenState createState() => _DictionaryAddScreenState();
}

class _DictionaryAddScreenState extends State<DictionaryAddScreen> {
  var englishWord = TextEditingController();
  var turkishWord = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Word word = Word(0, "english", "turkish");

      Future<void> insertWord(Word word)async{
        await WordDao.insertWord(word);
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Word Add"),
      ),
      body: SingleChildScrollView(
              child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: englishWord,
                      validator: (String value) {
                        if (value.length < 1)
                          return "min length must be 2 character";
                      },
                      decoration: InputDecoration(
                          labelText: "English Word",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                    Divider(),
                    TextFormField(
                      controller: turkishWord,
                      validator: (String value) {
                        if (value.length < 1)
                          return "min length must be 2 character";
                      },
                      decoration: InputDecoration(
                          labelText: "Turkish Word",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                    ),
                                        Divider(),

                    SizedBox(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                
                                word.english=englishWord.text;
                                word.turkish=turkishWord.text;
                                insertWord(word);
                                 print("success");
                                 Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>DictionaryAppHomeScreen()));
                              } else {
                                print("erorr..");
                              }
                            },
                            child: Text("Add Word")))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
