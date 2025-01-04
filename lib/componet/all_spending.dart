import 'package:bdget_tracker_app/controller/spending_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String description = "";
int? ammount;

class All_spending extends StatefulWidget {
  const All_spending({super.key});

  @override
  State<All_spending> createState() => _All_spendingState();
}

class _All_spendingState extends State<All_spending> {
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation

  @override
  Widget build(BuildContext context) {
    spending_controller controller_spending = Get.put(spending_controller());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (value) {
                  description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "₹000",
                  labelText: "Amount",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (value) {
                  ammount = int.tryParse(value); // Save amount input
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  } else if (ammount == null || ammount! <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Payment Method : ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() => Radio<String>(
                        value: 'Online',
                        groupValue:
                            controller_spending.selectedPaymentMethod.value,
                        onChanged: (value) {
                          controller_spending.rediobuttonvalue(value: value!);
                        },
                      )),
                  Text('Online'),
                ],
              ),
              Row(
                children: [
                  Obx(
                    () => Radio<String>(
                      value: 'Offline',
                      groupValue:
                          controller_spending.selectedPaymentMethod.value,
                      onChanged: (value) {
                        controller_spending.rediobuttonvalue(value: value!);
                      },
                    ),
                  ),
                  Text('Offline'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar("Successfully", "Data added");
                  } else {
                    Get.snackbar("Error", "Please fill all required fields");
                  }
                },
                child: Text("Add data"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
