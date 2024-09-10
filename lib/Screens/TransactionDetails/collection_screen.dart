import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pro_delivery_app/Utils/DashBoards/collection_dashboard.dart';
import 'package:x_pro_delivery_app/data/collection_dummy_data.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  String? selectedPaymentMode;
  String? selectedEWalletType;
  bool showChequeNumberField = false;
  bool showEWalletFields = false;

  @override
  Widget build(BuildContext context) {
    void navigateToDrPage() {
      context.push('/dr');
    }

    void showOptionsDrawer() {
      showModalBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Confirm Payment'),
                onTap: () {
                  navigateToDrPage();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      content: Text(
                        'Payment Confirmed',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.update,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Add Update'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your logic for Add Update here
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection/Payment Details'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: collectionData.length,
                    itemBuilder: (context, index) {
                      return CollectionDashboardScreen(
                          collectionDetails: collectionData[index]);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reminder: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.bold)),
                            Text(
                                'Please ensure that the total amount received from the customer matches the total amount stated on the receipt. If there is any discrepancy or mismatch, please contact our company immediately to resolve the issue.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                            labelText: 'Mode of Payment',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          value: selectedPaymentMode,
                          items: <String>[
                            'Bank Transfer',
                            'Cash on Delivery',
                            'Cheque',
                            'E-Wallet'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPaymentMode = newValue;
                              showChequeNumberField = newValue == 'Cheque';
                              showEWalletFields = newValue == 'E-Wallet';
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        if (showChequeNumberField)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter Cheque Number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    label: const Text('Cheque Number'),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        if (showEWalletFields)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'E-Wallet Type',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                value: selectedEWalletType,
                                items: <String>[
                                  'GCash',
                                  'Maya'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedEWalletType = newValue;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'E-Wallet Account',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        Text('Enter total amount collected',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: const Text('₱'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () => showOptionsDrawer(),
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
                        Icon(Icons.payment,
                            color: Theme.of(context).colorScheme.onPrimary),
                        const SizedBox(width: 2),
                        Text(
                          'Confirm Payment',
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
            ),
          ),
        ],
      ),
    );
  }
}
