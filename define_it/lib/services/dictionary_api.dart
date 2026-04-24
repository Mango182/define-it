import 'dart:io';

import 'package:define_it/services/toast_service.dart';
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
      // Handle different status codes
      if (status == 200) {        // Success
        final List<dynamic> data = json.decode(response.body);
        return data[0];
      } else if (status == 404) { // Word not found
        ToastService.showError('Word "$word" not found. Please try another word.');
        throw Exception('Word not found');
      } else {                    // Other errors
        ToastService.showError('An error occurred while fetching the definition.');
        throw Exception('server error: ${response.statusCode}');
      }
    } on SocketException catch (_) {
      ToastService.showError('No Internet connection. Please check your network settings.');
      throw Exception('No Internet connection.'); // Handle network errors
    } catch (e) {
      ToastService.showError('An error occurred while fetching the definition.');
      throw Exception('an error occurred: $e');   // Handle other exceptions
    }
  }
}