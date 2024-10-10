import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class WordsAPI {

  final String baseURL = 'wordsapiv1.p.rapidapi.com';
  final String apiKey = '94e9300392msh06f17a2dac509ddp162a8djsnf35e8fe4dc64';

  // TODO: Create a method for fetching words with a certain frequency
  Future<void> fetchWordsWithFrequency(double minFrequency, maxFrequency) async {
    // API URL for words with a minimum and maximum frequency
    var url = Uri.https(baseURL, '/words', {
      'frequenxyMin': minFrequency.toString(),
      'frequencyMax': maxFrequency.toString(),
      // 'partOfSpeech': 'noun',
      'syllables': '3',
      'page': '10',
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

  // TODO: Create a method for fetching random words (choices)

}

