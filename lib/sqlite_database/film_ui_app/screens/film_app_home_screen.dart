import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/dao/category_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/dao/film_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/category.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/film_detail.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/screens/film_app_films_by_category.dart';

class FilmAppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFilmAppHomeScreen(),
    );
  }
}

class MyFilmAppHomeScreen extends StatefulWidget {
  @override
  _MyFilmAppHomeScreen createState() => _MyFilmAppHomeScreen();
}

class _MyFilmAppHomeScreen extends State<MyFilmAppHomeScreen> {

    Future<List<Category>> getCategories()async{

        var categories=<Category>[];
        var category1=Category(1, "category_name");
        var category2=Category(2, "category_name");
        var category3=Category(3, "category_name");
        categories.add(category1);
        categories.add(category2);
        categories.add(category3);
          return categories;
    }

  Future<List<Category>> getAllCategories() async {
    var list = await CategoryDao.getAllCategories();
    return list;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: FutureBuilder<List<Category>>(
        future: getAllCategories(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var categoryList=snapshot.data;
            return ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context,index){
                var category=categoryList[index];
                return ListTile(
                  title: Text(category.category_name),
                  trailing: Icon(Icons.navigate_next),
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>FilmAppFilmByCategory(category))),
                );
              },
            );
          }
          else{return Center(child: CircularProgressIndicator(),);} 
        },
      ),
    );
  }
}
