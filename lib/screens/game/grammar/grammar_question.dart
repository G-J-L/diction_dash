import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class GrammarQuestion extends StatefulWidget {
  const GrammarQuestion({super.key, this.questionNumber, this.phrase, this.isCorrect});
  final int? questionNumber;
  final String? phrase;
  final bool? isCorrect;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {
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
                      onTap: (){
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
                      onTap: (){
                        showGameDescription(context, title: 'Grammar', description: 'Analyze the sentence\ncarefully, and read it more\nthan once to be sure.');
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
                  TextSpan(text: 'Identify if the sentence\nis '),
                  TextSpan(
                    text: ' grammatically correct.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.phrase!,
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('CORRECT');
                      // TODO: CHECK IF isCORRECT == true
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'CORRECT',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: Colors.white,
                    borderColor: kOrangeColor600,
                    onPressed: () {
                      print('INCORRECT');
                      // TODO: CHECK IF isCORRECT == false
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'INCORRECT',
                        style: kButtonTextStyleOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
