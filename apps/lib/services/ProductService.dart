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

  // Obtener productos desde la API por categoría
  Future<List<Product>> fetchProductsByCategory(String category) async {
    // final response = await http.get(Uri.parse('$apiUrl/category/$category'));
    final response = await http.get(Uri.parse(apiUrl));
    
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> productListJson = jsonResponse['products'];
      return productListJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos de la categoría $category');
    }
  }
}
