import 'package:apps/models/CartItem.dart';
import 'package:apps/services/CartService.dart';
import 'package:apps/ui/app/buyer/payment/PaymentScreen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<CartItem> cartItems = [];
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // Cargar los ítems del carrito y calcular el subtotal
  Future<void> _loadCartItems() async {
    List<CartItem> items = await _cartService.getCartItems();
    setState(() {
      cartItems = items;
      subtotal = _calculateSubtotal();
    });
  }

  // Calcular el subtotal de los productos en el carrito
  double _calculateSubtotal() {
    return cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _cartService.clearCart();
              setState(() {
                cartItems = [];
                subtotal = 0.0;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrito vaciado')),
              );
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Text(
          'El carrito está vacío',
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('Cantidad: ${item.quantity} - Precio: \$${item.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () async {
                        await _cartService.removeFromCart(item);
                        _loadCartItems(); // Actualiza el carrito después de eliminar
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Subtotal y botón de pagar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subtotal: \$${subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de pago
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Pagar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}