import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DictionaryAPI {
  Future<Map<String, dynamic>> fetchDefinition(String word) async {
    // API URL
    final url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
    
    // HTTP GET request
    final response = await http.get(url);

    // Check Success
    final status = response.statusCode;
    
    
    try {
      if (status == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data[0];
      } else if (status == 404) {
        throw Exception('Word not found');
      } else {
        throw Exception('server error: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      throw Exception('No Internet connection.');
    } catch (e) {
      throw Exception('an error occurred: $e');
    }
  }
}