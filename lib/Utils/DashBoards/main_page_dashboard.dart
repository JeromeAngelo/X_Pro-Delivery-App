import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class MainPageDashboard extends StatelessWidget {
  final TripTicketComplete tripTicketComplete;

  void _showHelpersDialog(
      BuildContext context, DeliveryTeamInformation deliveryTeam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Helpers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Helper 1: ${deliveryTeam.helper1}'),
              Text('Helper 2: ${deliveryTeam.helper2}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  const MainPageDashboard({super.key, required this.tripTicketComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: tripTicketComplete.deliveryTeam
            .map((deliveryTeam) => _buildDashboard(context, deliveryTeam))
            .toList(),
      ),
    );
  }

  Widget _buildDashboard(
      BuildContext context, DeliveryTeamInformation deliveryTeam) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, deliveryTeam),
            const SizedBox(height: 30),
            _buildInfoGrid(context, deliveryTeam),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, DeliveryTeamInformation deliveryTeam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deliveryTeam.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 10),
              Text(
                'Trip ID: ${deliveryTeam.tripId}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
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

  Widget _buildInfoGrid(
      BuildContext context, DeliveryTeamInformation deliveryTeam) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3.5,
      crossAxisSpacing: 5,
      mainAxisSpacing: 22,
      children: [
        _buildInfoItem(context, Icons.numbers, deliveryTeam.plateNumber,
            'Plate Number', deliveryTeam),
        _buildInfoItem(context, Icons.people, deliveryTeam.numberOfHelpers,
            "Number of Helpers", deliveryTeam),
        _buildInfoItem(context, Icons.local_shipping,
            deliveryTeam.activeDelivery, "Active Deliveries", deliveryTeam),
        _buildInfoItem(context, Icons.done_all_sharp,
            deliveryTeam.totalDelivered, "Total Delivered", deliveryTeam),
        _buildInfoItem(context, Icons.speed, deliveryTeam.totalDistance,
            "Total Distance", deliveryTeam),
        _buildInfoItem(context, Icons.location_on_outlined,
            deliveryTeam.activeLocation, "Active Route", deliveryTeam),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String title,
      String subtitle, DeliveryTeamInformation deliveryTeam) {
    return GestureDetector(
      onTap: subtitle == "Number of Helpers"
          ? () => _showHelpersDialog(context, deliveryTeam)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 2, bottom: 15),
                child: Icon(icon,
                    color: Theme.of(context).colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
      ),
    );
  }
}
