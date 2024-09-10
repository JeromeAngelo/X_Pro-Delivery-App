import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_summary_model.dart';

class MyDashBoard extends StatelessWidget {
  const MyDashBoard({super.key, required this.tripSummaryModel});
  final TripSummaryModel tripSummaryModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 30),
          _buildInfoGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trip ID: ${tripSummaryModel.tripId}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 10),
              Text(
                'Date: ${tripSummaryModel.dateTime}',
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

  Widget _buildInfoGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 20,
      children: [
        _buildInfoItem(
            context, Icons.person, tripSummaryModel.driverName, "Driver"),
        _buildInfoItem(
            context, Icons.person, tripSummaryModel.helper1, "Helper 1"),
        _buildInfoItem(
            context, Icons.person, tripSummaryModel.helper2, "Helper 2"),
        _buildInfoItem(context, Icons.local_shipping,
            tripSummaryModel.plateNumber, "Truck Plate Number"),
        _buildInfoItem(
            context,
            Icons.people,
            tripSummaryModel.totalDelivered.toString(),
            "Total Delivered Customer"),
        _buildInfoItem(context, Icons.route, '${tripSummaryModel.totalKM} KM',
            "Total Distance"),
      ],
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 15),
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
}
