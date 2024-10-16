import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class GrammarQuestion extends StatefulWidget {
  const GrammarQuestion({super.key, required this.phrase, required this.isCorrect, required this.onAnswer});
  final String? phrase;
  final bool? isCorrect;
  final void Function(bool)? onAnswer;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {

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
              TextSpan(text: 'Identify if the sentence\nis '),
              TextSpan(
                text: ' grammatically correct.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            widget.phrase!,
            style: kSubtext20,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OvalButton(
                color: kOrangeColor600,
                onPressed: () {
                  // Check if 'CORRECT' is the right answer
                  widget.onAnswer!(true);
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
                  // Check if 'INCORRECT' is the right answer
                  widget.onAnswer!(false);
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
    );
  }
}
