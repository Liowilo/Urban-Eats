import 'dart:convert';
import 'package:http/http.dart' as http;

class SellerService {
  static const String apiUrl = 'https://api.example.com/sellers'; // URL de la API para vendedores

  // Método para actualizar el perfil del vendedor
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl + '/updateProfile'), // Ruta específica de la API para actualizar el perfil
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el perfil');
    }
  }
}
