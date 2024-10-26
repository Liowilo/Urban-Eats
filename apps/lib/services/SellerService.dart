import 'dart:convert';
import 'package:apps/constants.dart';
import 'package:http/http.dart' as http;

class SellerService {
  static const String apiUrl = '${BACKEND_BASE_URL}/api/sellers';

  // Método para obtener los detalles del perfil del vendedor
  Future<Map<String, dynamic>> fetchSellerProfile() async {
    final response = await http.get(
      Uri.parse(apiUrl + '/profile'), // Ruta de la API para obtener el perfil
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el perfil del vendedor');
    }
  }

  // Método para obtener estadísticas del vendedor
  Future<Map<String, dynamic>> fetchSellerStats() async {
    final response = await http.get(
      Uri.parse(apiUrl + '/stats'), // Ruta de la API para obtener las estadísticas
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener las estadísticas del vendedor');
    }
  }

  // Método para actualizar el perfil del vendedor usando PATCH
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? password, // La contraseña puede ser opcional
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    if (password != null && password.isNotEmpty) {
      data['password'] = password;
    }

    final response = await http.patch(
      Uri.parse(apiUrl + '/profile'), // Ruta específica de la API para actualizar el perfil
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el perfil');
    }
  }
}


