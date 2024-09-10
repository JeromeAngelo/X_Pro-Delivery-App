import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class TripTickets extends StatelessWidget {
  final TripTicketComplete tripTicket;

  const TripTickets({super.key, required this.tripTicket});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tripTicket.customerList
          .map((customer) => _buildCustomerTile(context, customer))
          .toList(),
    );
  }

  Widget _buildCustomerTile(
      BuildContext context, CustomerInformations customer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomerInfo(context, customer),
              const SizedBox(height: 16),
              _buildStatus(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerInfo(
      BuildContext context, CustomerInformations customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          context,
          Icons.store,
          customer.storeName,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          Icons.location_on,
          customer.storeAddress,
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          Icons.attach_money,
          '₱${customer.totalAmount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text,
      {TextStyle? style}) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Status:",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              'Warehouse',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.outline, size: 16),
          ],
        ),
      ],
    );
  }
}
