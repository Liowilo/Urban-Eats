import 'package:flutter/material.dart';
import 'package:apps/models/Order.dart'; // Asegúrate de que este import esté apuntando correctamente al modelo Order

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  // Función para dar formato a la fecha
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Pedido'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre del restaurante
            Text(
              order.restaurantName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Fecha del pedido
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.green),
                const SizedBox(width: 10),
                Text('Fecha: ${formatDate(order.orderDate)}'),
              ],
            ),
            const SizedBox(height: 10),

            // Total del pedido
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                const SizedBox(width: 10),
                Text('Total: \$${order.total.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 10),

            // Estado del pedido
            Row(
              children: [
                Icon(
                  order.status == 'Completado' ? Icons.check_circle : Icons.cancel,
                  color: order.status == 'Completado' ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Text('Estado: ${order.status}'),
              ],
            ),
            const SizedBox(height: 20),

            // Detalles de productos (opcional, si el modelo incluye una lista de productos)
            if (order.items != null && order.items.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Productos pedidos:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: order.items.length,
                        itemBuilder: (context, index) {
                          final item = order.items[index];
                          return ListTile(
                            leading: const Icon(Icons.fastfood),
                            title: Text(item.name),
                            subtitle: Text('Cantidad: ${item.quantity}'),
                            trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
