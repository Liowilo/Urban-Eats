import 'package:apps/models/OrderItem.dart';

class Order {
  final String restaurantName;
  final DateTime orderDate;
  final double total;
  final String status;
  final List<OrderItem> items;
  final String paymentMethod;

  Order({
    required this.restaurantName,
    required this.orderDate,
    required this.total,
    required this.status,
    required this.items,
    required this.paymentMethod,
  });

  // Método para convertir un Order a JSON
  Map<String, dynamic> toJson() {
    return {
      'restaurantName': restaurantName,
      'orderDate': orderDate.toIso8601String(),
      'total': total,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'paymentMethod': paymentMethod,
    };
  }

  // Método para crear un Order desde JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      restaurantName: json['restaurantName'],
      orderDate: DateTime.parse(json['orderDate']),
      total: json['total'].toDouble(),
      status: json['status'],
      items: (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList(),
      paymentMethod: json['paymentMethod'],
    );
  }
}
