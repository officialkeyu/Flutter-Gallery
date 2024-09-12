import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/image_data.dart';

/// A service class to handle API requests to the Pixabay API.
class PixabayService {
  final String _apiKey = dotenv.env['API_KEY'] ?? ''; // Get API key from .env file
  final String _baseUrl = dotenv.env['BASE_URL'] ?? ''; // Get Base URL from .env file

  /// Fetches a list of images from the Pixabay API based on the [query] and [page] parameters.
  ///
  /// Returns a [List] of [ImageData] objects if the API request is successful.
  /// Throws an [Exception] if the request fails.
  Future<List<ImageData>> fetchImages({String query = '', int page = 1}) async {
    if (_apiKey.isEmpty || _baseUrl.isEmpty) {
      throw Exception('API Key or Base URL is not provided.'); // Early error if credentials are missing
    }

    try {
      // Extract domain and path from the BASE_URL
      final uri = Uri.parse(_baseUrl);
      final response = await http.get(
        Uri.https(uri.host, uri.path, {'key': _apiKey, 'q': query, 'page': '$page'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData.containsKey('hits')) {
          return (jsonData['hits'] as List)
              .map((item) => ImageData.fromJson(item))
              .toList();
        } else {
          throw Exception('Invalid API response format: Missing "hits" key.');
        }
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions, such as network issues or parsing errors.
      rethrow; // Preserve the original stack trace
    }
  }
}
