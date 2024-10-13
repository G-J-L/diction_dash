import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class WordsAPI {
  final String baseURL = 'wordsapiv1.p.rapidapi.com';
  final String apiKey = '94e9300392msh06f17a2dac509ddp162a8djsnf35e8fe4dc64';

  // Method to fetch words with a certain frequency
  Future<List<Map<String, dynamic>>> fetchWordsWithFrequency(double minFrequency, double maxFrequency) async {
    var url = Uri.https(baseURL, '/words', {
      'frequencyMin': minFrequency.toString(),
      'frequencyMax': maxFrequency.toString(),
    });

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': baseURL,
      'Accept': 'application/json',
    };

    try {
      var response = await http.get(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Print the raw response

      if (response.statusCode == 200) {
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
        throw Exception('Failed to fetch words. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Helper method to get 10 random words from the list
  List<Map<String, dynamic>> getRandomWords(List<dynamic> wordsData, int count) {
    var random = Random();
    return List<Map<String, dynamic>>.generate(count, (_) {
      int index = random.nextInt(wordsData.length);
      return {
        'word': wordsData[index],
        'pronunciation': null,
      };
    });
  }

  // TODO: Create a method for fetching random words (choices)
}
