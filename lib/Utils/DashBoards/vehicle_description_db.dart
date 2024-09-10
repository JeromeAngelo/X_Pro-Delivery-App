import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

class VehicleDescriptionDb extends StatelessWidget {
  const VehicleDescriptionDb({super.key, required this.tripTicketComplete});
  final TripTicketComplete tripTicketComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    final deliveryTeam = tripTicketComplete.deliveryTeam.first;
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 4,
        crossAxisSpacing: 25,
        mainAxisSpacing: 16,
        children: [
          _buildInfoItem(
              context, Icons.numbers, deliveryTeam.plateNumber, "Plate Number"),
          _buildInfoItem(context, Icons.local_shipping,
              deliveryTeam.vehicleType, "Vehicle Type"),
          _buildInfoItem(context, Icons.branding_watermark,
              deliveryTeam.vehicleBrand, "Vehicle Brand"),
          _buildInfoItem(
              context, Icons.speed, deliveryTeam.odometer, "Odometer"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(icon,
                color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
