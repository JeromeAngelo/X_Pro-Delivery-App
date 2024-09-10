import 'package:flutter/material.dart';

class TruckLoadingAnimation extends StatefulWidget {
  const TruckLoadingAnimation({super.key});

  @override
  _TruckLoadingAnimationState createState() => _TruckLoadingAnimationState();
}

class _TruckLoadingAnimationState extends State<TruckLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 5).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            LinearProgressIndicator(
              value: _animation.value,
              backgroundColor: Colors.grey[300],
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  left:
                      MediaQuery.of(context).size.width * _animation.value - 50,
                  child: Icon(Icons.local_shipping,
                      size: 60, color: Theme.of(context).primaryColor),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
