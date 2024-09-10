import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/others/tile_for_other_items.dart';
import 'package:x_pro_delivery_app/data/Transaction_dummydatas/others.dart';

class OtherItemsScreen extends StatefulWidget {
  const OtherItemsScreen({super.key});

  @override
  State<OtherItemsScreen> createState() => _OtherItemsScreenState();
}

class _OtherItemsScreenState extends State<OtherItemsScreen> {
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
        title: const Text('Safety and Conditions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummy_others.length,
            itemBuilder: (context, index) => TileForOtherItems(
              itemCheckslist: dummy_others[index],
              onCheckedItemsChanged: updateCheckedItems,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    'Confirm ($checkedItemsCount /  ${dummy_others.length})',
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
