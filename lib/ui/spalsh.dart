import 'package:flutter/material.dart';
import 'package:tech_test/base/font_style.dart';
import 'package:tech_test/base/utils.dart';

/// A splash screen that displays a fading animation of the app's name.
class SplashScreen extends StatefulWidget {
  /// A callback function that is triggered when the splash screen is complete.
  final VoidCallback onComplete;

  /// Creates a new instance of the [SplashScreen].
  const SplashScreen({super.key, required this.onComplete});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation indefinitely

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Disposes of the animation controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBar(); // Sets the status bar style for the splash screen
    Future.delayed(const Duration(seconds: 6), widget.onComplete); // Delay before calling onComplete callback

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            'PIXABAY',
            style: FontStyle.absurdWordSemiBoldTextColor_16,
          ),
        ),
      ),
    );
  }
}
