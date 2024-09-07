import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EndGameScreen(),
    );
  }
}

class EndGameScreen extends StatefulWidget {
  @override
  _EndGameScreenState createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.grey[700]),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline, color: Colors.grey[700]),
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.5),
                            child: LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.orange[200],
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "EXCELLENT!",
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Score Section
                      Text(
                        "SCORE",
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.5),
                          child: LinearProgressIndicator(
                            value: 0.9,
                            backgroundColor: Colors.orange[200],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "18 / 20",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Experience Points
                      Text(
                        "EXPERIENCE POINTS",
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "1028 XP",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 100, color: Colors.yellow),
                          Icon(Icons.star, size: 100, color: Colors.yellow),
                          Icon(Icons.star_border, size: 100, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                shouldLoop: false,
                colors: [Colors.red, Colors.blue, Colors.yellow, Colors.green],
                createParticlePath: drawStar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path drawStar(Size size) {
    double width = size.width;
    double halfWidth = width / 2;
    double outerRadius = halfWidth;
    double innerRadius = outerRadius / 2.5;
    double step = pi / 5;

    Path path = Path();
    for (int i = 0; i < 10; i++) {
      double radius = i.isEven ? outerRadius : innerRadius;
      double x = halfWidth + radius * cos(i * step);
      double y = halfWidth - radius * sin(i * step);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }
}