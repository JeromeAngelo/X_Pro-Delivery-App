import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/document/files/tile_for_docs.dart';
import 'package:x_pro_delivery_app/data/Transaction_dummydatas/documents.dart';

class DocumentFilesScreen extends StatefulWidget {
  const DocumentFilesScreen({super.key});

  @override
  State<DocumentFilesScreen> createState() => _DocumentFilesScreenState();
}

class _DocumentFilesScreenState extends State<DocumentFilesScreen> {
  int checkedItemsCount = 0;

  void updateCheckedItems(bool isChecked) {
    setState(() {
      if (isChecked) {
        checkedItemsCount++;
      } else {
        checkedItemsCount--;
      }
    });
  }

  void _navigateToNextScreen() {
    Navigator.pop(context, checkedItemsCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Files'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyDocumment.length,
              itemBuilder: (context, index) => TileForDocs(
                itemCheckslist: dummyDocumment[index],
                onCheckedItemsChanged: updateCheckedItems,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: GestureDetector(
              onTap: _navigateToNextScreen,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Confirm ($checkedItemsCount / ${dummyDocumment.length})',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
