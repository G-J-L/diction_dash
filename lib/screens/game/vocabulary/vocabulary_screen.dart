import 'package:diction_dash/screens/game/vocabulary/vocabulary_question.dart';
import 'package:diction_dash/services/words_api.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

// TODO: TRANSFORM THE VOCABULARY SCREEN INTO A QUESTION MANAGER
// Calculate word difficulty based on user level and CEFR level
// Generate 10 words using Words API.
  // Include a synonym for each word.
  // Generate random words to be mixed in as choices.
// Create 10 VocabularyQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

// TODO: ACCOUNT FOR SPACED REPETITION

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final WordsAPI wordsAPI = WordsAPI();
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentIndex = 0; // Keep track of current word index
  int currentScore = 0; // Keep track of correct answers

  @override
  void initState() {
    super.initState();
    // TODO: Fetch words with word, choices (including the word), and an answer
  }

  // Future<void> fetchQuestions() async {
  //   try {
  //     List<Map<String, dynamic>> fetchedQuestions = await wordsAPI.fetchVocabularyQuestions();
  //     setState(() {
  //       questions = fetchedQuestions;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching words: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    wordsAPI.fetchWordsWithFrequencyAndSynonym(4);
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
                      child: QuestionBar(questionNumber: currentIndex + 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: (){
                        showGameDescription(context, title: 'Vocabulary', description: 'Select which of the four\noptions you believe to be\nthe best response.');
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
            const VocabularyQuestion(
              word: 'distinct',
              choices: ['mystic', 'demure', 'unique', 'exhausted'],
              answer: 'unique',
            ),
          ],
        ),
      ),
    );
  }
}
