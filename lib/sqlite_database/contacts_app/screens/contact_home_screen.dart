import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/dao/contact_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/models/contact.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/screens/contact_add_screen.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/screens/contact_update_screen.dart';
import 'package:flutter_storage_and_database/sqlite_database/grade_app/dao/grade_dao.dart';

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

  Future<List<Contact>> getAllContact()async{
        var list= await ContactDao().getAll();
        return list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Contacts"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Contact>>(
          future: getAllContact(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var list=snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    var contact=list[index];
                   return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUpdateScreen(contact)));
                          },
                          child: SizedBox(
                            height: 50,
                            child: Card(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(contact.person_id.toString()),
                                    Text(contact.person_name),
                                    Text(contact.person_phone),
                                  ],
                                )
                            ),
                          ),
                        )
                      ],
                    );
                  },

                ),
              );
            }
            else
              return Center(child: CircularProgressIndicator());

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactAddScreen())),
      ),
    );
  }

}
