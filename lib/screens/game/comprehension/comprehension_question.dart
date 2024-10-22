import 'package:diction_dash/services/game_audio.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

import '../../../widgets/linear_progress_indicators.dart';

class ComprehensionQuestion extends StatefulWidget {
  const ComprehensionQuestion(
      {super.key,
      required this.paragraph,
      required this.question,
      required this.choices,
      required this.answer,
      required this.onAnswer});
  final String? paragraph;
  final String? question;
  final List<String?>? choices;
  final String? answer;
  final void Function(String?, int)? onAnswer;

  @override
  State<ComprehensionQuestion> createState() => _ComprehensionQuestionState();
}

class _ComprehensionQuestionState extends State<ComprehensionQuestion> {
  final GameAudio gameAudio = GameAudio();
  List<Color>? buttonColors = [
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600
  ];
  bool isAnswered = false;
  bool isTimerStopped = false;
  DateTime? startTime;
  DateTime? endTime;
  int? timePoints;

  // Handle user's answer
  void handleAnswer(String userAnswer) {
    if (isAnswered) return; // Prevent multiple taps after answering

    setState(() {
      isAnswered = true;
      isTimerStopped = true;

      // Update button colors: red for incorrect, green for correct
      for (int i = 0; i < widget.choices!.length; i++) {
        if (widget.choices![i] == widget.answer) {
          gameAudio.correctAnswer();
          buttonColors![i] = Colors.green;
        } else if (widget.choices![i] == userAnswer) {
          gameAudio.incorrectAnswer();
          buttonColors![i] = Colors.redAccent;
        }
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer!(userAnswer, timePoints!); // Call onAnswer function

      // Reset the state for the next question
      setState(() {
        buttonColors = [
          kOrangeColor600,
          kOrangeColor600,
          kOrangeColor600,
          kOrangeColor600
        ];
        isAnswered = false;
        isTimerStopped = false;
      });
    });
  }

  void showAnswer() {
    String? wrongAns = '';

    setState(() {
      isTimerStopped = true;

      // Show correct answers in red button
      for (int i = 0; i < widget.choices!.length; i++) {
        if (widget.choices![i] == widget.answer) {
          buttonColors![i] = Colors.red;
          gameAudio.incorrectAnswer();
        } else {
          wrongAns = widget.choices![i];
        }
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer!(wrongAns, 0); // Call onAnswer function

      // Reset the state for the next question
      setState(() {
        buttonColors = [
          kOrangeColor600,
          kOrangeColor600,
          kOrangeColor600,
          kOrangeColor600
        ];
        isAnswered = false;
        isTimerStopped = false; // Restart the timer
      });
    });
  }

  void calculateTimePoints(DateTime startTime) {
    endTime = DateTime.now();
    double points = (15 - endTime!.difference(startTime).inSeconds) / 3;
    timePoints = points.ceil();
  }

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  @override
  void didUpdateWidget(covariant ComprehensionQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    startTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountdownProgressIndicator(
          durationInSeconds: 15,
          isStopped: isTimerStopped, // Pass the timer state
          onTimerComplete: () {
            if (!isAnswered) {
              showAnswer();
            }
          },
        ),
        Expanded(
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
                      onPressed: !isAnswered
                          ? () {
                              handleAnswer(widget.choices![0]!);
                              calculateTimePoints(startTime!);
                            }
                          : null,
                    ),
                    ChoiceButton(
                      text: widget.choices![1],
                      color: buttonColors![1],
                      onPressed: !isAnswered
                          ? () {
                              handleAnswer(widget.choices![1]!);
                              calculateTimePoints(startTime!);
                            }
                          : null,
                    ),
                    ChoiceButton(
                      text: widget.choices![2],
                      color: buttonColors![2],
                      onPressed: !isAnswered
                          ? () {
                              handleAnswer(widget.choices![2]!);
                              calculateTimePoints(startTime!);
                            }
                          : null,
                    ),
                    ChoiceButton(
                      text: widget.choices![3],
                      color: buttonColors![3],
                      onPressed: !isAnswered
                          ? () {
                              handleAnswer(widget.choices![3]!);
                              calculateTimePoints(startTime!);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
