import 'package:diction_dash/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:diction_dash/screens/game/grammar/grammar_question.dart';
import 'package:diction_dash/services/grammar_question_bank.dart';

// TODO: TRANSFORM THE GRAMMAR SCREEN INTO A QUESTION MANAGER
// Generate 10 phrases
// Include whether or not they are grammatically correct or incorrect
// Create 10 GrammarQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

// TODO: ACCOUNT FOR SPACED REPETITION

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key, required this.cefrLevel});
  final String cefrLevel;

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {

  final FirestoreService firestoreService = FirestoreService();

  final GrammarQuestionBank questionBank = GrammarQuestionBank();
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentIndex = 0;
  int correctScore = 0;

  @override
  void initState() {
    super.initState();
    print('Grammar Screen: USER CEFR LEVEL IS ${widget.cefrLevel}');
    questions = questionBank.getRandomQuestions(cefrLevel: widget.cefrLevel, count: 10);
  }

  void checkAnswer(bool answer) {
    // Check if user answer is equal to the correct answer
    if (answer == questions[currentIndex]['isCorrect']) {
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
            rewardEXP: firestoreService.addGrammarEXP,
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
            onTap: () {
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
              onTap: () {
                showGameDescription(context,
                    title: 'Grammar',
                    description:
                        'Analyze the sentence carefully, and read it more than once to be sure.');
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
      body: GrammarQuestion(
        phrase: questions[currentIndex]['phrase'],
        isCorrect: questions[currentIndex]['isCorrect'],
        onAnswer: checkAnswer,
      ),
    );
  }
}
