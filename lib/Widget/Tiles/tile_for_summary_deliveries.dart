import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class TileForSummaryDeliveries extends StatelessWidget {
  const TileForSummaryDeliveries({super.key, required this.tripTicketComplete});
  final TripTicketComplete tripTicketComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: tripTicketComplete.customerList
            .map((customer) => _buildCustomerCard(context, customer))
            .toList());
  }
}

Widget _buildCustomerCard(BuildContext context, CustomerInformations customer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: _buildLeadingIcon(context),
        title: _buildTitle(context, customer),
        subtitle: _buildSubtitle(context, customer),
        trailing: _buildTtrailingText(context, customer),
      ),
    ),
  );
}

Widget _buildLeadingIcon(BuildContext context) {
  return Icon(Icons.person, color: Theme.of(context).colorScheme.primary);
}

Widget _buildTitle(BuildContext context, CustomerInformations customer) {
  return Text(
    customer.storeName,
    style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
  );
}

Widget _buildSubtitle(BuildContext context, CustomerInformations customer) {
  return Text('₱${customer.totalAmount.toStringAsFixed(2)}');
}

Widget _buildTtrailingText(
    BuildContext context, CustomerInformations customer) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),
      Text(
        customer.paymentMethode,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    ],
  );
}
