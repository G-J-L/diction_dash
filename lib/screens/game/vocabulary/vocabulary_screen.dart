import 'dart:convert';

import 'package:diction_dash/screens/game/vocabulary/vocabulary_question.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/fox_loading_indicator.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diction_dash/services/words_api.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key, required this.cefrLevel, required this.level});

  final String cefrLevel;
  final int level;

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {

  final FirestoreService firestoreService = FirestoreService();

  SharedPreferences? store; // References local persistent storage containing preloaded words

  final WordsAPI wordsAPI = WordsAPI();
  List<String> words = []; // Word list
  List<List<String>> choices = []; // Choices
  List<String> answers = []; // Answers
  bool isLoading = true;
  int currentIndex = 0; // Keep track of current word index
  int correctScore = 0; // Keep track of correct answers
  int timePoints = 0;

  @override
  void initState() {
    super.initState();
    fetchWords(); // Fetch words on screen initialization
    wordsAPI.loadVocabularyQuestionData(cefrLevel: widget.cefrLevel, level: widget.level);
  }

  Future<void> fetchWords() async {
    try {
      store = await SharedPreferences.getInstance();
      List<String>? preloadedWords;
      try {
        preloadedWords = (json.decode(store?.getString('vocabularyQuestionWords') ?? '{}')).cast<String>();
      } catch (e) {
        print('NO PRELOADED WORDS');
        preloadedWords = null;
      }

      List<String>? fetchedWords = preloadedWords ??
          await wordsAPI.fetchWord(cefrLevel: widget.cefrLevel, level: widget.level, game: 'vocabulary');

      setState(() {
        words = fetchedWords!;
      });

      List<List<String>>? preloadedChoices; // Preloaded Choices
      List<String>? preloadedAnswers; // Preloaded Answers
      try {
        preloadedChoices = (json.decode(store?.getString('vocabularyQuestionChoices') ?? '[]') as List)
            .map((e) => (e as List).map((item) => item as String).toList())
            .toList();
        preloadedAnswers = (json.decode(store?.getString('vocabularyQuestionAnswers') ?? '{}')).cast<String>();
      } catch (e) {
        print('NO PRELOADED WORDS AND CHOICES : $e');
        preloadedChoices = null;
      }

      if (preloadedChoices == null || preloadedAnswers == null) {
        await fetchChoicesAndAnswer(fetchedWords!);
      } else {
        setState(() {
          choices = preloadedChoices!;
          answers = preloadedAnswers!;
        });
      }
      print(words);
    } catch (e) {
      print('Error Fetching Words: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> fetchChoicesAndAnswer(List<String> words) async {
      for (int i = 0; i < words.length; i++) {
        String word = words[i];
        List<String> choiceWord = await wordsAPI.fetchChoices(word, cefrLevel: widget.cefrLevel, level: widget.level);
        List<String>? fetchedSynonyms = await wordsAPI.fetchSynonyms(word);

        choices.add(choiceWord);
        answers.add(fetchedSynonyms![0]);
      }
  }

  void checkAnswer(String userAnswer, String answer, int points) {
    if (userAnswer.toLowerCase() == answer.toLowerCase()) {
      timePoints += points;
      correctScore++; // Increment correct score
    }
    print('Total Time Points: ${timePoints}');
    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++; // Move to the next word
      });
    } else {
      // Navigate to the end game screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EndGameScreen(
            correctScore: correctScore,
            timePoints: timePoints,
            onCorrect: () {},
            rewardEXP: firestoreService.addVocabularyEXP,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading
          ? null
          : AppBar(
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
                          title: 'Vocabulary',
                          description:
                              'Select which of the four options you believe to be the best response.');
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
      body: SafeArea(
        child: isLoading
            ? const FoxLoadingIndicator()
            : VocabularyQuestion(
                word: words[currentIndex],
                choices: choices[currentIndex],
                answer: answers[currentIndex],
                onAnswer: checkAnswer,
              ),
      ),
    );
  }
}
