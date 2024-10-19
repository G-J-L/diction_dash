import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import '../../../services/words_api.dart';

class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion({super.key, required this.word, required this.choices, required this.onAnswer, required this.answer});
  final String word;
  final Function(String, String) onAnswer;
  final List<String> choices;
  final String answer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          widget.word,
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
                  widget.onAnswer(widget.choices[0], widget.answer);
                },
                child: Center(
                  child: Text(
                    widget.choices[0],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: kOrangeColor600,
                onPressed: () {
                  widget.onAnswer(widget.choices[1], widget.answer);
                },
                child: Center(
                  child: Text(
                    widget.choices[1],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: kOrangeColor600,
                onPressed: () {
                  widget.onAnswer(widget.choices[2], widget.answer);
                },
                child: Center(
                  child: Text(
                    widget.choices[2],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: kOrangeColor600,
                onPressed: () {
                  widget.onAnswer(widget.choices[3], widget.answer);
                },
                child: Center(
                  child: Text(
                    widget.choices[3],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
