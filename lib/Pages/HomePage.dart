import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:x_pro_delivery_app/Utils/DashBoards/main_page_dashboard.dart';
import 'package:x_pro_delivery_app/Widget/Drawer.Screen.dart';
import 'package:x_pro_delivery_app/Widget/entercode.dart';

import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/data/trips_summary_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _enterCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const EnterCode(),
    );
  }

  void _navigateToTripTicket() {
    context.push('/tickettrip');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
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
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildContent(),
                      const SizedBox(height: 20),
                      _centerScreen()
                    ]),
                  ),
                ),
              ],
            ),
          ),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyTripSummary.length,
      itemBuilder: (context, index) =>
          MainPageDashboard(tripTicketComplete: dummyTripTicket[index]),
    );
  }

  Widget _centerScreen() {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'image/no_ticket.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 20),
          Text(
            "No Active/Assigned Trip Tickets",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: DropdownButton<String>(
          menuWidth: 150,
          dropdownColor: Theme.of(context).colorScheme.primary,
          isExpanded: true,
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long,
                  color: Theme.of(context).colorScheme.surface),
              const SizedBox(width: 8),
              Text(
                'Get Trip',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          items: <Map<String, dynamic>>[
            {'text': 'Scan QR', 'icon': Icons.qr_code_scanner},
            {'text': 'Enter Code', 'icon': Icons.keyboard},
          ].map((Map<String, dynamic> item) {
            return DropdownMenuItem<String>(
              value: item['text'],
              child: Row(
                children: [
                  Icon(item['icon'],
                      color: Theme.of(context).colorScheme.surface),
                  const SizedBox(width: 8),
                  Text(
                    item['text'],
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue == 'Scan QR') {
              _navigateToTripTicket();
            } else if (newValue == 'Enter Code') {
              _enterCode();
            }
          },
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
          icon: Icon(Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.surface),
          underline: Container(
            height: 2,
          ),
        ),
      ),
    );
  }
}
