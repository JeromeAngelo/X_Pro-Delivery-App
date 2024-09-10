import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/data/item_list_data.dart';
import 'package:x_pro_delivery_app/model/invoice_model.dart';

final dummyInvoice = [
  InvoiceModel(
      invNumber: '10000001',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000002',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000003',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000004',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000005',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000006',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
  InvoiceModel(
      invNumber: '10000007',
      totalItems: dummyItemList.length,
      iconDesc: const Icon(
        Icons.receipt_long,
      ),
      status: 'Pending'),
];
