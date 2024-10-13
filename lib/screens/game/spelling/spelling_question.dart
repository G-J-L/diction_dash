import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import flutter_tts

class SpellingQuestion extends StatefulWidget {
  const SpellingQuestion({super.key, required this.wordData, required this.onAnswer});
  final Map<String, dynamic> wordData;
  final Function(String) onAnswer; // Callback to check the answer

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts(); // Initialize TTS

  // Function to play audio using TTS
  Future<void> playAudio() async {
    try {
      String word = widget.wordData['word']; // Get the actual word

      print(word);

      await flutterTts.setLanguage("en-US"); // Set the language
      await flutterTts.setPitch(1.0); // Adjust pitch if necessary
      await flutterTts.speak(word); // Speak the word
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          RichText(
            text: TextSpan(
              style: kSubtext20,
              children: [
                const TextSpan(
                  text: 'Spell',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' the following word: '),
                TextSpan(
                  text: ('*' * widget.wordData['word'].length),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          // Audio Button
          GestureDetector(
            onTap: playAudio, // Play audio using TTS
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 24),
                    cursorColor: kOrangeColor500,
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 4, color: kOrangeColor600),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 4, color: kOrangeColor600),
                      ),
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                ),
                RoundedRectangleButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    widget.onAnswer(_controller.text); // Check the answer
                    _controller.clear(); // Clear input after submission
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
