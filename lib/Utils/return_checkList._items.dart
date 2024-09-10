import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_return_checkList.dart';
import 'package:x_pro_delivery_app/data/return_checkList._data.dart';

class ReturnChecklistItems extends StatelessWidget {
  const ReturnChecklistItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dummyReturnChecklist.length,
        itemBuilder: (context, index) => TileForReturnChecklist(
            returnChecklist: dummyReturnChecklist[index]),
      ),
    );
  }
}
