// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/return_checklist.dart';

class TileForReturnChecklist extends StatelessWidget {
  TileForReturnChecklist({super.key, required this.returnChecklist});
  ReturnChecklist returnChecklist;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListTile(
        leading: Icon(
          Icons.list_alt_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          returnChecklist.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(
          'Quantity: ${returnChecklist.quantity}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        trailing: returnChecklist.iconsDesc,
        iconColor: Theme.of(context).colorScheme.onSurface,
        onTap: () {
          // Add your onTap functionality here
        },
      ),
    );
  }
}
