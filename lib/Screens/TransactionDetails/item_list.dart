import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_item_list.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/data/invoicelist_data.dart';
import 'package:x_pro_delivery_app/data/item_list_data.dart';
import 'package:x_pro_delivery_app/model/item_list_model.dart';
import 'package:x_pro_delivery_app/provider/return_items_provider.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  String? _selectedReason;
  String? reasonForUncheck;
  List<ItemListModel> returnedItems = [];

  void _navigateToDirectReceipt(BuildContext context) {
    int totalItems = dummyItemList.length;
    int checkedItems = dummyItemList.where((item) => item.isChecked).length;

    if (checkedItems < totalItems) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Warning'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Not all items are checked. Select a reason to proceed:'),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: _selectedReason,
                      hint: const Text('Select Reason'),
                      isExpanded: true,
                      items: ['Wrong Item', 'Wrong Description', 'Item Damaged']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedReason = newValue;
                        });
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    onPressed: _selectedReason != null
                        ? () {
                            Navigator.of(context).pop();
                            _navigateToViewReturnScreen(
                                context, _getUncheckedItems);
                            _applyReasonToUncheckedItems(_selectedReason!);
                            _completeTransaction(context);
                          }
                        : null,
                    child: const Text('Proceed'),
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      _completeTransaction(context);
    }
  }

  void _applyReasonToUncheckedItems(String reason) {
    List<ItemListModel> itemsToReturn = [];
    for (var item in dummyItemList) {
      if (!item.isChecked) {
        item.isChecked = true;
        item.reasonForUncheck = reason;
        itemsToReturn.add(item);
      }
    }
    // Add this line to update the provider
    Provider.of<ReturnedItemsProvider>(context, listen: false)
        .addReturnedItems(itemsToReturn);
    setState(() {});
  }

  List<ItemListModel> _getUncheckedItems() {
    return dummyItemList.where((item) => !item.isChecked).toList();
  }

  void _navigateToViewReturnScreen(
      BuildContext context, Function getUncheckedItems) {
    context.push('view-return');
  }

  void _completeTransaction(BuildContext context) {
    for (int i = 0; i < dummyInvoice.length; i++) {
      bool allItemsChecked = dummyItemList.every((item) => item.isChecked);
      updateInvoiceStatus(allItemsChecked ? 'Completed' : 'Pending', i);
    }
    context.pop('/invoice-list');
    // Navigator.of(context).pop(dummyInvoice);
  }

  void updateInvoiceStatus(String status, int index) {
    setState(() {
      if (dummyInvoice.length > index) {
        dummyInvoice[index].status = status;
      }
    });
  }

  void _handleTileTap(int index) {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final currentStatus = timelineProvider.timeline.isNotEmpty
        ? timelineProvider.timeline.first.title
        : '';

    if (currentStatus == 'Unloading') {
      setState(() {
        dummyItemList[index].isChecked = !dummyItemList[index].isChecked;
        if (dummyItemList[index].isChecked) {
          updateInvoiceStatus('In Transit', index);
        } else {
          updateInvoiceStatus('Pending', index);
        }
      });
    } else if (currentStatus == "End Delivery" && currentStatus == 'Pending') {
      // Do nothing when status is "End Delivery"
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(milliseconds: 1000),
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text(
                'Cannot check items until status is set to Unloading')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String tripId = dummyTripTicket[0].tripId;
    int checkedItemsCount =
        dummyItemList.where((item) => item.isChecked).length;

    return Consumer<TimelineProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(tripId),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dummyItemList.length,
                    itemBuilder: (context, index) => TileForItemList(
                      itemListModel: dummyItemList[index],
                      onCheckboxChanged: (bool? value) => _handleTileTap(index),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
              child: _buildConfirmReceiptButton(context, checkedItemsCount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmReceiptButton(
      BuildContext context, int checkedItemsCount) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final isEndDelivery = timelineProvider.timeline.isNotEmpty &&
        timelineProvider.timeline.first.title == 'End Delivery' 'Pending';

    return ElevatedButton(
      onPressed: () => isEndDelivery ? null : _navigateToDirectReceipt(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: isEndDelivery
            ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
            : Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long,
              color: Theme.of(context).colorScheme.onPrimary),
          const SizedBox(width: 8),
          Text(
            'Completed ($checkedItemsCount/${dummyItemList.length})',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
