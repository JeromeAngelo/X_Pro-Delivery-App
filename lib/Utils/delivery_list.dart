import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class DeliveryList extends StatelessWidget {
  final TripTicketComplete tripTicket;

  const DeliveryList({super.key, required this.tripTicket});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimelineProvider>(
      builder: (context, timelineProvider, child) {
        return Column(
          children: tripTicket.customerList
              .map((customer) => _buildDeliveryCard(
                  context, timelineProvider.currentDeliveryStatus, customer))
              .toList(),
        );
      },
    );
  }

  Widget _buildDeliveryCard(
      BuildContext context, String status, CustomerInformations customer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: _cardDecoration(context),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          leading: _buildLeadingIcon(context),
          title: _buildTitle(context, customer),
          subtitle: _buildSubtitle(context, status, customer),
          trailing: _buildTrailingIcon(context),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return Icon(
      Icons.person,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTitle(BuildContext context, CustomerInformations customer) {
    return Text(
      customer.storeName,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle(
      BuildContext context, String status, CustomerInformations customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customer.storeAddress,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  Widget _buildTrailingIcon(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_outlined,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
