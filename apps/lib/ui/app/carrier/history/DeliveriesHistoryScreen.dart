import 'package:flutter/material.dart';

class DeliveriesHistoryScreen extends StatelessWidget {
  const DeliveriesHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de entregas de ejemplo. Puedes obtener esta lista de una API o base de datos.
    final List<Map<String, String>> deliveries = [
      {
        'date': '23/10/2024',
        'address': 'Calle Falsa 123, Ciudad',
        'status': 'Entregado',
      },
      {
        'date': '22/10/2024',
        'address': 'Avenida Siempre Viva 742, Ciudad',
        'status': 'Entregado',
      },
      {
        'date': '21/10/2024',
        'address': 'Calle Luna, Calle Sol, Ciudad',
        'status': 'Pendiente',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Entregas'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: deliveries.length,
          itemBuilder: (context, index) {
            final delivery = deliveries[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Icon(
                  delivery['status'] == 'Entregado'
                      ? Icons.check_circle
                      : Icons.access_time,
                  color: delivery['status'] == 'Entregado' ? Colors.green : Colors.orange,
                  size: 40,
                ),
                title: Text(
                  delivery['address']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text('Fecha: ${delivery['date']!}\nEstado: ${delivery['status']!}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
