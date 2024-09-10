import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:x_pro_delivery_app/Screens/trip_ticket.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/vehicle_description_db.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';

import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class TripTickerPage extends StatefulWidget {
  const TripTickerPage({
    super.key,
  });

  @override
  State<TripTickerPage> createState() => _TripTickerPageState();
}

class _TripTickerPageState extends State<TripTickerPage> {
  void _navigateToChecklistandCustomerList(BuildContext context) {
    Provider.of<TimelineProvider>(context, listen: false)
        .updateTimeline('Pending');

    context.push('/checklist-and-customerlist');
  }

  @override
  Widget build(BuildContext context) {
    String tripId = dummyTripTicket[0].tripId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tripId),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.surface,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(),
                ),
                SliverToBoxAdapter(
                  child: _buildTitle(),
                ),
                SliverToBoxAdapter(
                  child: _buildTripTicketList(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80), // Add space for the button
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildDepartureButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return VehicleDescriptionDb(tripTicketComplete: dummyTripTicket[0]);
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        'Deliveries',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTripTicketList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const PageScrollPhysics(),
      itemCount: dummyTripTicket.length,
      itemBuilder: (context, index) {
        return TripTickets(tripTicket: dummyTripTicket[index]);
      },
    );
  }

  Widget _buildDepartureButton() {
    return GestureDetector(
      onTap: () => _navigateToChecklistandCustomerList(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Accept Trip',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
