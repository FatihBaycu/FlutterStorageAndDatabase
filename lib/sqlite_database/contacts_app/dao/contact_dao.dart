import 'package:flutter_storage_and_database/sqlite_database/contacts_app/dao/contact_db_helper.dart';
import 'package:flutter_storage_and_database/sqlite_database/contacts_app/models/contact.dart';

class ContactDao {


  Future<List<Contact>> getAll() async {
    var db = await ContactDbHelper.accessDatabase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from contacts");
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return Contact(row["person_id"], row["person_name"], row["person_phone"]);
    });
  }


    static Future<void> addContact(Contact contact)async{
            var db=await  ContactDbHelper.accessDatabase();
            var infos=Map<String,dynamic>();
            infos["person_name"]=contact.person_name;
            infos["person_phone"]=contact.person_phone;
            await db.insert("contacts",infos);
      }

      Future<void> updateContact(Contact contact)async{
                var db=await ContactDbHelper.accessDatabase();
                var infos=Map<String,dynamic>();
                infos["person_name"]=contact.person_name;
                infos["person_phone"]=contact.person_phone;
                await db.update("contacts",infos,where:"person_id=?",whereArgs:[contact.person_id]);

      }
    Future<void> deleteContact(int contactId)async{

          var db=await ContactDbHelper.accessDatabase();
          await db.delete("contacts",where:"person_id=?",whereArgs:[contactId]);

    }

}
