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

  bool? answer;

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
    if (answer) {
      if (widget.isCorrect == true) {
        setState(() {
          correctButton['color'] = Colors.green;
          correctButton['borderColor'] = Colors.green;
          correctButton['style'] = kButtonTextStyleWhite;
        });
      } else {
        setState(() {
          correctButton['color'] = Colors.redAccent;
          correctButton['borderColor'] = Colors.redAccent;
          correctButton['style'] = kButtonTextStyleWhite;
        });
      }
      await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
    } else {
      if (widget.isCorrect == false) {
        setState(() {
          incorrectButton['color'] = Colors.green;
          incorrectButton['borderColor'] = Colors.green;
          incorrectButton['style'] = kButtonTextStyleWhite;
        });
      } else {
        setState(() {
          incorrectButton['color'] = Colors.redAccent;
          incorrectButton['borderColor'] = Colors.redAccent;
          incorrectButton['style'] = kButtonTextStyleWhite;
        });
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
                onPressed: () async {
                  await showAnswer(true);
                  widget.onAnswer!(true);
                },
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
                onPressed: () async {
                  await showAnswer(false);
                  widget.onAnswer!(false);
                },
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
    );
  }
}
