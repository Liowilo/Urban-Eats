import 'package:apps/ui/app/seller/products/ProductDetailsScreen.dart';
import 'package:apps/ui/app/seller/products/CreateProductScreen.dart'; // Importar la nueva pantalla
import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart';
import 'package:apps/services/ProductService.dart'; // Importar el servicio de productos

class ProductsScreen extends StatelessWidget {
  // Instancia del servicio de productos
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Productos'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Product>>(
          future: productService.fetchCurrentUserProducts(), // Llamamos al método para obtener productos
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras esperamos
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Muestra el error si lo hay
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay productos disponibles')); // Maneja la ausencia de productos
            }

            final List<Product> products = snapshot.data!; // Los productos obtenidos de la API

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(context, product);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación de productos
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateProductScreen(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
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
