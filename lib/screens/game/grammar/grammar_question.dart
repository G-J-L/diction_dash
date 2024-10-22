import 'package:diction_dash/services/game_audio.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';

class GrammarQuestion extends StatefulWidget {
  const GrammarQuestion({
    super.key,
    required this.phrase,
    required this.isCorrect,
    required this.onAnswer,
  });

  final String? phrase;
  final bool? isCorrect;
  final void Function(bool, int)? onAnswer;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {
  final GameAudio gameAudio = GameAudio();
  bool? answer;
  bool isAnswered = false;
  bool isTimerStopped = false; // To track if the timer is stopped
  DateTime? startTime;
  DateTime? endTime;
  int? timePoints;

  Map<String, dynamic> correctButton = {
    'color': kOrangeColor600,
    'borderColor': kOrangeColor600,
    'style': kButtonTextStyleWhite,
  };

  Map<String, dynamic> incorrectButton = {
    'color': Colors.white,
    'borderColor': kOrangeColor600,
    'style': kButtonTextStyleOrange,
  };

  Future<void> showAnswer(bool answer) async {
    // Stop the timer when an answer is selected
    setState(() {
      isAnswered = true;
      isTimerStopped = true;
    });

    if (answer) {
      if (widget.isCorrect == true) {
        setState(() {
          correctButton['color'] = Colors.green;
          correctButton['borderColor'] = Colors.green;
          correctButton['style'] = kButtonTextStyleWhite;
        });
        gameAudio.correctAnswer();
      } else {
        setState(() {
          correctButton['color'] = Colors.redAccent;
          correctButton['borderColor'] = Colors.redAccent;
          correctButton['style'] = kButtonTextStyleWhite;
        });
        gameAudio.incorrectAnswer();
      }
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
    } else {
      if (widget.isCorrect == false) {
        setState(() {
          incorrectButton['color'] = Colors.green;
          incorrectButton['borderColor'] = Colors.green;
          incorrectButton['style'] = kButtonTextStyleWhite;
        });
        gameAudio.correctAnswer();
      } else {
        setState(() {
          incorrectButton['color'] = Colors.redAccent;
          incorrectButton['borderColor'] = Colors.redAccent;
          incorrectButton['style'] = kButtonTextStyleWhite;
        });
        gameAudio.incorrectAnswer();
      }
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
    }
    setState(() {
      correctButton = {
        'color': kOrangeColor600,
        'borderColor': kOrangeColor600,
        'style': kButtonTextStyleWhite,
      };
      incorrectButton = {
        'color': Colors.white,
        'borderColor': kOrangeColor600,
        'style': kButtonTextStyleOrange,
      };

      // Reset for the next question
      isTimerStopped = false;
      isAnswered = false;
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
  void didUpdateWidget(covariant GrammarQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    startTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CountdownProgressIndicator(
          durationInSeconds: 15,
          isStopped: isTimerStopped, // Timer stops when user answers
          onTimerComplete: () {
            showAnswer(!widget.isCorrect!); // Auto answer if time is up
            widget.onAnswer!(!widget.isCorrect!, 0);
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      color: correctButton['color'],
                      borderColor: correctButton['borderColor'],
                      onPressed: (!isAnswered)
                          ? () async {
                              await showAnswer(true);
                              calculateTimePoints(startTime!);
                              widget.onAnswer!(true, timePoints!);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'CORRECT',
                          style: correctButton['style'],
                        ),
                      ),
                    ),
                    OvalButton(
                      color: incorrectButton['color'],
                      borderColor: incorrectButton['borderColor'],
                      onPressed: (!isAnswered)
                          ? () async {
                              await showAnswer(false);
                              calculateTimePoints(startTime!);
                              widget.onAnswer!(false, timePoints!);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'INCORRECT',
                          style: incorrectButton['style'],
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
