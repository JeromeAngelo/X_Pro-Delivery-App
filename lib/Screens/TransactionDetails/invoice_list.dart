import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_invoices_list.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/data/invoicelist_data.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class InvoiceNumberList extends StatefulWidget {
  const InvoiceNumberList({super.key});

  @override
  State<InvoiceNumberList> createState() => _InvoiceNumberListState();
}

class _InvoiceNumberListState extends State<InvoiceNumberList> {
  @override
  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final isEndDelivery = timelineProvider.timeline.isNotEmpty &&
        timelineProvider.timeline.first.title == 'End Delivery';

    bool areAllInvoicesCompleted() {
      return dummyInvoice.every((invoice) => invoice.status == 'Completed');
    }

    void navigateToItemList(int index) {
      context.push('/item-list', extra: index);
    }

    void navigateToCollection() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Delivery Confirmed',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ),
      );
      context.push('/collection');
    }

    return Consumer<TimelineProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Invoice List"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => navigateToItemList(index),
                        child: TileForInvoicesList(
                          tripTicketComplete: dummyTripTicket[0],
                          onTap: () => navigateToItemList(index),
                          invoiceIndex: index, // Add this line
                          status: dummyInvoice[index].status,
                        ),
                      );
                    },
                    itemCount: dummyTripTicket[0]
                        .customerList[0]
                        .invoiceDetails
                        .length,
                  ),
                  const SizedBox(
                    height: 135,
                  )
                ],
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  color: Theme.of(context).colorScheme.surface,
                  child: InkWell(
                    onTap: isEndDelivery
                        ? null
                        : (areAllInvoicesCompleted()
                            ? navigateToCollection
                            : null),
                    child: Opacity(
                      opacity: (isEndDelivery || areAllInvoicesCompleted())
                          ? 1.0
                          : 0.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isEndDelivery
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5)
                                : Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long,
                                  color: Theme.of(context).colorScheme.surface),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Confirm Delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
