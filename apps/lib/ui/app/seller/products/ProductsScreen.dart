import 'package:apps/ui/app/seller/products/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart';

class ProductsScreen extends StatelessWidget {
  // Simulación de lista de productos (normalmente vendría de una API o base de datos)
  final List<Product> products = [
    Product(
      id: 1,
      name: "Pizza Margarita",
      description: "Deliciosa pizza con salsa de tomate y queso mozzarella.",
      imagePath: "https://via.placeholder.com/150",
      price: 8.99,
    ),
    Product(
      id: 2,
      name: "Hamburguesa Clásica",
      description: "Hamburguesa con carne de res, lechuga y tomate.",
      imagePath: "https://via.placeholder.com/150",
      price: 6.50,
    ),
    Product(
      id: 3,
      name: "Ensalada César",
      description: "Ensalada César con pollo, lechuga romana y aderezo.",
      imagePath: "https://via.placeholder.com/150",
      price: 7.25,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Productos'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(context, product);
          },
        ),
      ),
    );
  }

  // Método para construir la tarjeta de un producto
  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        // Al hacer clic, navegar a la pantalla de detalles del producto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              // Imagen del producto
              Image.network(
                product.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              // Detalles del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
