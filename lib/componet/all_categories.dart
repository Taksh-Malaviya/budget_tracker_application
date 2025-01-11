import 'dart:developer';

import 'package:bdget_tracker_app/controller/cat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Modal/cat_modal.dart';

class All_categories extends StatelessWidget {
  const All_categories({super.key});

  @override
  Widget build(BuildContext context) {
    catController controller = Get.put(catController());
    controller.fatch();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<catController>(builder: (context) {
              return FutureBuilder(
                future: controller.allCat,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR "),
                    );
                  } else if (snapshot.hasData) {
                    List<CategoryModel> alldata = snapshot.data ?? [];
                    return (alldata.isNotEmpty)
                        ? ListView.builder(
                            itemCount: alldata.length,
                            itemBuilder: (context, index) {
                              CategoryModel data = CategoryModel(
                                id: alldata[index].id,
                                name: alldata[index].name,
                                image: alldata[index].image,
                                index: alldata[index].index,
                              );
                              log("DATA : $data");
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: MemoryImage(data.image),
                                  ),
                                  title: Text(data.name),
                                ),
                              );
                            },
                          )
                        : Text("not found ..");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
