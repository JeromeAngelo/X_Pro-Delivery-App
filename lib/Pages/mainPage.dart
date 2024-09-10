import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/main_page_dashboard.dart';
import 'package:x_pro_delivery_app/Widget/Drawer.Screen.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';

class MainpageScreen extends StatefulWidget {
  const MainpageScreen({super.key});

  @override
  State<MainpageScreen> createState() => _MainpageScreenState();
}

class _MainpageScreenState extends State<MainpageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Icon(
            Icons.account_circle_rounded,
            color: Theme.of(context).colorScheme.surface,
          )
        ],
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Dashboard of the User
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dummyTripTicket.length,
            itemBuilder: (context, index) => MainPageDashboard(
              tripTicketComplete: dummyTripTicket[index],
            ),
          ),
          //Delivery Customer and Routings
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: GestureDetector(
              onTap: () => context.push('/in-route'),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.route_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'View Deliveries',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Delivery Routes',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),

          //trip Summary
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: GestureDetector(
              onTap: () => context.push('/return'),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.summarize_sharp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text('Trip Summary',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    'Returns, Collections and etc.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
