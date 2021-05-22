import 'package:flutter_storage_and_database/sqlite_database/contacts_app/dao/contacts_db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/models/contact.dart';

class ContactDao{


    Future<List<Contact>> getAll() async{

        var db=await ContactsDbHelper.accessDatabase();
       List<Map<String,dynamic>> maps=await db.rawQuery("select * from contacts");
        return List.generate(
            maps.length,
                (index) {
                var row=maps[index];
                return Contact(row["person_id"], row["person_name"], row["person_phone"]);
                });
    }

}