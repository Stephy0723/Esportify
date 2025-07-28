import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.0.102:5000/api/users';

  static Future<Map<String, dynamic>> checkUsernameAvailability(
    String username,
    String email,
  ) async {
    final url = Uri.parse('$baseUrl/check-user');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al validar usuario: ${response.body}');
    }
  }

  static Future<http.Response> registerUser(
    Map<String, dynamic> userData,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    // Acepta tanto 200 como 201 como éxito
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  static Future<http.Response> loginUser(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to login user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to the backend: $e');
    }
  }
}
