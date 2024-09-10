import 'package:flutter/material.dart';

class EnterCode extends StatelessWidget {
  const EnterCode({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Enter Trip-Ticket Code',
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Search Code',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Optional: Handle text changes if needed
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Handle search action
              // You might want to use the entered code here
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Search'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
