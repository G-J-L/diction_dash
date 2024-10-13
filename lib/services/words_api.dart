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

  // TODO: Create a method for fetching words with a certain frequency
  Future<void> fetchWordsWithFrequency(double frequency) async {
    // API URL for words with a minimum and frequency
    var url = Uri.https(baseURL, '/words', {
      'frequencyMin': frequency.toString(),
      'frequencyMax': frequency.toString(),
      // 'partOfSpeech': 'noun',
      // 'syllables': '10',
      // 'page': '10',
      // 'limit': '800',
    });

    // Headers with the API key
    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    print(url);

    try {
      // Send GET request to WordsAPI
      var response = await http.get(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Print the raw response

      if (response.statusCode == 200) {
        // Decode the response body
        var data = jsonDecode(response.body);

        if (data is Map<String, dynamic> && data.containsKey('results')) {
          // Extract the 'data' key from 'results'
          List<dynamic> wordsData = data['results']['data'];

          // Generate the list of words with pronunciation (assuming pronunciation is not available)
          return getRandomWords(wordsData, 10); // Adjust if you want to include pronunciation later
        } else {
          throw Exception('Unexpected API response structure.');
        }
      } else {
        print('Failed to fetch words. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Helper method to get 10 random words from the list
  List<Map<String, dynamic>> getRandomWords(List<dynamic> wordsData, int count) {
    var random = Random();
    return List<Map<String, dynamic>>.generate(count, (_) {
      int index = random.nextInt(wordsData.length);
      return {
        'word': wordsData[index],
      };
    });
  }

  // A method for fetching words based on CEFR Level & User Level
  Future<void> fetchWord({String? cefrLevel, int? level}) async {
    var frequency = (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level! * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));
    await fetchWordsWithFrequency(finalFrequency);
  }

}

