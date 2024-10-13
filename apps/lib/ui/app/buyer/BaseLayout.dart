import 'package:apps/ui/app/buyer/orders/OrderHistoryScreen.dart';
import 'package:apps/ui/app/buyer/shared/CartScreen.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final Widget title;

  const BaseLayout({
    Key? key,
    required this.body,
    this.title = const Text('Urban Eats'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Colors.green,
        actions: <Widget>[
          // Botón para ver el historial de pedidos
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Aquí navegas a la pantalla del historial de pedidos
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderHistoryScreen(),
                ),
              );
            },
          ),
          // Botón para el carrito de compras
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Navega a la pantalla del carrito
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: body,
    );
  }
}
