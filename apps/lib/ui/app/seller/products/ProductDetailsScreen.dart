import 'package:apps/ui/app/seller/products/EditProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart';
import 'package:apps/services/ProductService.dart'; // Asegúrate de importar ProductService

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductService _productService = ProductService(); // Inicializar el servicio

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Imagen del producto
            Image.network(
              product.imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Nombre del producto
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Precio del producto
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Descripción del producto
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const Spacer(),

            // Botones para acciones adicionales (Editar, Eliminar)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de editar producto
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductScreen(product: product),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: const Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, _productService);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el diálogo de confirmación
  Future<void> _showDeleteConfirmationDialog(BuildContext context, ProductService productService) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // El diálogo no se puede cerrar tocando fuera
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () async {
                // Llamar a la función de eliminar producto
                await _deleteProduct(context, productService);
              },
            ),
          ],
        );
      },
    );
  }

  // Método para eliminar el producto
  Future<void> _deleteProduct(BuildContext context, ProductService productService) async {
    try {
      await productService.deleteProduct(product.id);
      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado con éxito')),
      );
      Navigator.of(context).pop(); // Cerrar el diálogo
      Navigator.of(context).pop(); // Regresar a la pantalla anterior (lista de productos)
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar el producto')),
      );
      Navigator.of(context).pop(); // Cerrar el diálogo
    }
  }
}
