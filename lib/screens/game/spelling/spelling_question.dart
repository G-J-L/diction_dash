import 'package:diction_dash/services/game_audio.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:diction_dash/services/words_api.dart';

import '../../../widgets/linear_progress_indicators.dart';

class SpellingQuestion extends StatefulWidget {
  const SpellingQuestion(
      {super.key, required this.word, required this.onAnswer});
  final String word;
  final Function(String) onAnswer; // Callback to check the answer

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final GameAudio gameAudio = GameAudio();
  String? definition; // Definition of the word
  Color buttonColor = kOrangeColor600;
  bool isAnswered = false;
  bool isTimerStopped = false; // To control the timer
  String result = '';

  @override
  void initState() {
    super.initState();
    _initializeTts();
    _getDefinition(widget.word); // Fetch the definition on init
  }

  // This method is called whenever the widget is updated
  @override
  void didUpdateWidget(SpellingQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Fetch the definition whenever the word data changes
    if (oldWidget.word != widget.word) {
      _getDefinition(widget.word);
    }
  }

  // Get definition
  Future<void> _getDefinition(String word) async {
    WordsAPI api = WordsAPI();
    String? fetchedDefinition = await api.fetchDefinition(word);

    setState(() {
      definition = fetchedDefinition ?? 'Definition not found'; // Update state
    });
  }

  // Initialize text-to-speech settings
  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US"); // Set the desired language
    await _flutterTts.setPitch(1.0); // Set pitch
    await _flutterTts.setSpeechRate(0.5); // Optionally set speech rate
  }

  // Plays the audio of a word
  Future<void> _playAudio(String word) async {
    print(word);

    if (word.isNotEmpty) {
      await _flutterTts.speak(word);
    }
  }

  void handleAnswer(String answer, String word) {
    if (isAnswered) return; // Prevent multiple taps after answering

    //Update button when answered
    setState(() {
      isTimerStopped = true;
      isAnswered = true;

      if (answer == word) {
        gameAudio.correctAnswer();
        buttonColor = Colors.green;
        result = 'Correct';
      } else {
        gameAudio.incorrectAnswer();
        buttonColor = Colors.red;
        result = 'Wrong';
      }
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer(answer); // Call onAnswer function

      // Reset the state for the next question
      setState(() {
        buttonColor = kOrangeColor600;
        isAnswered = false;
        result = '';
        _controller.clear();
        isTimerStopped = false;
      });
    });
  }

  void showAnswer(String answer) {
    setState(() {
      isTimerStopped = true;

      // Show correct answer
      gameAudio.incorrectAnswer();
      buttonColor = Colors.red;
      result = 'Out of Time';
    });

    // Delay for 2 seconds before resetting and moving to the next question
    Future.delayed(Duration(seconds: 2), () {
      widget.onAnswer(answer); // Call onAnswer function

      // Reset the state for the next question
      setState(() {
        buttonColor = kOrangeColor600;
        isAnswered = false;
        result = '';
        _controller.clear();
        isTimerStopped = false; // Restart the timer
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - kToolbarHeight;
    String word = widget.word;

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CountdownProgressIndicator(
                  durationInSeconds: 15,
                  isStopped: isTimerStopped, // Pass the timer state
                  onTimerComplete: () {
                    if (!isAnswered) {
                      showAnswer(_controller.text);
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
                        text: isAnswered ? ('\n') + word : ('\n') + ('_ ' * word.length),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 26),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.05),
                // Definition
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: definition == null
                      ? const CircularProgressIndicator() // Show loading indicator while fetching the definition
                      : Text(
                    definition!,
                    textAlign: TextAlign.center,
                    style: kSubtext20,
                  ),
                ),
                SizedBox(height: height * 0.1),
                // Audio Button
                GestureDetector(
                  onTap: () {
                    _playAudio(word);
                  }, // Play audio using TTS
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
              ],
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
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, left: 8.0),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 24),
                  cursorColor: kOrangeColor500,
                  decoration: const InputDecoration(
                    hintText: 'Answer',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 4, color: kOrangeColor600),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 4, color: kOrangeColor600),
                    ),
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
              ),
              RoundedRectangleButton(
                color: buttonColor,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                   handleAnswer(_controller.text, word);
                },
                child: Center(
                  child: Text(
                    isAnswered ? result : 'Submit',
                    style: kButtonTextStyleWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
