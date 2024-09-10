import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/delivery_customer_model.dart';

class CustomerProvider with ChangeNotifier {
  final List<DeliveryCustomerModel> _customers = [];

  List<DeliveryCustomerModel> get customers => _customers;

  void updateDeliveryStatus(String customerId, bool isCompleted) {
    final index =
        _customers.indexWhere((customer) => customer.id == customerId);
    if (index != -1) {
      _customers[index].isDeliveryCompleted = isCompleted;
      notifyListeners();
    }
  }
}
