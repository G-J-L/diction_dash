import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

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
  List<Color> buttonColors = [kOrangeColor600, kOrangeColor600, kOrangeColor600, kOrangeColor600];
  bool isAnswered = false; // Prevent multiple selections

  // Handle user's answer
  void handleAnswer(String selectedChoice) {
    if (isAnswered) return; // Prevent multiple taps after answering

    setState(() {
      isAnswered = true; // Lock the answers after one selection

      // Update button colors: red for incorrect, green for correct
      for (int i = 0; i < widget.choices.length; i++) {
        if (widget.choices[i] == widget.answer) {
          buttonColors[i] = Colors.green; // Correct answer in green
        } else if (widget.choices[i] == selectedChoice) {
          buttonColors[i] = Colors.redAccent; // Selected incorrect answer in red
        }
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer(selectedChoice, widget.answer); // Call onAnswer function

      // Reset the state for the next question
      setState(() {
        // Reset button colors and unlock the buttons for the next question
        buttonColors = [kOrangeColor600, kOrangeColor600, kOrangeColor600, kOrangeColor600];
        isAnswered = false; // Allow buttons to be pressed again
      });
    });
  }

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
                color: buttonColors[0],
                onPressed: !isAnswered
                    ? () => handleAnswer(widget.choices[0])
                    : null, // Disable button if already answered
                child: Center(
                  child: Text(
                    widget.choices[0],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: buttonColors[1],
                onPressed: !isAnswered
                    ? () => handleAnswer(widget.choices[1])
                    : null,
                child: Center(
                  child: Text(
                    widget.choices[1],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: buttonColors[2],
                onPressed: !isAnswered
                    ? () => handleAnswer(widget.choices[2])
                    : null,
                child: Center(
                  child: Text(
                    widget.choices[2],
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
              OvalButton(
                color: buttonColors[3],
                onPressed: !isAnswered
                    ? () => handleAnswer(widget.choices[3])
                    : null,
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
