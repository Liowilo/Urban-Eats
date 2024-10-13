import 'dart:convert';
import 'package:apps/models/CartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String _cartKey = 'user_cart';

  // Agregar un producto al carrito
  Future<void> addToCart(CartItem item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList = prefs.getStringList(_cartKey) ?? [];

    // Convertir el item a JSON y agregarlo a la lista
    cartJsonList.add(jsonEncode(item.toJson()));
    await prefs.setStringList(_cartKey, cartJsonList);
  }

  // Obtener todos los productos en el carrito
  Future<List<CartItem>> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList = prefs.getStringList(_cartKey) ?? [];

    // Convertir cada elemento de JSON a CartItem
    return cartJsonList
        .map((itemJson) => CartItem.fromJson(jsonDecode(itemJson)))
        .toList();
  }

  // Eliminar un producto del carrito
  Future<void> removeFromCart(CartItem item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList = prefs.getStringList(_cartKey) ?? [];

    // Buscar el ítem por su nombre y cantidad y eliminarlo
    cartJsonList.removeWhere((itemJson) {
      final CartItem cartItem = CartItem.fromJson(jsonDecode(itemJson));
      return cartItem.name == item.name && cartItem.quantity == item.quantity;
    });

    // Guardar la lista actualizada
    await prefs.setStringList(_cartKey, cartJsonList);
  }

  // Limpiar el carrito
  Future<void> clearCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}