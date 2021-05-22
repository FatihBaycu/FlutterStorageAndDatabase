import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/dao/dictionary_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/models/dictionary.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/screens/dictionary_add_screen.dart';
import 'package:flutter_storage_and_database/sqlite_database/dictionary_app/screens/dictionary_detail_screen.dart';

class DictionaryAppHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyDictionaryAppHomeScreen(),
    );
  }
}

class MyDictionaryAppHomeScreen extends StatefulWidget {
  @override
  _MyDictionaryAppHomeScreen createState() => _MyDictionaryAppHomeScreen();
}

class _MyDictionaryAppHomeScreen extends State<MyDictionaryAppHomeScreen> {
  bool isSearching = false;
  String searchWord = "";



      Future<List<Word>> getAllWords()async{
          var list= await WordDao().getAll();
          return list;
      }

      Future<List<Word>> getSearchResults(String searchText)async{
          var list= await WordDao().getSearchingResult(searchText);
          return list;
      }
//for inMemory...
  Future<List<Word>> showAllWords() async {
    var wordsList = <Word>[];
    var w1 = Word(1, "Dog", "Köpek");
    var w2 = Word(1, "Fish", "Balık");
    var w3 = Word(1, "Table", "Masa");
    var w4 = Word(1, "Animal", "Hayvan");
    var w5 = Word(1, "Zoo", "Hayvanat Bahçesi");

    wordsList.add(w1);
    wordsList.add(w2);
    wordsList.add(w3);
    wordsList.add(w4);
    wordsList.add(w5);

    return wordsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ?   TextField(
            decoration: InputDecoration(hintText: "Search"),
            onChanged: (searchResult) {
              setState(() {
                  print("word:$searchResult");
              searchWord = searchResult;
              });
            
            },
          )
            : Text("Dictionary Home Screen"),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
        
        ],
      ),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DictionaryAddScreen())),
              ),
       
             body: FutureBuilder<List<Word>>(
               future: isSearching?getSearchResults(searchWord):getAllWords(),
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                   var wordList = snapshot.data;
                   return ListView.builder(
                     itemCount: wordList.length,
                     itemBuilder: (context, index) {
                       var word = wordList[index];
                       return GestureDetector(
                         onTap: () => Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => DictionaryDetailScreen(word:word))),
                         child: SizedBox(
                           height: 50,
                           child: Card(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text(word.english,
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                     )),
                                 Text(word.turkish),
                               ],
                             ),
                           ),
                         ),
                       );
                     },
                   );
                 } else {
                   return Center(
                       child: CircularProgressIndicator(backgroundColor: Colors.blue[700],));
                 }
               },
             ),
           );
         }
       }
       

