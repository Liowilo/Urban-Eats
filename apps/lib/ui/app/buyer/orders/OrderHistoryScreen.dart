import 'package:apps/models/Order.dart';
import 'package:apps/models/OrderItem.dart';
import 'package:apps/ui/app/buyer/orders/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';

// Pantalla del historial de pedidos
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  // Lista ficticia de pedidos
  List<Order> getOrderHistory() {
    List<OrderItem> items = [
      OrderItem(name: 'Pizza Margherita', quantity: 1, price: 12.50),
      OrderItem(name: 'Ensalada César', quantity: 2, price: 6.25),
      OrderItem(name: 'Refresco', quantity: 3, price: 2.50),
    ];

    return [
      Order(
        restaurantName: 'Urban Eats',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        total: 30.00,
        status: 'Completado',
        items: items,
        paymentMethod: 'Tarjeta de crédito',
      ),
      Order(
        restaurantName: 'Pizza Place',
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        total: 25.00,
        status: 'Completado',
        items: items,
        paymentMethod: 'Efectivo',
      ),
      Order(
          restaurantName: 'Burger King',
          orderDate: DateTime.now().subtract(const Duration(days: 7)),
          total: 20.00,
          status: 'Cancelado',
          items: items,
          paymentMethod: 'Efectivo')
    ];
  }

  // Función para dar formato a la fecha
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final List<Order> orders =
        getOrderHistory(); // Obtener el historial de pedidos

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Pedidos'),
        backgroundColor: Colors.green,
      ),
      body: orders.isNotEmpty
          ? ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.receipt, color: Colors.green),
                    title: Text(order.restaurantName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Fecha: ${formatDate(order.orderDate)}'),
                        Text('Total: \$${order.total.toStringAsFixed(2)}'),
                        Text('Estado: ${order.status}'),
                      ],
                    ),
                    trailing: Icon(
                      order.status == 'Completado'
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: order.status == 'Completado'
                          ? Colors.green
                          : Colors.red,
                    ),
                    // Navegación a OrderDetailsScreen al hacer clic en el pedido
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailsScreen(order: order),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : const Center(
              child: Text('No tienes pedidos en el historial.'),
            ),
    );
  }
}
