import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> get(String endpoint, Map<String, String> params) async {
    final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: params);
    
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Failed to connect to API with status code: ${response.statusCode}');
        throw Exception('Failed to connect to API');
      }
    } catch (e) {
      log('Error fetching data: $e');
      throw Exception('Failed to fetch data');
    }
  }
}
