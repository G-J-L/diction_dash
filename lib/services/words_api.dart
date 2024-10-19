import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WordsAPI {
  final Random _random = Random();
  final String baseURL = 'wordsapiv1.p.rapidapi.com';
  final String apiKey = '94e9300392msh06f17a2dac509ddp162a8djsnf35e8fe4dc64';

  final cefrToFrequency = {
    'A1': 6,
    'A2': 5,
    'B1': 4,
    'B2': 3,
    'C1': 2,
  };

  // Load words when user is not in-game to cut loading times
  Future<void> loadPreloadedWords(
      {required String cefrLevel, required int level}) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    var frequency =
        (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));

    fetchRandomWords(finalFrequency, 10).then(
      (randomWords) {
        print('Loading preloaded random words...');
        print('Random Words: $randomWords');
        print('JSON DATA: ${json.encode(randomWords)}');
        store.setString('preloadedRandomWords', json.encode(randomWords));
        print('Done loading preloaded random words!');
      },
    );

    fetchDefinedWords(finalFrequency, 10).then(
      (definedWords) {
        print('Loading preloaded defined words...');
        print('Defined Words: $definedWords');
        print('JSON DATA: ${json.encode(definedWords)}');
        store.setString('preloadedDefinedWords', json.encode(definedWords));
        print('Done loading preloaded defined words!');
      },
    );
  }

  // Fetch words based on CEFR Level & User Level
  Future<List<String>?> fetchWord(
      {required String cefrLevel,
      required int level,
      required String game}) async {
    var frequency =
        (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));

    if (game == 'spelling') {
      return fetchDefinedWords(finalFrequency, 10);
    } else if (game == 'vocabulary') {
      return fetchRandomWords(finalFrequency, 10);
    } else {
      return null;
    }
  }

  // Fetch definition of the word.
  Future<String?> fetchDefinition(String word) async {
    var url = Uri.https(baseURL, '/words/$word/definitions');

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Check if 'definitions' exists in the response
        if (data is Map<String, dynamic> && data.containsKey('definitions')) {
          List<dynamic> definitionsData = data['definitions'];

          // If there are definitions, return the first part before ';'
          if (definitionsData.isNotEmpty) {
            String fullDefinition = definitionsData[0]['definition'];
            return fullDefinition
                .split(';')
                .first; // Return the part before the first semicolon
          } else {
            throw Exception('No definitions found.');
          }
        } else {
          throw Exception('Definitions not found in response.');
        }
      } else {
        throw Exception(
            'Failed to fetch definition. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching definition: $e');
      return null;
    }
  }

  //Fetch 1 random word
  Future<String?> fetchRandomWord(double frequency) async {
    var url = Uri.https(baseURL, '/words', {
      'frequencyMin': (frequency - 1).toString(),
      'frequencyMax': frequency.toString(),
      'random': 'true',
    });

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Parse the response
        Map<String, dynamic> data = json.decode(response.body);
        String word = data['word'];
        return word;
      } else {
        print('Failed to load word: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Checks if word is valid
  Future<bool> wordValidator(String word) async {
    var url = Uri.https(baseURL, '/words/$word');

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Parse the response
        Map<String, dynamic> data = json.decode(response.body);

        // Validates word
        if (data['isProperNoun'] == true ||
            data['isProfane'] == true ||
            word.length <= 3 ||
            RegExp(r'\d').hasMatch(word)) {
          return false;
        } else {
          return true;
        }
      } else {
        print('Failed to load word data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Fetch 10 defined words (mainly used for spelling)
  Future<List<String>> fetchDefinedWords(double frequency, int count) async {
    List<String> words = [];

    // While loop that gets exactly 10 words
    while (words.length != count) {
      String? word = await fetchRandomWord(frequency);

      //Checks if a word is already in the list
      if (words.contains(word) == false) {
        // Word validator
        if (await wordValidator(word!) == true) {
          String? definition = await fetchDefinition(word);
          //Check if it has a definition
          if (definition != null) {
            words.add(word);
          }
        } else {
          print(
              'Unexpected word format: $word'); //When not string and is less than 4 letters
        }
      }
    }

    return words;
  }

  // Fetch 10 random words with synonyms (mainly used for vocab)
  Future<List<String>> fetchRandomWords(double frequency, int count) async {
    Set<String> words = {};

    // While loop that continues until we have the required count of words
    while (words.length < count) {
      String? word = await fetchRandomWord(frequency);

      if (await wordValidator(word!) == true) {
        List<String>? synonyms = await fetchSynonyms(word);
        // Check if the word has at least 1 synonym
        if (synonyms != null && synonyms.isNotEmpty) {
          words.add(word); // Add only if there are synonyms
        } else {
          print('No synonyms available for: $word');
        }
      } else {
        print(
            'Unexpected word format: $word'); // When not string and is less than 4 letters
      }
    }

    return words.toList();
  }

  // Fetch synonyms
  Future<List<String>?> fetchSynonyms(String word) async {
    var url = Uri.https(baseURL, '/words/$word/synonyms');

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Parse the response
        Map<String, dynamic> data = json.decode(response.body);

        // Get the list of synonyms
        List<dynamic> synonyms = data['synonyms'];

        // Return all synonyms as a list of strings, if available
        if (synonyms.isNotEmpty) {
          return List<String>.from(
              synonyms); // Convert dynamic list to List<String>
        } else {
          return null;
        }
      } else {
        print('Failed to load synonyms: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Fetch choices for vocab
  // Fetch choices for vocab
  Future<List<String>> fetchChoices(String word, {required String cefrLevel, required int level}) async {
    var frequency = (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));

    Set<String> choices = {}; // Use Set to prevent duplicates
    List<String>? synonyms = await fetchSynonyms(word);

    // While loop that gets 4 random words (excluding synonyms)
    while (choices.length < 3) { // Reduced to 3 since synonym is added later
      String? randomWord = await fetchRandomWord(finalFrequency);

      // Check if the word is already in the list and not synonymous
      if (randomWord != null &&
          !choices.contains(randomWord) &&
          !synonyms!.contains(randomWord) &&
          await wordValidator(randomWord) == true) {
        choices.add(randomWord); // Add the random word to choices
      }
    }

    choices.add(synonyms![0]);

    List<String> finalChoices = choices.toList();
    finalChoices.shuffle(); // Shuffle to randomize order

    return finalChoices; // Return shuffled list
  }

} //End of class
