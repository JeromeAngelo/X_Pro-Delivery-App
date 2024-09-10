import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/return_checklist.dart';

final dummyReturnChecklist = [
  ReturnChecklist(
    title: 'Documents and Others',
    quantity: 1,
    iconsDesc: const Icon(
      Icons.arrow_forward,
    ),
  ),
  ReturnChecklist(
    title: 'Collections',
    quantity: 6,
    iconsDesc: const Icon(
      Icons.arrow_forward,
    ),
  ),
  ReturnChecklist(
    title: 'Returned Item',
    quantity: 12,
    iconsDesc: const Icon(
      Icons.arrow_forward,
    ),
  ),
  ReturnChecklist(
    title: 'Other Returned Item',
    quantity: 1,
    iconsDesc: const Icon(
      Icons.arrow_forward,
    ),
  ),
];
