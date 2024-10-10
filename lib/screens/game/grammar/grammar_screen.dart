import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:diction_dash/screens/game/grammar/grammar_question.dart';

// TODO: TRANSFORM THE GRAMMAR SCREEN INTO A QUESTION MANAGER
// Generate 10 phrases
  // Include whether or not they are grammatically correct or incorrect
// Create 10 GrammarQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

// TODO: ACCOUNT FOR SPACED REPETITION

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: kGrayColor500,
                        size: 35,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: kGrayColor300,
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      child: QuestionBar(questionNumber: 6),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: (){
                        showGameDescription(context, title: 'Grammar', description: 'Analyze the sentence\ncarefully, and read it more\nthan once to be sure.');
                      },
                      child: const Icon(
                        Icons.help,
                        color: kGrayColor500,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BODY
            const GrammarQuestion(
              phrase: "She was walking down the\nstreet when she seen a dog\nthat was barking loudly at\nit's owner",
              isCorrect: false,
            ),

          ],
        ),
      ),
    );
  }
}
