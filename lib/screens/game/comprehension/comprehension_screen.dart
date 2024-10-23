import 'package:diction_dash/services/comprehension_question_bank.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/services/words_api.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/comprehension/comprehension_question.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

// TODO: TRANSFORM THE COMPREHENSION SCREEN INTO A QUESTION MANAGER
// Generate 10 of the following
  // Paragraphs
  // Questions
  // 4 choices each
  // Correct answer
// Create 10 ComprehensionQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key, this.cefrLevel});
  final String? cefrLevel;

  @override
  State<ComprehensionScreen> createState() => _ComprehensionScreenState();
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {

  final FirestoreService firestoreService = FirestoreService();

  ComprehensionQuestionBank questionBank = ComprehensionQuestionBank();
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentIndex = 0;
  int correctScore = 0;

  @override
  void initState() {
    super.initState();
    questions = questionBank.getRandomQuestions(cefrLevel: widget.cefrLevel, count: 10);
  }

  void checkAnswer(String? answer) {
    // Check if user answer is equal to the correct answer
    if (answer == questions[currentIndex]['answer']) {
      setState(() {
        correctScore++;
      });
    }

    // Increment question number if we are not at the last question yet
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Navigate to end game screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EndGameScreen(
            correctScore: correctScore,
            onCorrect: () {},
            rewardEXP: firestoreService.addComprehensionEXP,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: ComprehensionQuestion(
        paragraph: questions[currentIndex]['paragraph'],
        question: questions[currentIndex]['question'],
        choices: questions[currentIndex]['choices'],
        answer: questions[currentIndex]['answer'],
        onAnswer: checkAnswer,
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
