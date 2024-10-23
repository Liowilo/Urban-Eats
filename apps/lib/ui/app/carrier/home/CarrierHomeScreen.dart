import 'package:apps/ui/app/carrier/CarrierBaseLayout.dart';
import 'package:apps/ui/app/carrier/available/AvailableOrdersScreen.dart';
import 'package:apps/ui/app/carrier/history/DeliveriesHistoryScreen.dart';
import 'package:flutter/material.dart';

class CarrierHomeScreen extends StatelessWidget {
  const CarrierHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.delivery_dining, size: 40),
          const SizedBox(width: 10),
          const Text(
            "Inicio del Carrier",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Card para mostrar información del perfil
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mi Perfil",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Información del perfil
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.green),
                        const SizedBox(width: 10),
                        const Text(
                          "Nombre: Juan Pérez", // Ejemplo de nombre
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.green),
                        const SizedBox(width: 10),
                        const Text(
                          "Email: juan.perez@example.com", // Ejemplo de email
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.green),
                        const SizedBox(width: 10),
                        const Text(
                          "Fecha de Registro: 12/01/2023",
                          // Ejemplo de fecha de registro
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Botones de acciones
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.local_shipping,
                        size: 24, color: Colors.white),
                    label: Text(
                      "Nueva Entrega",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Lógica para nueva entrega
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvailableOrdersScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.history, size: 24, color: Colors.white),
                    label: Text(
                      "Historial",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Navegar al historial de entregas
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveriesHistoryScreen(),
                        ),
                      );
                    },
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
