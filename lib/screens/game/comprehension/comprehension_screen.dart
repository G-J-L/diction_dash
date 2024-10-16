import 'package:diction_dash/services/words_api.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/comprehension/comprehension_question.dart';

// TODO: TRANSFORM THE COMPREHENSION SCREEN INTO A QUESTION MANAGER
// Generate 10 of the following
  // Paragraphs
  // Questions
  // 4 choices each
  // Correct answer
// Create 10 ComprehensionQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

// TODO: ACCOUNT FOR SPACED REPETITION

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key});

  @override
  State<ComprehensionScreen> createState() => _ComprehensionScreenState();
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentIndex = 0;
  int correctScore = 0;

  @override
  void initState() {
    super.initState();
    // TODO: FETCH COMPREHENSION QUESTIONS
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading ? null : AppBar(
        leading: Padding(
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
        title: Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: kGrayColor300,
            borderRadius: BorderRadius.circular(90.0),
          ),
          child: QuestionBar(questionNumber: currentIndex + 1),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: (){
                showGameDescription(context, title: 'Comprehension', description: 'Analyze the sentence carefully, and read it more than once to be sure.');
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
      body: const ComprehensionQuestion(
        paragraph: 'The cat jumped onto the\nand answer the given question.',
        question: 'What did the cat do?',
        choices: [
          'enjoyed the view',
          'leaped from a window',
          'hissed at the dog',
          'watched the birds',
        ],
        answer: 'watched the birds',
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {

  const ChoiceButton({super.key, this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OvalButton(
      color: kOrangeColor600,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Text(
          text!,
          style: kButtonTextStyleWhite20,
        ),
      ),
    );
  }
}
