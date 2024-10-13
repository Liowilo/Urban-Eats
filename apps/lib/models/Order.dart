import 'package:apps/models/OrderItem.dart';

class Order {
  final String restaurantName;
  final DateTime orderDate;
  final double total;
  final String status;
  final List<OrderItem> items; // Lista de productos ahora llamada OrderItem

  Order({
    required this.restaurantName,
    required this.orderDate,
    required this.total,
    required this.status,
    required this.items, // Requerimos la lista de productos en el constructor
  });
}