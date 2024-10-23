import 'package:apps/ui/app/buyer/orders/OrderHistoryScreen.dart';
import 'package:apps/ui/app/buyer/shared/CartScreen.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final Widget title;

  const BaseLayout({
    Key? key,
    required this.body,
    this.title = const Text('Urban Eats'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Colors.green,
      ),
      body: body,
    );
  }
}
