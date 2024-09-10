import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class TileForInvoicesList extends StatefulWidget {
  const TileForInvoicesList({
    super.key,
    required this.status,
    required this.tripTicketComplete,
    required this.onTap,
    required this.invoiceIndex,
  });
  final String status;
  final void Function()? onTap;
  final TripTicketComplete tripTicketComplete;
  final int invoiceIndex;

  @override
  State<TileForInvoicesList> createState() => _TileForInvoicesListState();
}

class _TileForInvoicesListState extends State<TileForInvoicesList> {
  @override
  Widget build(BuildContext context) {
    final String invNumber = widget.tripTicketComplete.customerList[0]
        .invoiceDetails[widget.invoiceIndex].invNumber;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Theme.of(context).colorScheme.surface,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.receipt,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total Items: ${widget.tripTicketComplete.customerList[0].invoiceDetails[widget.invoiceIndex].productInformations.length}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.outline,
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.status,
                      style: TextStyle(
                        color: widget.status == 'Completed'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
