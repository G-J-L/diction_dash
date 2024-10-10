import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion({super.key, this.word, this.choices, this.answer});
  final String? word;
  final List<String>? choices;
  final String? answer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
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
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      widget.choices![0],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      widget.choices![1],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                  child: Center(
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    child: Text(
                      widget.choices![2],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      widget.choices![3],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
