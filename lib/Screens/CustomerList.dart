import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/Utils/customerList.dart';
import 'package:x_pro_delivery_app/data/customerListfdata.dart';
import 'package:x_pro_delivery_app/model/customer_model.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final List<CustomerModel> _customerList = dummyCustomer;
  final Set<int> _checkedItems = {};

  void _toggleChecked(int index) {
    setState(() {
      if (_checkedItems.contains(index)) {
        _checkedItems.remove(index);
      } else {
        _checkedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer List',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstructionsContainer(),
                const SizedBox(height: 12),
                _buildCustomerList(),
                const SizedBox(height: 12),
                _buildConfirmationBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionsContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions here........",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _customerList.length,
      itemBuilder: (context, index) {
        return CustomerDashBoard(
          customerModel: _customerList[index],
        );
      },
    );
  }

  Widget _buildConfirmationBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '${_checkedItems.length}/${_customerList.length}, Confirm',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
      ),
    );
  }
}
