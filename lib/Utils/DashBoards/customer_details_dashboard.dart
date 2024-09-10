import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class CustomerDetailsDashboard extends StatelessWidget {
  final TripTicketComplete tripTicket;
  final void Function()? onTap;
  final String status;

  const CustomerDetailsDashboard({
    super.key,
    required this.onTap,
    required this.tripTicket,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: tripTicket.customerList
              .map((customer) => _buildDashboard(context, customer))
              .toList(),
        ));
  }

  Widget _buildDashboard(BuildContext context, CustomerInformations customer) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, customer),
          const SizedBox(height: 30),
          _buildInfoGrid(context, customer),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CustomerInformations customer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.storeName,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  customer.storeAddress,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Add functionality for the more options button
          },
        ),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context, CustomerInformations customer) {
    int totalInvoices = customer.invoiceDetails.length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.8,
      crossAxisSpacing: 5,
      mainAxisSpacing: 22,
      children: [
        _buildInfoItem(context, Icons.local_activity, status, "Status"),
        _buildInfoItem(
            context, Icons.person, customer.ownerName, "Contact Person"),
        _buildContactNumbers(context, List<String>.from(customer.phoneNumber)),
        _buildInfoItem(
            context, Icons.receipt, totalInvoices.toString(), "Invoices"),
        _buildInfoItem(context, Icons.attach_money,
            customer.totalAmount.toStringAsFixed(2), "Total Amount"),
        _buildInfoItem(
            context, Icons.payment, customer.paymentMethode, "Payment Mode"),
      ],
    );
  }

  Widget _buildContactNumbers(BuildContext context, List<String> phoneNumbers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem(
          context,
          Icons.phone,
          phoneNumbers.take(2).join('\n'),
          "Contact Numbers",
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    IconData displayIcon = icon;
    if (subtitle == "Status") {
      displayIcon = _getStatusIcon(title);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 2, bottom: 15),
              child: Icon(displayIcon,
                  color: Theme.of(context).colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle == "Contact Numbers")
                    ...title.split('\n').map((number) => GestureDetector(
                          onTap: () => _launchPhoneCall(number),
                          child: Text(
                            number,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline),
                          ),
                        ))
                  else
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.pending;
      case 'In Transit':
        return Icons.local_shipping;
      case 'Arrived':
        return Icons.location_on;
      case 'Waiting for Customer':
        return Icons.access_time;
      case 'Unloading':
        return Icons.unarchive;
      case 'End Delivery':
        return Icons.check_circle;
      case 'Mark as Undeliverable':
        return Icons.error_outline;
      default:
        return Icons.question_mark_outlined;
    }
  }

  void _launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
