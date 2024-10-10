import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class ComprehensionQuestion extends StatefulWidget {
  const ComprehensionQuestion({super.key, this.paragraph, this.question, this.choices, this.answer});
  final String? paragraph;
  final String? question;
  final List<String?>? choices;
  final String? answer;

  @override
  State<ComprehensionQuestion> createState() => _ComprehensionQuestionState();
}

class _ComprehensionQuestionState extends State<ComprehensionQuestion> {
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
                  text: widget.choices![0],
                  onPressed: () {
                    // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                ),
                ChoiceButton(
                  text: widget.choices![1],
                  onPressed: () {
                    // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                ),
                ChoiceButton(
                  text: widget.choices![2],
                  onPressed: () {
                    // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EndGameScreen(),
                      ),
                    );
                  },
                ),
                ChoiceButton(
                  text: widget.choices![3],
                  onPressed: () {
                    // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
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
          ),
        ],
      ),
    );
  }
}
