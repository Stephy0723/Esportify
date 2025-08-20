import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'https://tu-api.com'; // Cambia por tu URL real

  // Obtener info del usuario por su ID
  static Future<Map<String, dynamic>> getUserInfo(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar datos del usuario');
    }
  }

  // Verificar si el usuario tiene un rol
  static Future<bool> tieneRol(String userId, String rol) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/roles'));

    if (response.statusCode == 200) {
      final roles = jsonDecode(response.body) as List;
      return roles.contains(rol.toLowerCase());
    } else {
      return false;
    }
  }

  // Enviar solicitud para un nuevo rol
  static Future<bool> solicitarRol(String userId, String rol) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/$userId/request-role'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rol': rol}),
    );

    return response.statusCode == 200;
  }
}
