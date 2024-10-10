import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion({super.key, this.questionNumber, this.word, this.choices, this.answer});
  final int? questionNumber;
  final String? word;
  final List<String?>? choices;
  final String? answer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
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
                        showGameDescription(context, title: 'Vocabulary', description: 'Select which of the four\noptions you believe to be\nthe best response.');
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
                  TextSpan(text: 'Select the appropriate\n'),
                  TextSpan(
                    text: 'synonym.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.word!,
              style: kOswaldLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print(widget.choices![0]!);
                      // TODO: CHECK IF CHOICE IS EQUAL TO ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        widget.choices![0]!,
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print(widget.choices![1]!);
                      // TODO: CHECK IF CHOICE IS EQUAL TO ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        widget.choices![1]!,
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print(widget.choices![2]!);
                      // TODO: CHECK IF CHOICE IS EQUAL TO ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        widget.choices![2]!,
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print(widget.choices![3]!);
                      // TODO: CHECK IF CHOICE IS EQUAL TO ANSWER
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        widget.choices![3]!,
                        style: kButtonTextStyleWhite,
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
