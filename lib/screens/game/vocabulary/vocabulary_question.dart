import 'package:diction_dash/services/game_audio.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';

class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion(
      {super.key,
      required this.word,
      required this.choices,
      required this.onAnswer,
      required this.answer});
  final String word;
  final Function(String, String, int) onAnswer;
  final List<String> choices;
  final String answer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
  final GameAudio gameAudio = GameAudio();
  List<Color> buttonColors = [
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600
  ];
  bool isAnswered = false; // Prevent multiple selections
  bool isTimerStopped = false; // To control the timer
  DateTime? startTime;
  DateTime? endTime;
  int timePoints = 0;

  // Handle user's answer
  void handleAnswer(String selectedChoice) {
    if (isAnswered) return; // Prevent multiple taps after answering

    if (widget.answer == selectedChoice) {
      gameAudio.correctAnswer();
    } else {
      gameAudio.incorrectAnswer();
    }

    setState(() {
      isAnswered = true;
      isTimerStopped = true;

      // Update button colors: red for incorrect, green for correct
      for (int i = 0; i < widget.choices.length; i++) {
        if (widget.choices[i] == widget.answer) {
          buttonColors[i] = Colors.green;
        } else if (widget.choices[i] == selectedChoice) {
          buttonColors[i] = Colors.redAccent;
        }
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer(selectedChoice, widget.answer, timePoints); // Call onAnswer function

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
    String wrongAns = '';

    setState(() {
      isTimerStopped = true;

      // Show correct answers in red button
      for (int i = 0; i < widget.choices.length; i++) {
        if (widget.choices[i] == widget.answer) {
          buttonColors[i] = Colors.red;
          gameAudio.incorrectAnswer();
        } else {
          wrongAns = widget.choices[i];
        }
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(const Duration(seconds: 2), () {
      widget.onAnswer(wrongAns, widget.answer, timePoints); // Call onAnswer function

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

  int calculateTimePoints(DateTime startTime) {
    endTime = DateTime.now();
    double points = (15 - endTime!.difference(startTime).inSeconds) / 3;
    print('Time Points: ${points.ceil()}');
    return points.ceil();
  }

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  @override
  void didUpdateWidget(covariant VocabularyQuestion oldWidget) {
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
                          ? () {
                              handleAnswer(widget.choices[0]);
                              timePoints = calculateTimePoints(startTime!);
                            }
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
                          ? () {
                              handleAnswer(widget.choices[1]);
                              timePoints = calculateTimePoints(startTime!);
                            }
                          : null, // Disable button if already answered
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
                          ? () {
                              handleAnswer(widget.choices[2]);
                              timePoints = calculateTimePoints(startTime!);
                            }
                          : null, // Disable button if already answered
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
                          ? () {
                              handleAnswer(widget.choices[3]);
                              timePoints = calculateTimePoints(startTime!);
                            }
                          : null, // Disable button if already answered
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
          ),
        ),
      ],
    );
  }
}
