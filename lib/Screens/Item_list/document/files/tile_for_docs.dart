import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/checklist_items.dart';

class TileForDocs extends StatefulWidget {
  const TileForDocs({
    super.key,
    required this.itemCheckslist,
    required this.onCheckedItemsChanged,
  });

  final ItemCheckslist itemCheckslist;
  final Function(bool) onCheckedItemsChanged;

  @override
  _TileForDocsState createState() => _TileForDocsState();
}

class _TileForDocsState extends State<TileForDocs> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.list,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            widget.itemCheckslist.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold),
          ),
          trailing: Checkbox(
            activeColor: Theme.of(context).colorScheme.primary,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
              });
              widget.onCheckedItemsChanged(isChecked);
            },
          ),
        ),
      ),
    );
  }
}
