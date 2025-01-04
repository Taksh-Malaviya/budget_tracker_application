import 'package:bdget_tracker_app/Halper/dbhalper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class catController extends GetxController {
  int? cat_index;

  void getCategoryImageIndex({required int index}) {
    cat_index = index;

    update();
  }

  Future addCat({required String name, required Uint8List image}) async {
    int? res =
        await DBHelper.dbHelper.insertdatainDATABASE(name: name, image: image);

    if (res == null) {
      Get.snackbar(
        "Failed",
        "$name insertion is failed... $res",
        backgroundColor: Colors.red.shade300,
      );
    } else {
      Get.snackbar(
        "Succesfully add ",
        "Chack it !!",
        backgroundColor: Colors.red.shade300,
      );
    }
  }
}
