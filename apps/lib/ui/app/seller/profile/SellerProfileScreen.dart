import 'package:apps/services/SellerService.dart';
import 'package:apps/ui/app/seller/SellerBaseLayout.dart';
import 'package:apps/ui/app/seller/products/ProductsScreen.dart';
import 'package:apps/ui/app/seller/profile/EditProfileScreen.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatelessWidget {
  final SellerService sellerService =
      SellerService(); // Inicializamos el servicio

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: const Text('Panel de Vendedor'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchSellerData(), // Llamamos al método que trae los datos
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No se encontraron datos'));
            }

            final sellerData = snapshot.data!;
            final profile = sellerData['profile'];
            final stats = sellerData['stats'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Información del perfil
                const Text(
                  "Perfil del Vendedor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                _buildProfileInfo(profile), // Pasamos la información del perfil

                const SizedBox(height: 20),

                // Estadísticas
                const Text(
                  "Estadísticas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),

                // Apilamos las tarjetas en una columna
                _buildStatCard(
                  "Ventas Totales",
                  stats['ordersAmount'].toString(),
                  context,
                ),
                const SizedBox(height: 10),
                _buildStatCard(
                  "Productos Listados",
                  stats['listedProducts'].toString(),
                  context,
                ),
                const SizedBox(height: 10),
                _buildStatCard(
                  "Ingresos Totales",
                  "\$${stats['totalRevenue'].toString()}",
                  context,
                ),

                const SizedBox(height: 20),

                // Botones Editar Perfil y Productos
                _buildActionButtons(context, profile),
              ],
            );
          },
        ),
      ),
    );
  }

  // Método que obtiene los datos de perfil y estadísticas en paralelo
  Future<Map<String, dynamic>> _fetchSellerData() async {
    final profile = await sellerService.fetchSellerProfile();
    final stats = await sellerService.fetchSellerStats();

    return {
      'profile': profile,
      'stats': stats,
    };
  }

  // Modificamos el _buildProfileInfo para recibir el perfil dinámicamente
  Widget _buildProfileInfo(Map<String, dynamic> profile) {
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
            _buildProfileField("Nombre", profile['name']),
            const SizedBox(height: 10),
            _buildProfileField("Correo", profile['email']),
            const SizedBox(height: 10),
            _buildProfileField("Teléfono", profile['phone']),
            const SizedBox(height: 10),
            _buildProfileField("Fecha de creación", profile['createdAt']),
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
  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Botón para Editar Perfil
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  initialProfile: profile,
                ),
              ),
            );
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductsScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Color de fondo del botón
          ),
          child: const Text('Productos', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
