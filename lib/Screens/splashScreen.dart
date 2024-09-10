import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(const Duration(seconds: 3), () {
      context.go('/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "image/logos.png",
              width: 300,
              height: 300,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    left: MediaQuery.of(context).size.width *
                            0.8 *
                            _animation.value -
                        25,
                    child: Icon(Icons.local_shipping,
                        size: 50, color: Theme.of(context).primaryColor),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
