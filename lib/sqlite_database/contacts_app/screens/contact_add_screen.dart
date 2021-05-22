import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/dao/contact_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/models/contact.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/screens/contact_home_screen.dart';

class ContactAddScreen extends StatefulWidget {
  const ContactAddScreen({Key key}) : super(key: key);

  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {

    var person_name=TextEditingController();
    var person_phone=TextEditingController();
    var formKey=GlobalKey<FormState>();
    Contact contact=Contact(0, "", "");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Screen"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    validator: (value){
                      if(value.length==0){
                        return "cant be null";

                      }

                    },
                    controller: person_name,
                    decoration: InputDecoration(
                        labelText: "Person name",
                        border: OutlineInputBorder()),
                  ),
                  Divider(),
                  TextFormField(
                    validator: (value){
                      if(value.length==0){
                        return "cant be null";

                      }

                    },
                    controller: person_phone,
                    keyboardType: TextInputType.phone,

                    decoration: InputDecoration(
                        labelText: "Person phone",
                        border: OutlineInputBorder()),
                  ),
                  Divider(),

                  SizedBox(height: 50,width: 250,child: ElevatedButton(onPressed: (){
                    if(formKey.currentState.validate()){
                      contact.person_name=person_name.text;
                      contact.person_phone=person_phone.text;
                      ContactDao.addContact(contact);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ContactsHomeScreen()));
                    }
                  }
                  , child: Text("Add"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
