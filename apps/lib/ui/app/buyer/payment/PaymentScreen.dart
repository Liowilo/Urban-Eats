import 'package:flutter/material.dart';
import 'package:apps/models/CartItem.dart';
import 'package:apps/services/CartService.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  double _subtotal = 0.0;
  double _total = 0.0;
  String _selectedPaymentMethod = 'Efectivo';

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // Cargar los items del carrito y calcular el subtotal
  Future<void> _loadCartItems() async {
    List<CartItem> items = await _cartService.getCartItems();
    setState(() {
      _cartItems = items;
      _subtotal = _calculateSubtotal();
      _total = _subtotal; // El total es igual al subtotal, ya que no hay impuestos
    });
  }

  // Calcular el subtotal
  double _calculateSubtotal() {
    return _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }

  // Confirmación de pago
  void _confirmPayment() {
    // Simulamos el proceso de pago
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmacion de Orden'),
          content: const Text('Tu orden ha sido procesada exitosamente. Recibiras mas detalles en breve.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
                Navigator.of(context).pop(); // Cerrar pantalla de pago
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen del pedido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Cantidad: ${item.quantity} - Precio: \$${item.price.toStringAsFixed(2)}'),
                    trailing: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total: \$${_total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Método de pago',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPaymentMethod = newValue!;
                });
              },
              items: <String>['Efectivo', 'Transferencia']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Realizar Pago',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
