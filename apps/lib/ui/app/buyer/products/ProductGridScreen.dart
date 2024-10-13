import 'package:flutter/material.dart';

class ProductGridScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {"name": "Producto 1", "image": "https://via.placeholder.com/150"},
    {"name": "Producto 2", "image": "https://via.placeholder.com/150"},
    {"name": "Producto 3", "image": "https://via.placeholder.com/150"},
    {"name": "Producto 4", "image": "https://via.placeholder.com/150"},
    {"name": "Producto 5", "image": "https://via.placeholder.com/150"},
    {"name": "Producto 6", "image": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Mostrar dos productos por fila
            crossAxisSpacing: 8.0, // Espaciado entre columnas
            mainAxisSpacing: 8.0,  // Espaciado entre filas
            childAspectRatio: 2 / 3, // Ajustar el aspecto de cada tarjeta
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Image.network(
                        product['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['name']!,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        // Acción al agregar el producto al carrito
                        print('${product['name']} agregado al carrito');
                      },
                      child: Text(
                        'Agregar al carrito',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Añadir algo de espacio
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
