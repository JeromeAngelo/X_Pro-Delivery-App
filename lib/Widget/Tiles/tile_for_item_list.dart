import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/model/item_list_model.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class TileForItemList extends StatelessWidget {
  final ItemListModel itemListModel;
  final Function(bool?) onCheckboxChanged;

  const TileForItemList({
    super.key,
    required this.itemListModel,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final currentStatus = timelineProvider.timeline.isNotEmpty
        ? timelineProvider.timeline.first.title
        : '';
    final isEndDelivery = timelineProvider.timeline.isNotEmpty &&
        timelineProvider.timeline.first.title == 'End Delivery';

    final bool isCheckboxEnabled = currentStatus == 'Unloading';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Leading
            itemListModel.iconItem,
            const SizedBox(width: 16),
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemListModel.itemName,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 10,
                        ),
                  ),
                  Text(
                    itemListModel.itemDescription,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${itemListModel.unit} x ${itemListModel.itemQuantity}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            // Trailing
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: itemListModel.reasonForUncheck != null
                      ? Colors
                          .orange // Use a different color for items with a reason
                      : (isEndDelivery
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.5)
                          : Theme.of(context).colorScheme.primary),
                  value: itemListModel.isChecked,
                  onChanged: isEndDelivery ? null : onCheckboxChanged,
                ),
                Text(
                  itemListModel.isChecked
                      ? (itemListModel.reasonForUncheck ?? 'Unloaded')
                      : 'Truck',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isCheckboxEnabled
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
