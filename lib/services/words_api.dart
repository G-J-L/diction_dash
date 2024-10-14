import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

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

  // Fetch words with a certain frequency
  Future<List<Map<String, dynamic>>> fetchWordsWithFrequency(double frequency) async {
    var url = Uri.https(baseURL, '/words', {
      'frequencyMin': (frequency - 1).toString(),
      'frequencyMax': frequency.toString(),
    });

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('results')) {
          List<dynamic> wordsData = data['results']['data'];
          List<dynamic> validWords = [];

          print(wordsData);

          //Filter invalid words
          for (var word in wordsData) {
            // Check that word is a string and has more than 3 letters
            if (word is String && word.length > 3) {
              String? definition = await fetchDefinition(word);

              //Check if it has a definition
              if (definition != null) {
                validWords.add(word);
              } else {
                continue;
              }
            } else {
              print('Unexpected word format: $word');
            }
          }

          print(validWords);

          return getRandomWords(validWords, 10); // Return 10 random words
        } else {
          throw Exception('Unexpected API response structure.');
        }
      } else {
        throw Exception('Failed to fetch words. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Helper method to get 10 random words from the list
  List<Map<String, dynamic>> getRandomWords(List<dynamic> wordsData, int count) {
    return List<Map<String, dynamic>>.generate(count, (_) {
      int index = _random.nextInt(wordsData.length);
      return {
        'word': wordsData[index],
      };
    });
  }

  // Fetch words based on CEFR Level & User Level
  Future<List<Map<String, dynamic>>> fetchWord({required String cefrLevel, required int level}) async {
    var frequency = (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));
    return fetchWordsWithFrequency(finalFrequency);
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
            return fullDefinition.split(';').first; // Return the part before the first semicolon
          } else {
            throw Exception('No definitions found.');
          }
        } else {
          throw Exception('Definitions not found in response.');
        }
      } else {
        throw Exception('Failed to fetch definition. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching definition: $e');
      return null;
    }
  }


// TODO: Create a method for fetching random words (choices)
}
