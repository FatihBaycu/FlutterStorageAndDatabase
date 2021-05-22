import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/dao/contact_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/models/contact.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/screens/contact_home_screen.dart';

class ContactUpdateScreen extends StatefulWidget {
    Contact contact;

    ContactUpdateScreen(this.contact);

  @override
  _ContactUpdateScreenState createState() => _ContactUpdateScreenState();
}

class _ContactUpdateScreenState extends State<ContactUpdateScreen> {

  var person_name=TextEditingController();
  var person_phone=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    person_phone.text=widget.contact.person_phone;
    person_name.text=widget.contact.person_name;


    super.initState();
  }

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
                      widget.contact.person_name=person_name.text;
                      widget.contact.person_phone=person_phone.text;
                      ContactDao().updateContact(widget.contact);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ContactsHomeScreen()));
                    }
                  }
                      , child: Text("Update"))),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: (){
          ContactDao().deleteContact(widget.contact.person_id);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ContactsHomeScreen()));
        },
      ),
    );
  }
}
