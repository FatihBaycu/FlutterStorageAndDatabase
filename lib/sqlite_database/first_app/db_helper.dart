import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  static final String databaseName="persons.sqlite";
  static Future<Database> databaseAccess() async{
    String databasePath=join(await getDatabasesPath(),databaseName);
    
    if(await databaseExists(databasePath)){
      print("Database is already exist, No need to copying.");
    }
    else{
      ByteData data=await rootBundle.load("database/$databaseName");
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes,flush: true);
      print("database was copied.");
    }
    return openDatabase(databasePath);
  }
}