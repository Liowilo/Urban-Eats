import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart'; // Modelo Product
import 'package:apps/models/CartItem.dart'; // Modelo CartItem
import 'package:apps/services/CartService.dart'; // Servicio de carrito
import 'package:apps/services/ProductService.dart'; // Servicio de productos
import 'package:apps/ui/app/buyer/BaseLayout.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;

  const CategoryScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CartService _cartService = CartService();
  late Future<List<Product>> _productsFuture;
  final ProductService _productService = ProductService(); // Usamos ProductService sin parámetros

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.fetchProductsByCategory(widget.categoryName); // Cargar productos por categoría
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: Text('Categoría: ${widget.categoryName}'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mostrando resultados para ${widget.categoryName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar productos'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay productos disponibles en esta categoría'));
                  } else {
                    List<Product> products = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return _buildProductItem(product, context);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir cada producto en el grid
  Widget _buildProductItem(Product product, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.network(product.imagePath, fit: BoxFit.cover), // Imagen del producto
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                // Crear un CartItem y agregarlo al carrito
                CartItem cartItem = CartItem(
                  name: product.name,
                  quantity: 1, // Suponemos 1 unidad por default, puedes personalizarlo
                  price: product.price,
                );
                await _cartService.addToCart(cartItem);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} agregado al carrito')),
                );
              },
              child: const Text(
                'Agregar al carrito',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8), // Espaciado al final
        ],
      ),
    );
  }
}
