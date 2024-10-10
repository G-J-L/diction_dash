import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class SpellingQuestion extends StatefulWidget {
  const SpellingQuestion({super.key, this.word});
  final String? word;

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
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
              print(widget.word!);
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
                    // TODO: Check IF USER INPUT MATCHES WORD
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
    );
  }
}

