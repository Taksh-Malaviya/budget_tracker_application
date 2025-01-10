import 'package:bdget_tracker_app/Modal/cat_modal.dart';
import 'package:bdget_tracker_app/controller/cat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class spending extends StatelessWidget {
  const spending({super.key});

  @override
  Widget build(BuildContext context) {
    catController controller = Get.put(catController());
    controller.fatch();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      //   body:
    );
  }
}
