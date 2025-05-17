import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
// 'http://localhost:3000';
  Future<String> fetchGreeting() async {
    final response = await http.get(Uri.parse('$baseUrl/hello'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load greeting');
    }
  }
}
