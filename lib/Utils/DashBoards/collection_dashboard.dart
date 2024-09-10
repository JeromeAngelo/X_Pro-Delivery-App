import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/model/collection_details.dart';

class CollectionDashboardScreen extends StatelessWidget {
  const CollectionDashboardScreen({super.key, required this.collectionDetails});
  final CollectionDetails collectionDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collection Details',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _buildLeftColumn(context)),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(child: _buildRightColumn(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoRow(
          context: context,
          icon: Icons.person,
          title: "Customer Name",
          value: collectionDetails.customerName,
        ),
        _buildInfoRow(
          context: context,
          icon: Icons.price_change_rounded,
          title: "Total Amount",
          value: "₱${collectionDetails.totalAmount.toStringAsFixed(2)}",
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoRow(
          context: context,
          icon: Icons.payment,
          title: "Mode of Payment",
          value: collectionDetails.modeOfPayment,
        ),
        _buildInfoRow(
          context: context,
          icon: Icons.date_range_rounded,
          title: "Date",
          value: collectionDetails.collectionDate.toString().split(' ')[0],
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
