import 'package:apps/ui/app/seller/SellerBaseLayout.dart';
import 'package:apps/ui/app/seller/products/ProductsScreen.dart';
import 'package:apps/ui/app/seller/profile/EditProfileScreen.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatelessWidget {
  // Ejemplo de data que podríamos obtener de la base de datos
  final String nombre = "Juan Pérez";
  final String correo = "juan.perez@mail.com";
  final String telefono = "555-1234";
  final String fechaCreacion = "2023-01-01";

  // Ejemplo de estadísticas básicas
  final int ventasTotales = 120;
  final int productosListados = 15;
  final double ingresosTotales = 4500.00;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: const Text('Panel de Vendedor'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Información del perfil
            const Text(
              "Perfil del Vendedor",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 10),
            _buildProfileInfo(),

            const SizedBox(height: 20),

            // Estadísticas
            const Text(
              "Estadísticas",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 10),

            // Apilamos las tarjetas en una columna
            _buildStatCard("Ventas Totales", ventasTotales.toString(), context),
            const SizedBox(height: 10),
            _buildStatCard(
                "Productos Listados", productosListados.toString(), context),
            const SizedBox(height: 10),
            _buildStatCard("Ingresos Totales", "\$$ingresosTotales", context),

            const SizedBox(height: 20),

            // Botones Editar Perfil y Productos
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  // Widget que construye la información del perfil
  Widget _buildProfileInfo() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProfileField("Nombre", nombre),
            const SizedBox(height: 10),
            _buildProfileField("Correo", correo),
            const SizedBox(height: 10),
            _buildProfileField("Teléfono", telefono),
            const SizedBox(height: 10),
            _buildProfileField("Fecha de creación", fechaCreacion),
          ],
        ),
      ),
    );
  }

  // Método que construye un campo individual del perfil
  Widget _buildProfileField(String label, String value) {
    return Row(
      children: <Widget>[
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }

  // Método que construye una tarjeta para cada estadística
  Widget _buildStatCard(String label, String value, BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.green[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.green[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir los botones de acción
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Botón para Editar Perfil
        ElevatedButton(
          onPressed: () {
            // Aquí iría la navegación hacia la pantalla de editar perfil
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Color de fondo del botón
          ),
          child: const Text('Editar Perfil',
              style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 10),

        // Botón para ver Productos
        ElevatedButton(
          onPressed: () {
            // Aquí iría la navegación hacia la pantalla de productos
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Color de fondo del botón
          ),
          child: const Text('Productos',
              style: TextStyle(color: Colors.white)
          ),
        ),
      ],
    );
  }
}
