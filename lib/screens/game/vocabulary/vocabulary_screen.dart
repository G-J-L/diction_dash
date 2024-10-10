import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Bar
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
            RichText(
              text: const TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(text: 'Select the appropriate\n'),
                  TextSpan(
                    text: 'synonym.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'distinct',
              style: kOswaldLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('mystic');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'mystic',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('demure');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'demure',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('unique');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'unique',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('exhausted');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'exhausted',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
