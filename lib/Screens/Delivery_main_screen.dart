import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/Widget/update_status_drawer.dart';
import 'package:x_pro_delivery_app/Widget/Time_lines/update_timeline.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/customer_details_dashboard.dart';
import 'package:x_pro_delivery_app/Widget/maps.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';

import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class DeliveryMainScreen extends StatefulWidget {
  const DeliveryMainScreen({super.key});

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryMainScreen> {
  void _showMap() {
    setState(() {
      Provider.of<TimelineProvider>(context, listen: false)
          .toggleMapVisibility();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimelineProvider>(context, listen: false)
          .setInitialPendingStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimelineProvider>(
        builder: (context, timelineProvider, child) => Scaffold(
              appBar: _buildAppBar(),
              body: _buildBody(context),
            ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Row(
        children: [
          Text('Delivery No. : '),
          SizedBox(width: 2),
          Text('1089098')
        ],
      ),
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildCustomerDetails()),
            SliverToBoxAdapter(
              child: Consumer<TimelineProvider>(
                builder: (context, timelineProvider, child) {
                  if (timelineProvider.isMapVisible) {
                    return const MapsScreen();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildsubtitle()),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Consumer<TimelineProvider>(
                builder: (context, timelineProvider, child) =>
                    UpdateTimeLine(timeline: timelineProvider.timeline),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildEndDeliveryButton(context),
        ),
      ],
    );
  }

  Widget _buildsubtitle() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Timeline',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ));
  }

  Widget _buildCustomerDetails() {
    return Consumer<TimelineProvider>(
      builder: (context, timelineProvider, child) {
        final currentStatus = timelineProvider.timeline.isNotEmpty
            ? timelineProvider.timeline.first.title
            : 'Pending';

        // Assuming you want to show the first customer in the list
        final specificCustomer = dummyTripTicket[0].customerList[0];

        return CustomerDetailsDashboard(
          onTap: _showMap,
          tripTicket: TripTicketComplete(
            customerList: [specificCustomer],
            tripId: dummyTripTicket[0].tripId,
            checkList: dummyTripTicket[0].checkList,
            deliveryTeam: dummyTripTicket[0].deliveryTeam,
            dateTime: dummyTripTicket[0].dateTime,
          ),
          status: currentStatus,
        );
      },
    );
  }

  void _showStatusDrawer(BuildContext context) {
    showModalBottomSheet(
      isDismissible: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return const UpdateStatusDrawer();
      },
    );
  }

  Widget _buildEndDeliveryButton(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final isEndDelivery = timelineProvider.timeline.isNotEmpty &&
        timelineProvider.timeline.first.title == 'End Delivery';

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isEndDelivery
                ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: isEndDelivery ? null : () => _showStatusDrawer(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.update_rounded,
                    color: Theme.of(context).colorScheme.onPrimary),
                const SizedBox(width: 2),
                Text(
                  'Update Delivery',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
