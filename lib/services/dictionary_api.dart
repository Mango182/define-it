import 'package:http/http.dart' as http;
import 'dart:convert';

class DictionaryAPI {
  Future<Map<String, dynamic>> fetchDefinition(String word) async {
    // Construct the API URL
    final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    
    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data[0];
    } else {
      throw Exception('Failed to load definition');
    }
  }
}