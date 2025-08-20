import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.0.9:5000/api/users';

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

  static Future<http.Response> getUserProfile(String userId) async {
    final url = Uri.parse('$baseUrl/profile/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to fetch user profile: ${response.body}');
    }
  }

  static Future<http.Response> updateUserProfile(
    String userId,
    Map<String, dynamic> profileData,
  ) async {
    final url = Uri.parse('$baseUrl/profile/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profileData),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update user profile: ${response.body}');
    }
  }

  static Future<http.Response> deleteUser(String userId) async {
    final url = Uri.parse('$baseUrl/delete/$userId');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to delete user: ${response.body}');
    }
  }

  static Future<http.Response> getAllUsers() async {
    final url = Uri.parse('$baseUrl/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to fetch all users: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> sendResetCode(String email) async {
    final url = Uri.parse('$baseUrl/send-Reset-Code');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
  );

     if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error al enviar código de recuperación: ${response.body}');
  }
  }

  static Future<Map<String, dynamic>> validateResetCode(
    String email,
    String code,
  ) async {
    final url = Uri.parse('$baseUrl/validate-ResetCode');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al validar el código: ${response.body}');
    }
  }

  static Future<http.Response> changePassword(
    String email,
    String newPassword,
  ) async {
    final url = Uri.parse('$baseUrl/change-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'newPassword': newPassword}),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Error al cambiar la contraseña: ${response.body}');
    }
  }
}
