import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Screens/Delivery_main_screen.dart';
import 'package:x_pro_delivery_app/Screens/TransactionDetails/invoice_list.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DeliveryMainScreen(),
    const InvoiceNumberList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Delivery',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
            ),
            label: 'Invoices',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: _onItemTapped,
      ),
    );
  }
}
