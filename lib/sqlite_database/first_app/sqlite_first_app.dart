import 'package:flutter/material.dart';
import 'package:flutter_storage_and_database/sqlite_database/first_app/data_access/persons_dao.dart';
import 'package:flutter_storage_and_database/sqlite_database/first_app/models/persons.dart';

class SqLiteFirstApp extends StatelessWidget {
  const SqLiteFirstApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySqLiteFirstApp(),
    );
  }
}

class MySqLiteFirstApp extends StatefulWidget {
  @override
  _SqLiteFirstApp createState() => _SqLiteFirstApp();
}

class _SqLiteFirstApp extends State<MySqLiteFirstApp> {


  Persons person=new Persons(0, "person_name", 0);

  Future<void> showPersons() async {
    var list = await PersonsDao.getAll();
    for (Persons k in list) {
      print("************");
      print("person id:" + k.person_id.toString());
      print("person name:" + k.person_name);
      print("person age:" + k.person_age.toString());
    }
  }

  Future<void> addPerson(Persons person)    async=>await    PersonsDao.addPerson(person);

  Future<void> updatePerson(Persons person) async=>await    PersonsDao.updatePerson(person);

  Future<void> deletePerson(int person_id)  async=>await    PersonsDao.deletePerson(person_id);

  Future<int> checkExist(Persons person) async{
    int result= await PersonsDao.existControl(person);
     print("$result records were found int the database named: ${person.person_name}");
  }
  Future<Persons> getById(int person_id) async{
    var list= await PersonsDao.getById(person_id);
    print(
        """
        *****GET BY ID*******
        Person id:${list.person_id}
        Person name:${list.person_name}
        Person age:${list.person_age}
        """
    );

  }


  Future<void> searchPerson(searchName) async {

     var liste = await PersonsDao.searchPerson(searchName);


    for (Persons k in liste) {
      print("************");
      print("person id:" + k.person_id.toString());
      print("person name:" + k.person_name);
      print("person age:" + k.person_age.toString());
    }
  }
  Future<void> getTwoRandom() async {
     var liste = await PersonsDao.getTwoRandom();

    for (Persons k in liste) {
      print("************");
      print("person id:" + k.person_id.toString());
      print("person name:" + k.person_name);
      print("person age:" + k.person_age.toString());
    }
  }

  @override
  initState() {

    //use only for person_id deletion and updating. You don't need to use it while adding(INSERT).
    //person.person_id=5;
    person.person_name="John";
    person.person_age=30;

    super.initState();
    //deletePerson(person.person_id);
    //addPerson(person);
    //updatePerson(person);
    //checkExist(person);
    //getById(7);
    //searchPerson("zeynep");
    getTwoRandom();
    //showPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First SqLite App"),
      ),
    );
  }
}
