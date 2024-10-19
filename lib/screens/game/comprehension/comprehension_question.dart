import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

class ComprehensionQuestion extends StatefulWidget {
  const ComprehensionQuestion({super.key, required this.paragraph, required this.question, required this.choices, required this.answer, required this.onAnswer});
  final String? paragraph;
  final String? question;
  final List<String?>? choices;
  final String? answer;
  final void Function(String?)? onAnswer;

  @override
  State<ComprehensionQuestion> createState() => _ComprehensionQuestionState();
}

class _ComprehensionQuestionState extends State<ComprehensionQuestion> {

  List<Color>? buttonColors = [kOrangeColor600, kOrangeColor600, kOrangeColor600, kOrangeColor600];

  // TODO: CHANGE BUTTON COLOR FUNCTION
  Future<void> revealAnswers(int index) async {
    setState(() {
      buttonColors![index] = Colors.redAccent;
    });
    for (int i = 0; i < widget.choices!.length; i++) {
      if (widget.choices![i] == widget.answer) {
        setState(() {
          buttonColors![i] = Colors.green;
        });
        break;
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      buttonColors = [kOrangeColor600, kOrangeColor600, kOrangeColor600, kOrangeColor600];
    });
  }

  @override
  Widget build(BuildContext context) {
    // buttonColors = [kOrangeColor600, kOrangeColor600, kOrangeColor600, kOrangeColor600];
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            '${widget.paragraph}\n\n${widget.question}',
            style: kSubtext20,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
          child: Column(
            children: [
              ChoiceButton(
                text: widget.choices![0],
                color: buttonColors![0],
                onPressed: () async {
                  // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                  await revealAnswers(0);
                  widget.onAnswer!(widget.choices![0]);
                },
              ),
              ChoiceButton(
                text: widget.choices![1],
                color: buttonColors![1],
                onPressed: () async {
                  // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                  await revealAnswers(1);
                  widget.onAnswer!(widget.choices![1]);
                },
              ),
              ChoiceButton(
                text: widget.choices![2],
                color: buttonColors![2],
                onPressed: () async {
                  // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                  await revealAnswers(2);
                  widget.onAnswer!(widget.choices![2]);
                },
              ),
              ChoiceButton(
                text: widget.choices![3],
                color: buttonColors![3],
                onPressed: () async {
                  // TODO: CHECK IF CHOICE MATCHES WITH ANSWER
                  await revealAnswers(3);
                  widget.onAnswer!(widget.choices![3]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
