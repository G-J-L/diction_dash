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
  Future<void> fetchWordsWithFrequency(double minFrequency, double maxFrequency) async {
    // API URL for words with a minimum and frequency
    var url = Uri.https(baseURL, '/words', {
      'frequencyMin': minFrequency.toString(),
      'frequencyMax': maxFrequency.toString(),
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
      if (response.statusCode == 200) {
        // Decode the response body
        var data = jsonDecode(response.body);
        print(data);
        print(data['results']['total']);
        print(data['results']['data'][99]);
      } else {
        print('Failed to fetch words. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

  }

  // TODO: Create a method for fetching words based on CEFR Level & User Level
  Future<void> fetchWord({String? cefrLevel, int? level}) async {
    var frequency = (cefrToFrequency[cefrLevel]! + _random.nextDouble()) - (level! * 0.05);
    var finalFrequency = double.parse(frequency.toStringAsFixed(2));
    await fetchWordsWithFrequency(5, 5);
  }

  // TODO: Create a method for fetching random words (choices)

}

