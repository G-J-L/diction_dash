import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

// TODO: TRANSFORM THE SPELLING SCREEN INTO A QUESTION MANAGER
// Calculate word difficulty based on user level and CEFR level
// Generate 10 words using Words API
// Create 10 SpellingQuestion widgets and store them in a list
// Return the first question. When the user submits an answer, keep track of it and return the next question
// When the user makes it to the last question in the SpellingQuestion list, display end_game_screen.dart instead with the appropriate xp rewards

// TODO: ACCOUNT FOR SPACED REPETITION

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {

  String? word = 'Mississippi';

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
                      onTap: () {
                        showGameDescription(context, title: 'Spelling', description: 'Listen to the audio carefully\nand make sure to type the\nword in the answer box.');
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
            // Instruction Text
            RichText(
              text: const TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(
                    text: 'Spell',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' the following word.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            // Audio Button
            GestureDetector(
              onTap: () {
                // Implement audio playback functionality here
                print(word!);
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: kOrangeColor600,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(
                    Icons.volume_up,
                    size: 130,
                    color: kOrangeColor200,
                  ),
                ),
              ),
            ),
            // Answer Input and Submit Button
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      cursorColor: kOrangeColor500,
                      decoration: InputDecoration(
                        hintText: 'Answer',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 4,
                            color: kOrangeColor600,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 4,
                            color: kOrangeColor600,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                  RoundedRectangleButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('Submit');
                      // Implement your submit logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EndGameScreen(),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Submit',
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

