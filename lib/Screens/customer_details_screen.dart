import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/Widget/maps.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/customer_details_dashboard.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/model/trip_ticket_complete.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  void _showMap() {
    setState(() {
      Provider.of<TimelineProvider>(context, listen: false)
          .toggleMapVisibility();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimelineProvider>(
      builder: (context, timelineProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Delivery Number: 1089098'),
        ),
        body: Stack(
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
                SliverToBoxAdapter(child: _buildInvoicesList()),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetails() {
    return Consumer<TimelineProvider>(
      builder: (context, timelineProvider, child) {
        final currentStatus = timelineProvider.timeline.isNotEmpty
            ? timelineProvider.timeline.first.title
            : 'Pending';

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

  Widget _buildInvoicesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () => context.push('/invoice-list'),
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: Icon(
              Icons.summarize_sharp,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text('View List of Invoices',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Invoices, Products, etc.',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
