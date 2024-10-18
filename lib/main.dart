import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationExample(),
    );
  }
}

class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the Tween for moving the widget horizontally
    _animation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Method to start and stop the animation
  void _startStopAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
      setState(() {
        _isAnimating = false;
      });
    } else {
      _controller.forward(from: 0.0);
      setState(() {
        _isAnimating = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Left to Right Animation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.only(left: _animation.value),
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startStopAnimation,
              child: Text(_isAnimating ? 'Stop Animation' : 'Start Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
