import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/model/item_list_model.dart';
import 'package:x_pro_delivery_app/provider/return_items_provider.dart';

class ViewReturnScreen extends StatelessWidget {
  const ViewReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReturnedItemsProvider>(
      builder: (context, returnedItemsProvider, child) {
        List<ItemListModel> returnedItems = returnedItemsProvider.returnedItems;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Returned Items'),
            centerTitle: true,
          ),
          body: returnedItems.isEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            'image/no-returns.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'No Returned Items',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: returnedItems.length,
                  itemBuilder: (context, index) {
                    final item = returnedItems[index];
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Leading
                            item.iconItem,
                            const SizedBox(width: 16),
                            // Title and Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 10,
                                        ),
                                  ),
                                  Text(
                                    item.itemDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontSize: 12,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.unit} x ${item.itemQuantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
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
                                Text(item.reasonForUncheck ?? ''),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
