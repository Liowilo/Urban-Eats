import 'package:flutter/material.dart';

class AvailableOrdersScreen extends StatelessWidget {
  const AvailableOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de órdenes disponibles (ejemplo)
    final List<Map<String, String>> availableOrders = [
      {
        'pickup': 'Restaurante A, Calle Principal 100',
        'delivery': 'Calle Secundaria 200, Ciudad',
        'payment': '\$5.00',
      },
      {
        'pickup': 'Restaurante B, Avenida Central 150',
        'delivery': 'Calle Tercera 300, Ciudad',
        'payment': '\$7.00',
      },
      {
        'pickup': 'Restaurante C, Calle Cuarta 120',
        'delivery': 'Calle Quinta 400, Ciudad',
        'payment': '\$6.50',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes Disponibles'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: availableOrders.length,
          itemBuilder: (context, index) {
            final order = availableOrders[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(
                  Icons.restaurant,
                  color: Colors.green,
                  size: 40,
                ),
                title: Text(
                  'Recoger: ${order['pickup']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('Entregar: ${order['delivery']}\nPago: ${order['payment']}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Lógica para aceptar la orden
                    _acceptOrder(context, order);
                  },
                  child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Color de botón "Aceptar"
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Método para manejar la lógica de aceptar una orden
  void _acceptOrder(BuildContext context, Map<String, String> order) {
    // Aquí puedes agregar la lógica para aceptar la orden.
    // Por ejemplo, enviar una solicitud al backend para asignar la orden al carrier.

    // Mostramos un diálogo confirmando la aceptación de la orden
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Orden aceptada'),
          content: Text('Has aceptado la orden para entregar a ${order['delivery']}.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
