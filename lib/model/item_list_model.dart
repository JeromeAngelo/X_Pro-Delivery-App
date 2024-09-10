import 'package:flutter/material.dart';

class ItemListModel {
  ItemListModel({
    required this.iconItem,
    required this.itemName,
    required this.itemDescription,
    required this.itemQuantity,
    required this.unit,
    this.isChecked = false,
  });
  String? reasonForUncheck;
  final Icon iconItem;
  final String itemName;
  final String itemDescription;
  final int itemQuantity;
  final String unit;
  bool isChecked;
}
