import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apps/models/Product.dart'; // Modelo Product

class ProductService {
  static const String apiUrl = 'https://dummyjson.com/products';

  // Método para obtener productos desde la API
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> productListJson = jsonResponse['products'];
      return productListJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  // Método para obtener productos desde la API por categoría
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> productListJson = jsonResponse['products'];
      return productListJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos de la categoría $category');
    }
  }

  // Método para eliminar un producto de la API
  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$productId'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el producto');
    }
  }

  // Método para actualizar un producto de la API
  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el producto');
    }
  }
}
