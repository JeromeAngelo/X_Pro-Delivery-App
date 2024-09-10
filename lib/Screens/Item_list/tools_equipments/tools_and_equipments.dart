import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/tools_equipments/tile_for_tool_equipment.dart';
import 'package:x_pro_delivery_app/data/Transaction_dummydatas/tools_and_equipments.dart';

class ToolsAndEquipments extends StatefulWidget {
  const ToolsAndEquipments({super.key});

  @override
  State<ToolsAndEquipments> createState() => _ToolsAndEquipmentsState();
}

class _ToolsAndEquipmentsState extends State<ToolsAndEquipments> {
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
        title: const Text('Tools and Equipments'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummy_tools_and_equipments.length,
            itemBuilder: (context, index) => TileForToolEquipment(
              onCheckedItemsChanged: updateCheckedItems,
              itemCheckslist: dummy_tools_and_equipments[index],
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
                    'Confirm ($checkedItemsCount /  ${dummy_tools_and_equipments.length})',
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
