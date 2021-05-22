import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/dao/film_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/category.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/models/film_detail.dart';
import 'package:flutter_storage_and_database/sqlite_database/film_ui_app/screens/film_app_film_detail_screen.dart';

class FilmAppFilmByCategory extends StatefulWidget {
  Category category;

  
  FilmAppFilmByCategory(this.category);


  @override
  _FilmAppFilmByCategoryState createState() => _FilmAppFilmByCategoryState();
}

class _FilmAppFilmByCategoryState extends State<FilmAppFilmByCategory> {

          Future<List<FilmDetail>> getFilmByCategory(int id)async{
        var list=await FilmDao.getFilmsByCategory(id);
        return list;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.category_name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<FilmDetail>>(
          future: getFilmByCategory(widget.category.category_id),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var filmList=snapshot.data;
               return GridView.builder(
                 itemCount: filmList.length,
                  gridDelegate: 
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2/3.5),
                   itemBuilder: (context,index){
                     var film=filmList[index];
                     return GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return FilmAppFilmDetailScreen(film);
                         }));
                       },
                             child: Card(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                           Container(
                             height: 300,
                             child: Image.asset("assets/images/film_images/${film.film_image}.jpg")),
                            Text(film.film_name,style: TextStyle(fontSize:16),),
                         ],),
                       ),
                     );
                   });
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
