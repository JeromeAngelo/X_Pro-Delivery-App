import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:x_pro_delivery_app/model/trip_summary_model.dart';

class TripSummaryDashboard extends StatelessWidget {
  const TripSummaryDashboard({super.key, required this.tripSummaryModel});
  final TripSummaryModel tripSummaryModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
      child: Card(
        shadowColor: Theme.of(context).colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            bottom: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildHeader(context),
              // SizedBox(height: 24),
              _buildInfoGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Trip ID: ${tripSummaryModel.tripId}',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .titleLarge!
  //                   .copyWith(color: Theme.of(context).colorScheme.onSurface),
  //             ),
  //             SizedBox(height: 10),
  //             Text(
  //               'Date: ${tripSummaryModel.tripDate}',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .titleSmall!
  //                   .copyWith(color: Theme.of(context).colorScheme.onSurface),
  //             ),
  //           ],
  //         ),
  //       ),
  //       // IconButton(
  //       //   icon: Icon(Icons.more_vert),
  //       //   onPressed: () {
  //       //     // Add functionality for the more options button
  //       //   },
  //       // ),
  //     ],
  //   );
  // }

  Widget _buildInfoGrid(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 4, // Adjust this value as needed
        crossAxisSpacing: 25,
        mainAxisSpacing: 16,
        children: [
          _buildInfoItem(context, Icons.perm_identity,
              tripSummaryModel.tripId.toString(), "Trip ID"),
          _buildInfoItem(
              context,
              Icons.date_range,
              DateFormat('MM-dd-yyyy').format(tripSummaryModel.dateTime),
              "Date"),
          _buildInfoItem(context, Icons.people,
              tripSummaryModel.totalDelivered.toString(), "Total Delivered"),
          _buildInfoItem(context, Icons.route, '${tripSummaryModel.totalKM} KM',
              "Total Distance"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    return SizedBox(
      height: 60, // Adjust this value as needed
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
