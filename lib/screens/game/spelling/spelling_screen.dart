import 'package:diction_dash/screens/game/spelling/spelling_question.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import '../../../services/words_api.dart';

// TODO: ACCOUNT FOR SPACED REPETITION

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  final WordsAPI wordsAPI = WordsAPI();
  List<Map<String, dynamic>> words = [];
  bool isLoading = true;
  int currentIndex = 0; // Keep track of current word index
  int correctScore = 0; // Keep track of correct answers

  @override
  void initState() {
    super.initState();
    fetchWords(); // Fetch words on screen initialization
  }

  Future<void> fetchWords() async {
    try {
      List<Map<String, dynamic>> fetchedWords = await wordsAPI.fetchWord(cefrLevel: 'A1', level: 3);
      setState(() {
        words = fetchedWords;
        isLoading = false;
      });
      print(words);
    } catch (e) {
      print('Error fetching words: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void checkAnswer(String userAnswer) {
    if (userAnswer.toLowerCase() == words[currentIndex]['word'].toLowerCase()) {
      correctScore++; // Increment correct score
    }

    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++; // Move to the next word
      });
    } else {
      // Navigate to the end game screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EndGameScreen(correctScore: correctScore, onCorrect: () {}),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TOP BAR (unchanged)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: kGrayColor500,
                      size: 35,
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
                      child: QuestionBar(questionNumber: currentIndex + 1), // Display current question
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showGameDescription(context, title: 'Spelling', description: 'Listen to the audio carefully and make sure to type the word in the answer box.');
                    },
                    child: const Icon(
                      Icons.help,
                      color: kGrayColor500,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),

            // BODY: Passing the fetched word to SpellingQuestion
            SpellingQuestion(
              wordData: words[currentIndex],
              onAnswer: checkAnswer, // Pass the answer checking function
            ),
          ],
        ),
      ),
    );
  }
}
