import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MiniCatalogApp());
}

/// Root app widget — holds cart state for the whole application.
class MiniCatalogApp extends StatefulWidget {
  const MiniCatalogApp({super.key});

  @override
  State<MiniCatalogApp> createState() => _MiniCatalogAppState();
}

class _MiniCatalogAppState extends State<MiniCatalogApp> {
  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    setState(() => _cartItems.add(product));
  }

  void _removeFromCart(int index) {
    if (index < 0 || index >= _cartItems.length) return;
    setState(() => _cartItems.removeAt(index));
  }

  void _simulateCheckout() {
    if (_cartItems.isEmpty) return;

    final total = _cartItems.fold<double>(
      0,
      (sum, item) => sum + item.priceValue,
    );

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout Simulation'),
        content: Text(
          'Order placed!\n'
          'Items: ${_cartItems.length}\n'
          'Total: \$${total.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _cartItems.clear());
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: HomeScreen(
        cartCount: _cartItems.length,
        cartItems: _cartItems,
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart,
        onCheckout: _simulateCheckout,
      ),
    );
  }
}
