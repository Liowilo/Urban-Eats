import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart';
import 'package:apps/services/ProductService.dart'; // Asegúrate de importar ProductService

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  // Controladores de texto para los campos
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final ProductService _productService = ProductService(); // Instancia del servicio

  @override
  void dispose() {
    // Limpiar los controladores cuando se elimine la pantalla
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Método para crear el producto usando el servicio
  Future<void> _createProduct() async {
    try {
      // Crear una instancia de Producto con los datos del formulario
      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch, // Generar un ID temporal
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: _imageController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
      );

      // Enviar el producto a la API
      await _productService.createProduct(newProduct);

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto creado con éxito')),
      );

      // Volver a la pantalla anterior
      Navigator.of(context).pop();
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
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
              icon: Icons.label,
            ),
            const SizedBox(height: 20),

            // Campo de descripción
            _buildTextInputField(
              label: 'Descripción',
              controller: _descriptionController,
              icon: Icons.description,
            ),
            const SizedBox(height: 20),

            // Campo de imagen (URL)
            _buildTextInputField(
              label: 'URL de la Imagen',
              controller: _imageController,
              icon: Icons.image,
            ),
            const SizedBox(height: 20),

            // Campo de precio
            _buildTextInputField(
              label: 'Precio',
              controller: _priceController,
              icon: Icons.attach_money,
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 40),

            // Botón para crear el producto
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createProduct,
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: const Text('Crear Producto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un campo de entrada genérico
  Widget _buildTextInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
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
