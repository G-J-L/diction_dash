import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';
import '../../../services/words_api.dart';

class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion({super.key, required this.word, required this.onAnswer});
  final String word;
  final Function(String, String) onAnswer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
  List<String> choices = [];
  String? answer;

  @override
  void initState() {
    super.initState();
    _getChoices(widget.word);
    _getAnswer(widget.word);
  }

  // This method is called whenever the widget is updated
  @override
  void didUpdateWidget(VocabularyQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Fetch the choices and answer whenever the word data changes
    if (oldWidget.word != widget.word) {
      _getChoices(widget.word);
      _getAnswer(widget.word);
    }
  }

  // Get choices
  Future<void> _getChoices(String word) async {
    WordsAPI api = WordsAPI();
    List<String> fetchedChoices = await api.fetchChoices(word, cefrLevel: 'A1', level: 3);

    setState(() {
      choices = fetchedChoices;
    });
  }

  // Get answer
  Future<void> _getAnswer(String word) async {
    WordsAPI api = WordsAPI();
    List<String>? fetchedSynonyms = await api.fetchSynonyms(word);

    setState(() {
      answer = fetchedSynonyms![0];
    });
  }

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
                TextSpan(text: 'Select the appropriate\n'),
                TextSpan(
                  text: 'synonym.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            widget.word,
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
                    widget.onAnswer(choices[0], answer!);
                  },
                  child: Center(
                    child: Text(
                      choices[0],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    widget.onAnswer(choices[1], answer!);
                  },
                  child: Center(
                    child: Text(
                      choices[1],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    widget.onAnswer(choices[2], answer!);
                  },
                  child: Center(
                    // TODO: CHECK IF WORD MATCHES WITH ANSWER
                    child: Text(
                      choices[2],
                      style: kButtonTextStyleWhite,
                    ),
                  ),
                ),
                OvalButton(
                  color: kOrangeColor600,
                  onPressed: () {
                    widget.onAnswer(choices[3], answer!);
                  },
                  child: Center(
                    child: Text(
                      choices[3],
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
