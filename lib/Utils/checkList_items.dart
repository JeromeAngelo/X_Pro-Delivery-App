import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/checkList_model.dart';

class CheckListItems extends StatelessWidget {
  final ChecklistModel checklistModel;
  final Function()? onTap;

  const CheckListItems(
      {super.key, required this.checklistModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            Icons.list_alt_rounded,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            checklistModel.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Quantity: ${checklistModel.quantity}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
