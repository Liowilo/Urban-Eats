import 'package:flutter/material.dart';
import 'package:apps/models/Product.dart';
import 'package:apps/services/ProductService.dart'; // Asegúrate de importar ProductService

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // Controladores de texto para los campos editables
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;

  final ProductService _productService = ProductService(); // Instancia del servicio

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales del producto
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _imageController = TextEditingController(text: widget.product.imagePath);
    _priceController = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    // Limpiar los controladores al eliminar la pantalla
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Método para guardar el producto actualizado
  Future<void> _saveProduct() async {
    try {
      // Crear un producto actualizado con los datos del formulario
      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: _imageController.text,
        price: double.parse(_priceController.text),
      );

      // Enviar el producto actualizado a la API
      await _productService.updateProduct(updatedProduct);

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto actualizado con éxito')),
      );

      // Volver a la pantalla anterior
      Navigator.of(context).pop();
    } catch (e) {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
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

            // Botón para guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: const Text('Guardar'),
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
