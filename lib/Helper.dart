import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelp {
  Future<Database> insert() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "Shayari.db");

    await deleteDatabase(dbPath);

    ByteData data = await rootBundle.load("assets/database/Shayari.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    Database db = await openDatabase(dbPath);
    return db;
  }

  Future<List<Map>> viewdatas(Database? db) async {
    String qry = "Select * From AllShayariCategory";
    List<Map> ll = await db!.rawQuery(qry);
    return ll;
  }

  Future<List<Map>> viewdatas1(Database? db, int index) async {
    String qry = "Select * From AllShayari where Cat_id = ${index + 1}";
    List<Map> ll = await db!.rawQuery(qry);
    return ll;
  }
}
