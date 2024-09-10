import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/collection_summary_db.dart';
import 'package:x_pro_delivery_app/Widget/Tiles/tile_for_summary_deliveries.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';

class CollectionSummary extends StatelessWidget {
  const CollectionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Collection Summary'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.supervised_user_circle,
              size: 25,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CollectionSummaryDb(tripTicketComplete: dummyTripTicket[0]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Text(
                'Deliveries',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TileForSummaryDeliveries(
                  tripTicketComplete: dummyTripTicket[index],
                );
              },
              childCount: dummyTripTicket.length,
            ),
          ),
        ],
      ),
    );
  }
}
