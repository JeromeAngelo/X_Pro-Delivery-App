import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/document/files/document_files.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/others/other_items.dart';
import 'package:x_pro_delivery_app/Screens/Item_list/tools_equipments/tools_and_equipments.dart';
import 'package:x_pro_delivery_app/Screens/customer_details_screen.dart';
import 'package:x_pro_delivery_app/Utils/checkList_items.dart';
import 'package:x_pro_delivery_app/Utils/customer_list.dart';

import 'package:x_pro_delivery_app/data/checkListData.dart';
import 'package:x_pro_delivery_app/data/customerListfdata.dart';
import 'package:x_pro_delivery_app/data/dummy_trip_ticket.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class ChecklistCustomerlist extends StatefulWidget {
  const ChecklistCustomerlist({super.key});

  @override
  State<ChecklistCustomerlist> createState() => _ChecklistCustomerlistState();
}

class _ChecklistCustomerlistState extends State<ChecklistCustomerlist> {
  void _navigateToOtpPage(BuildContext context) {
    Provider.of<TimelineProvider>(context, listen: false)
        .updateTimeline('In Transit');
    context.push('/otp');
  }

  void _navigateToListPage(BuildContext context, int index) async {
    final List<Widget> pages = [
      const DocumentFilesScreen(),
      const ToolsAndEquipments(),
      const OtherItemsScreen()
    ];
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return pages[index];
      },
    ));

    if (result != null && result is int) {
      // Update the quantity for the corresponding checklist item
      setState(() {
        dummyCheckList[index].quantity = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String tripId = dummyTripTicket[0].tripId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tripId),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const Text(
                        "Checklist",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dummyCheckList.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            _navigateToListPage(context, index);
                          },
                          child: CheckListItems(
                            checklistModel: dummyCheckList[index],
                            onTap: () => _navigateToListPage(context, index),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Deliveries",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dummyTripTicket.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CustomerDetailsScreen(),
                              ));
                            },
                            child: CustomerList(
                                tripTicket: dummyTripTicket[index]),
                          );
                        },
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () => _navigateToOtpPage(context),
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
                      'Depart',
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
        ],
      ),
    );
  }
}
