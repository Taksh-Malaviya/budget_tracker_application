import 'dart:developer';

import 'package:bdget_tracker_app/Modal/cat_modal.dart';
import 'package:sqflite/sqflite.dart';

import '../Modal/spending_model.dart';

String nameoftabel = "budget_tracker";
Database? database;
String categoryId = "category_id";
String categoryName = "category_name";
String categoryImage = "category_image";
String categoryImage_index = "category_image_index";

String spendingTable = "spending";
String spendingId = "spending_id";
String spendingDesc = "spending_desc";
String spendingAmount = "spending_amount";
String spendingMode = "spending_mode";
String spendingDate = "spending_date";
String spendingCategoryId = "spending_category_id";

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
      $categoryImage BLOB,
      $categoryImage_index INTEGER
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
      String query2 = '''CREATE TABLE $spendingTable (
          $spendingId INTEGER PRIMARY KEY AUTOINCREMENT,
          $spendingDesc TEXT NOT NULL,
          $spendingAmount NUMERIC NOT NULL,
          $spendingMode TEXT NOT NULL,
          $spendingDate TEXT NOT NULL,
          $spendingCategoryId INTEGER NOT NULL
        );''';

      await db.execute(query2);
    });
  }

  Future<int?> insertdatainDATABASE(
      {required name, required image, required int index}) async {
    await createDB();

    String query =
        "INSERT INTO $nameoftabel ($categoryName,$categoryImage,$categoryImage_index) VALUES (?,?,?);";

    List argument = [name, image, index];
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

  Future<int?> insertSpendingdata({required SpendingModel model}) async {
    await createDB();

    String query =
        "INSERT INTO $nameoftabel ($spendingDesc,$spendingAmount,$spendingMode,$spendingDate,$spendingCategoryId) VALUES(?, ?, ?, ?, ?);";

    List args = [
      model.desc,
      model.amount,
      model.mode,
      model.date,
      model.categoryId,
    ];

    return await database?.rawInsert(query, args);
  }

  Future<List<SpendingModel>> fetchSpendingcat() async {
    await createDB();

    String query = "SELECT *  FROM $spendingTable;";

    List<Map<String, dynamic>> res = await database?.rawQuery(query) ?? [];

    return res
        .map(
          (e) => SpendingModel.formMap(data: e),
        )
        .toList();
  }
}
