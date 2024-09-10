import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text("John Doe"),
            accountEmail: const Text("johndoe@example.com"),
            currentAccountPicture: CircleAvatar(
              child: Image.asset(
                "image/sample_admin.png",
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to home screen
              Navigator.popAndPushNamed(context, 'main-page');
            },
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.map),
            title: const Text('Routes'),
            onTap: () {
              // Navigate to settings screen
              Navigator.popAndPushNamed(context, 'in-route');
            },
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.local_shipping_outlined),
            title: const Text('Delivery Route History'),
            onTap: () {
              // Navigate to settings screen
              Navigator.popAndPushNamed(context, 'delivery-and-invoice');
            },
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.reset_tv),
            title: const Text('Returns'),
            onTap: () {
              // Navigate to settings screen
              Navigator.popAndPushNamed(context, 'return');
            },
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to profile screen
            },
          ),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.update),
            title: const Text('Version 1.0.0'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          const Divider(),
          ListTile(
            textColor: Theme.of(context).colorScheme.onSurface,
            iconColor: Theme.of(context).colorScheme.onSurface,
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              // Perform logout action
              Navigator.popAndPushNamed(context, '/auth');
            },
          ),
        ],
      ),
    );
  }
}
