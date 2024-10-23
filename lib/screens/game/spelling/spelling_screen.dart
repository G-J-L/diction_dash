import 'dart:convert';
import 'package:diction_dash/screens/game/spelling/spelling_question.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/fox_loading_indicator.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/words_api.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key, required this.cefrLevel, required this.level});

  final String cefrLevel;
  final int level;

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  final FirestoreService firestoreService = FirestoreService();

  SharedPreferences? store; // References local persistent storage containing preloaded words

  final WordsAPI wordsAPI = WordsAPI();
  List<String> words = [];
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
      store ??= await SharedPreferences.getInstance();
      List<String>? preloadedWords;
      // Try to fetch preloadedWords.
      try {
        preloadedWords =
            (json.decode(store?.getString('spellingQuestionWords') ?? '{}'))
                .cast<String>();
      } catch (e) {
        preloadedWords = null;
      }
      // Assign fetched words to preloaded words if they exist, otherwise fetch new words
      List<String>? fetchedWords = preloadedWords ??
          await wordsAPI.fetchWord(cefrLevel: widget.cefrLevel, level: widget.level, game: 'spelling');
      setState(() {
        words = fetchedWords!;
      });
      print(words);
    } catch (e) {
      print('Error Fetching Words: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void checkAnswer(String userAnswer) {
    FocusScope.of(context).unfocus();
    if (userAnswer.toLowerCase() == words[currentIndex].toLowerCase()) {
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
          builder: (context) => EndGameScreen(
            correctScore: correctScore,
            onCorrect: () {},
            rewardEXP: firestoreService.addSpellingEXP,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    wordsAPI.loadSpellingQuestionData(cefrLevel: widget.cefrLevel, level: widget.level);
    return Scaffold(
      // resizeToAvoidBottomInset: true,
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
                          title: 'Spelling',
                          description:
                              'Listen to the audio carefully and make sure to type the word in the answer box.');
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
            : SpellingQuestion(
                word: words[currentIndex],
                onAnswer: checkAnswer, // Pass the answer checking function
              ),
      ),
    );
  }
}
