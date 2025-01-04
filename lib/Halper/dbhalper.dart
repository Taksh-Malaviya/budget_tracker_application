import 'dart:developer';

import 'package:sqflite/sqflite.dart';

String nameoftabel = "String = budget_tracker";
Database? database;
String categoryName = "category_name";
String categoryImage = "category_image";

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Future<void> creatDB() async {
    String DBpath = await getDatabasesPath();

    String path = '${DBpath}budget.db';

    database = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query = '''
      CREAT TABAL $nameoftabel {
      id INTEGER  AUTOINCREMENT;
      name TEXT;
      image BLOB
      }
      ''';
      await database
          ?.execute(query)
          .then(
            (value) => log("DATBASE CREATE"),
          )
          .onError(
            (error, _) => log("FAILED!!"),
          );
    });
  }

  Future<int?> insertdatainDATABASE({required name, required image}) async {
    await creatDB();

    String query =
        "INSERT INTO $nameoftabel ($categoryName,$categoryImage) VALUES (?,?);";

    List argument = [name, image];
    //
    // return await database.rawInsert(query,argument);
    return await database?.rawInsert(query, argument);
  }
}
