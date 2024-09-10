import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:x_pro_delivery_app/Utils/digital_clock.dart';

class OtpForEndDelivery extends StatelessWidget {
  const OtpForEndDelivery({super.key});

  void _navigateToInRoutePage(BuildContext context) {
    context.go("/greetingscreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    _buildTitle(context),
                    const SizedBox(height: 20),
                    _buildInstructions(context),
                    const SizedBox(height: 20),
                    const DigitalClocks(),
                    _buildOTPInput(context),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Verification",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Column(
      children: [
        Text(
          "Guard instructions......",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          "Enter the OTP code sent to your phone",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOTPInput(BuildContext context) {
    return Pinput(
      length: 6,
      showCursor: true,
      onCompleted: (pin) => debugPrint(pin),
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isKeyboardVisible ? 0 : 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ElevatedButton(
          onPressed: () => _navigateToInRoutePage(context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Confirm',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
        ),
      ),
    );
  }
}
