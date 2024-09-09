import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key});

  @override
  State<ComprehensionScreen> createState() => _ComprehensionScreenState();
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Bar
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
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
                        color: kOrangeColor600,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: Center(
                        child: Text(
                          '20 / 20',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {
                        showGameDescription(context,
                            title: 'Comprehension',
                            description:
                                'Analyze the sentence\ncarefully, and read it more\nthan once to be sure.');
                      },
                      child: Icon(
                        Icons.help,
                        color: kGrayColor500,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(
                    text: 'Comprehend',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: ' the sentence\nand answer the given question.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'The cat jumped onto the\nand answer the given question.\n\nWhat did the cat do?',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 15.0),
              child: Column(
                children: [
                  ChoiceButton(
                    text: 'enjoyed the view',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: 'leaped from a window',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: 'hissed at the dog',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: 'washed the brids',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  ChoiceButton({this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OvalButton(
      color: kOrangeColor600,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          text!,
          style: kButtonTextStyleWhite20,
        ),
      ),
    );
  }
}
