import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pro_delivery_app/Utils/return_checkList._items.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/trip_summary_dashboard.dart';
import 'package:x_pro_delivery_app/Widget/Drawer.Screen.dart';
import 'package:x_pro_delivery_app/data/trips_summary_data.dart';
import 'package:x_pro_delivery_app/main.dart';
import 'package:x_pro_delivery_app/model/item_list_model.dart';

class ReturnPage extends StatefulWidget {
  const ReturnPage({super.key});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  List<ItemListModel> returnedItems = [];
  void _navigateToOtpForEndDeliveryPage(BuildContext context) {
    context.replace('/otp-end-delivery');
  }

  void _navigateToCollectionSummary(BuildContext context) {
    context.push('/collection-summary');
  }

  void _navigateToViewReturns(BuildContext context) {
    context.push('/view-return');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trip Summary'),
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
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Dashboard
                  _buildTripSummaryDashboard(),
                  _buildSectionTitle(context, "Checklist"),
                  const ReturnChecklistItems(),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, "Collection Summary"),
                  _buildCard(
                    context,
                    "View Collection Summary",
                    Icons.collections_bookmark_rounded,
                    () {
                      _navigateToCollectionSummary(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, "Returns Items"),
                  _buildCard(
                    context,
                    "View Return ",
                    Icons.collections_bookmark_rounded,
                    () {
                      _navigateToViewReturns(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildEndTripButton(),
        ],
      ),
    );
  }

  Widget _buildTripSummaryDashboard() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyTripSummary.length,
      itemBuilder: (context, index) {
        return TripSummaryDashboard(tripSummaryModel: dummyTripSummary[index]);
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildEndTripButton() {
    return ValueListenableBuilder<bool>(
        valueListenable: greetingSplashButtonClicked,
        builder: (context, isClicked, child) {
          return GestureDetector(
            onTap: isClicked
                ? null
                : () => _navigateToOtpForEndDeliveryPage(context),
            child: Opacity(
              opacity: isClicked ? 0.5 : 1.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
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
        });
  }
}
