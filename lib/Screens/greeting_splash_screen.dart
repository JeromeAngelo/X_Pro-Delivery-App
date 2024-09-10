import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:x_pro_delivery_app/main.dart';

class GreetingSplashScreen extends StatefulWidget {
  const GreetingSplashScreen({super.key});

  @override
  State<GreetingSplashScreen> createState() => _GreetingSplashScreenState();
}

class _GreetingSplashScreenState extends State<GreetingSplashScreen> {
  void _navigateToHome() {
    greetingSplashButtonClicked.value = true;
    context.go('/main-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image of Greetings or GIF
            Column(
              children: [
                Image.asset(
                  'image/truck.png',
                  height: 200,
                  width: 200,
                  color: Theme.of(context).colorScheme.primary,
                ),
                //Text of greetings
                Text(
                  'All Deliveries Completed',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),

            //Button for the homepage
            GestureDetector(
              onTap: () => _navigateToHome(),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.surface,
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
                    child: Center(
                      child: Text(
                        'Proceed to Homepage',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
