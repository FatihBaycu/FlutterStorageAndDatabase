import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static String databaseName = "filmler.sqlite";

  static Future<Database> databaseAccess() async {
    String path = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(path)) {
      print("database exist.");
    } else {
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      print("database was copied");
    }
    return openDatabase(path);
  }
}
