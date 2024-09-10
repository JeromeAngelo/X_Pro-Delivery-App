import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:x_pro_delivery_app/Screens/send_update.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class UpdateStatusDrawer extends StatefulWidget {
  const UpdateStatusDrawer({super.key});

  @override
  State<UpdateStatusDrawer> createState() => _UpdateStatusDrawerState();
}

class _UpdateStatusDrawerState extends State<UpdateStatusDrawer> {
  void _showSendUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SendUpdate(),
    );
  }

  void _updateStatus(String status) {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    timelineProvider.updateDeliveryStatus(status);

    if (status == 'End Delivery') {
      timelineProvider.setDeliveryCompleted(true);
    } else if (timelineProvider.timeline.isEmpty ||
        timelineProvider.timeline.first.title != status) {
      timelineProvider.updateDeliveryStatus(status);
      context.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Status set to $status',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.surface),
          ),
          duration: const Duration(milliseconds: 1000),
        ),
      );
    }
    context.pop(context);
  }

  void _navigateToRoutePage() {
    context.replace('/in-route');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          'Transaction Completed',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  Widget _buildStatusTile(String status, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        status,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: () => _updateStatus(status),
    );
  }

  Widget _buildSendUpdateTile() {
    return ListTile(
      leading: Icon(
        Icons.send_and_archive,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        'Send Update',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: () => _showSendUpdateDialog(context),
    );
  }

  Widget _buildEndDeliveryTile() {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final currentStatus = timelineProvider.timeline.isNotEmpty
        ? timelineProvider.timeline.first.title
        : '';

    bool isClickable = currentStatus == 'Mark as Undeliverable' ||
        currentStatus == 'Unloading';

    return ListTile(
      leading: Icon(
        Icons.exit_to_app_outlined,
        color: !isClickable
            ? Theme.of(context).colorScheme.outline
            : Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        'End Delivery',
        style: !isClickable
            ? Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.outline)
            : Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: isClickable
          ? () {
              _updateStatus('End Delivery');
              _navigateToRoutePage();
            }
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final currentStatus = timelineProvider.timeline.isNotEmpty
        ? timelineProvider.timeline.first.title
        : '';

    List<Widget> drawerOptions = [];

    drawerOptions.add(_buildSendUpdateTile());

    drawerOptions.add(const Divider(thickness: 1));
    drawerOptions.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Set Status',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    if (currentStatus == 'Arrived') {
      drawerOptions.addAll([
        _buildStatusTile('Waiting for Customer', Icons.access_time),
        _buildStatusTile('Unloading', Icons.unarchive),
      ]);
    } else if (currentStatus == 'In Transit') {
      drawerOptions.addAll([
        _buildStatusTile('Arrived', Icons.location_on),
        _buildStatusTile('Mark as Undeliverable', Icons.warning),
      ]);
    } else if (currentStatus == 'Waiting for Customer') {
      drawerOptions.addAll([
        _buildStatusTile('Unloading', Icons.unarchive),
      ]);
    } else if (currentStatus == 'Unloading') {
      // Only Send Update and End Delivery are maintained
    } else if (currentStatus == 'Mark as Undeliverable') {
    } else {
      drawerOptions.addAll([
        _buildStatusTile('Arrived', Icons.location_on),
        _buildStatusTile('Mark as Undeliverable', Icons.warning),
        _buildStatusTile('Waiting for Customer', Icons.access_time),
        _buildStatusTile('Unloading', Icons.unarchive),
      ]);
    }
    drawerOptions.add(_buildEndDeliveryTile());
    return DraggableScrollableSheet(
      initialChildSize: .6,
      minChildSize: .2,
      maxChildSize: .9,
      expand: false,
      builder: (_, controller) => SingleChildScrollView(
        child: Wrap(
          children: drawerOptions,
        ),
      ),
    );
  }
}
