import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key, this.questionNumber, this.paragraph, this.question, this.choices, this.answer});
  final int? questionNumber;
  final String? paragraph;
  final String? question;
  final List<String?>? choices;
  final String? answer;

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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      child: QuestionBar(questionNumber: widget.questionNumber),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        showGameDescription(context,
                            title: 'Comprehension',
                            description:
                            'Analyze the sentence\ncarefully, and read it more\nthan once to be sure.');
                      },
                      child: const Icon(
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
            Text(
              '${widget.paragraph}\n${widget.question}',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Column(
                children: [
                  ChoiceButton(
                    text: widget.choices![0]!,
                    onPressed: () {
                      // TODO: CHECK IF CHOICE MATCHES ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: widget.choices![1]!,
                    onPressed: () {
                      // TODO: CHECK IF CHOICE MATCHES ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: widget.choices![2]!,
                    onPressed: () {
                      // TODO: CHECK IF CHOICE MATCHES ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                  ),
                  ChoiceButton(
                    text: widget.choices![3]!,
                    onPressed: () {
                      // TODO: CHECK IF CHOICE MATCHES ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
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

  const ChoiceButton({super.key, this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OvalButton(
      color: kOrangeColor600,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Text(
          text!,
          style: kButtonTextStyleWhite20,
        ),
      ),
    );
  }
}
