import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apps/models/Order.dart';

class OrderService {
  static const String apiUrl = 'https://api.example.com/orders'; // URL de la API

  // Método para enviar la orden confirmada a la API
  Future<void> confirmOrder(Order order) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al confirmar la orden');
    }
  }
}
