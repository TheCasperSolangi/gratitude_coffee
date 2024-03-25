import 'package:get/get.dart';

class OrderController extends GetxController {
  // Variable to store order ID
  RxString orderId = ''.obs;

  // Method to set order ID
  void setOrderId(String id) {
    orderId.value = id;
  }

  // Method to get order ID
  String getOrderId() {
    return orderId.value;
  }
}