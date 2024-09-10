import 'package:flutter/material.dart';

class InvoiceModel {
  InvoiceModel(
      {required this.invNumber,
      required this.iconDesc,
      required this.totalItems,
      required this.status});
  final String invNumber;
  final int totalItems;
  final Icon iconDesc;
  String status;
}
