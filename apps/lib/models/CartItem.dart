class CartItem {
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  // Convertir un CartItem a un Map (para JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  // Crear un CartItem desde un Map (deserialización de JSON)
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}