import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pro_delivery_app/Utils/delivery_list.dart';
import 'package:x_pro_delivery_app/Widget/Drawer.Screen.dart';
import 'package:x_pro_delivery_app/Widget/Time_lines/inroute_update_timeline.dart';

import 'package:x_pro_delivery_app/data/delivery_customer_data.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/main.dart';

import 'package:x_pro_delivery_app/model/delivery_customer_model.dart';

class InRoutePage extends StatefulWidget {
  const InRoutePage({super.key});

  @override
  State<InRoutePage> createState() => _InRoutePageState();
}

class _InRoutePageState extends State<InRoutePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<DeliveryCustomerModel> customerList = deliveryCustomerList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToDeliveryPage() {
    context.push('/delivery-and-invoice');
  }

  void _navigateToReturnPage() {
    context.push('/return');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTripTicketNumber(),
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Deliveries', icon: Icon(Icons.local_shipping)),
            Tab(text: 'Updates', icon: Icon(Icons.update)),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDeliveriesContent(),
          _buildUpdatesContent(),
        ],
      ),
    );
  }

  Widget _buildDeliveriesContent() {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildDeliveryList(),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: _buildEndTripButton(),
        ),
      ],
    );
  }

  Widget _buildUpdatesContent() {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const InRouteUpdateTimeLine(),
                  ]),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: _buildAddUpdateButton(),
        ),
      ],
    );
  }

  Widget _buildTripTicketNumber() {
    return Row(
      children: [
        Text(
          "Ticket No. : ",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
        const SizedBox(width: 2),
        Text(
          "0917973197",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
      ],
    );
  }

  Widget _buildDeliveryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Deliveries",
        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //         color: Theme.of(context).colorScheme.onSurface,
        //         fontWeight: FontWeight.bold,
        //       ),
        // ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: _navigateToDeliveryPage,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyTripTicket.length,
            itemBuilder: (context, index) {
              return DeliveryList(tripTicket: dummyTripTicket[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUpdatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [const InRouteUpdateTimeLine(), _buildAddUpdateButton()],
    );
  }

  Widget _buildAddUpdateButton() {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        // Handle the selection here
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.update_sharp,
                    color: Theme.of(context).colorScheme.onPrimary),
                const SizedBox(width: 8),
                Text(
                  'Add Update',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              child: Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Add Update',
          child: Text('Add Update'),
        ),
        const PopupMenuItem<String>(
          value: 'General Update',
          child: Text('General Update'),
        ),
      ],
    );
  }

  Widget _buildEndTripButton() {
    return ValueListenableBuilder<bool>(
        valueListenable: greetingSplashButtonClicked,
        builder: (context, isClicked, child) {
          return GestureDetector(
            onTap: isClicked ? null : _navigateToReturnPage,
            child: Opacity(
              opacity: isClicked ? 0.5 : 1.0,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app_outlined,
                        color: Theme.of(context).colorScheme.onPrimary),
                    const SizedBox(width: 2),
                    Text(
                      'End Trip',
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
          );
        });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
