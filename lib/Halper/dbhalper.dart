import 'dart:developer';

import 'package:bdget_tracker_app/Modal/cat_modal.dart';
import 'package:sqflite/sqflite.dart';

String nameoftabel = "budget_tracker";
Database? database;
String categoryId = "category_id";
String categoryName = "category_name";
String categoryImage = "category_image";

class DBHelper {
  DBHelper._();

  static DBHelper dbHelper = DBHelper._();

  Future<void> createDB() async {
    String DBpath = await getDatabasesPath();

    String path = '${DBpath}budget.db';

    database = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query = '''CREATE TABLE $nameoftabel (
      $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
      $categoryName TEXT,
      $categoryImage BLOB
      );
      ''';
      await db
          .execute(query)
          .then(
            (value) => log("DATABASE CREATE"),
          )
          .onError(
            (error, _) => log("FAILED!!"),
          );
    });
  }

  Future<int?> insertdatainDATABASE(
      {required name, required image, required int index}) async {
    await createDB();

    String query =
        "INSERT INTO $nameoftabel ($categoryName,$categoryImage) VALUES (?,?);";

    List argument = [name, image];
    //
    // return await database.rawInsert(query,argument);
    return await database?.rawInsert(query, argument);
  }

  Future<List<CategoryModel>> fetchCategory() async {
    await createDB();

    String query = "SELECT * FROM $nameoftabel;";

    List<Map<String, dynamic>> res = await database?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => CategoryModel.fromMap(data: e),
        )
        .toList();
  }
}
