import 'dart:math';
import 'package:diction_dash/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:confetti/confetti.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';

class EndGameScreen extends StatefulWidget {
  final int correctScore; // Correct score parameter
  final VoidCallback onCorrect; // Callback function for correct score
  final Future<void> Function(String, int)? rewardEXP;

  const EndGameScreen({
    super.key,
    required this.correctScore,
    required this.onCorrect, //
    this.rewardEXP,// Require onCorrect parameter
  });

  @override
  _EndGameScreenState createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> {

  final FirestoreService firestoreService = FirestoreService();
  final String userID = FirebaseAuth.instance.currentUser!.uid;

  late ConfettiController _confettiController;
  List<Color> starColors = []; //Colors of stars in order

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();

    // Set star colors based on score
    if (widget.correctScore == 0) {
      starColors = [Colors.grey, Colors.grey, Colors.grey];
    } else if (widget.correctScore <= 4) {
      starColors = [Colors.yellow, Colors.grey, Colors.grey];
    } else if (widget.correctScore <= 8) {
      starColors = [Colors.yellow, Colors.yellow, Colors.grey];
    } else {
      starColors = [Colors.yellow, Colors.yellow, Colors.yellow];
    }

    // Call onCorrect if the score is correct
    if (widget.correctScore == 10) {
      widget.onCorrect();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progVal = widget.correctScore * 0.1;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: kGrayColor500,
                            size: 35,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: kGrayColor300,
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          child: QuestionBar(questionNumber: 10,),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.help,
                          color: kGrayColor500,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),

                const Text('EXCELLENT!', style: kOswaldExtraLarge),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      const Text('SCORE: ', style: kOswaldMedium),
                      // Linear Progress Indicator for Score
                      Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: kGrayColor300,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(90.0),
                              child: LinearProgressIndicator(
                                value: progVal, // Set this based on the correctScore
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor600),
                                minHeight: 30,
                              ),
                            ),
                            // Centered Text
                            Center(
                              child: Text(
                                '${widget.correctScore} / 10', // Display correct score here
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('EXPERIENCE POINTS', style: kOswaldMedium),
                      Text(
                        '+${widget.correctScore * 10} XP',
                        style: kButtonTextStyleOrange.copyWith(fontSize: 36),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 120, color: starColors[0]),
                    Icon(Icons.star, size: 120, color: starColors[1]),
                    Icon(Icons.star, size: 120, color: starColors[2]),
                  ],
                ),

                // Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedRectangleButton(
                    color: kOrangeColor600,
                    onPressed: () async {
                      print('Continue');
                      await widget.rewardEXP!(userID, widget.correctScore * 10);
                      await firestoreService.updateLevelAndEXP(userID);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: kButtonTextStyleWhite,
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