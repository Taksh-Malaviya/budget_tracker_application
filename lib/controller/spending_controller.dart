import 'package:get/get.dart';

class spending_controller extends GetxController {
  // Make selectedPaymentMethod observable
  RxString selectedPaymentMethod = 'Online'.obs;

  // Method to update selected value
  void rediobuttonvalue({required String value}) {
    selectedPaymentMethod.value = value;
  }
}
