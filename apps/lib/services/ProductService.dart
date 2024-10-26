import 'dart:convert';
import 'package:apps/constants.dart';
import 'package:http/http.dart' as http;
import 'package:apps/models/Product.dart';

class ProductService {
  static const String apiUrl = 'https://dummyjson.com/products';
  static const String sellerApiUrl = '${BACKEND_BASE_URL}/api/sellers';

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
  
  Future<List<Product>> fetchCurrentUserProducts() async {
    final response = await http.get(
      Uri.parse(sellerApiUrl + '/products'), // Ruta de la API para obtener el perfil
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Product.fromJson(json)).toList();
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
    final response = await http.delete(
      Uri.parse('$PRODUCTS_API_URL/${productId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el producto');
    }
  }

  // Método para actualizar un producto de la API
  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$PRODUCTS_API_URL/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Error al actualizar el producto');
    }
  }

  // Método para crear un nuevo producto en la API
  Future<void> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$PRODUCTS_API_URL'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {  // Código de éxito para creación es 201
      throw Exception('Error al crear el producto');
    }
  }
}
