import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:x_pro_delivery_app/Widget/app_icon.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  void _logIn(BuildContext context) {
    context.go('/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLoginForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: 120,
                height: 120,
                child: const AppIcon(),
              ),
              _buildTextField(
                context: context,
                icon: Icons.person,
                label: 'Username',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                icon: Icons.lock,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock),
                label: const Text('Login'),
                onPressed: () => _logIn(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required IconData icon,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        suffixIcon: Icon(icon),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
    );
  }
}
