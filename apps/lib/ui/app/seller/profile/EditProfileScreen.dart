import 'package:flutter/material.dart';
import 'package:apps/services/SellerService.dart'; // Asegúrate de importar tu SellerService

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controladores para manejar el estado de los inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instancia de SellerService
  final SellerService _sellerService = SellerService();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con valores predeterminados si es necesario
    _nameController.text = "Juan Pérez";
    _emailController.text = "juan.perez@mail.com";
    _phoneController.text = "555-1234";
    _passwordController.text = "123456"; // Podría ser vacío en un escenario real
  }

  @override
  void dispose() {
    // Limpiar los controladores cuando la pantalla se elimine
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    try {
      await _sellerService.updateProfile(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil actualizado con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Campo de nombre
            _buildTextInputField(
              label: 'Nombre',
              controller: _nameController,
              icon: Icons.person,
            ),
            const SizedBox(height: 20),

            // Campo de correo
            _buildTextInputField(
              label: 'Correo',
              controller: _emailController,
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Campo de teléfono
            _buildTextInputField(
              label: 'Teléfono',
              controller: _phoneController,
              icon: Icons.phone,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            // Campo de contraseña (opcional)
            _buildTextInputField(
              label: 'Contraseña',
              controller: _passwordController,
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 40),

            // Botón de Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Color del botón
                ),
                child: const Text('Guardar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un TextFormField genérico
  Widget _buildTextInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword, // Para ocultar texto si es una contraseña
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
