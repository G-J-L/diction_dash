import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // A circular container that scales larger than the screen
              Transform.scale(
                scale: 4.0, // Scale to make it larger than the screen
                child: Container(
                  width: MediaQuery.of(context).size.width / 2, // Fixed size
                  height: MediaQuery.of(context).size.width / 2, // Fixed size to ensure it's circular
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Content that stays in the center
              Text(
                'Circular Container',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}