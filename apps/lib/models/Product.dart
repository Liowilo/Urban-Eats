class Product {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  });

  // Convertir el producto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
    };
  }

  // Convertir JSON a un producto
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? json['title'],
      description: json['description'],
      imagePath: json['imagePath'] ?? json['images'][0],
      price: json['price'],
    );
  }
}
