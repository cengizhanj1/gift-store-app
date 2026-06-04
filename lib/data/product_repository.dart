import 'dart:convert';
import 'dart:io';

import '../models/product.dart';
import 'products_data.dart';

const String productsApiUrl = 'https://wantapi.com/products.php';

/// Result of loading products from API or fallback.
class ProductLoadResult {
  final List<Product> products;
  final bool fromFallback;

  const ProductLoadResult({
    required this.products,
    required this.fromFallback,
  });
}

/// Fetches products from WANTAPI; uses local fallback on failure.
Future<ProductLoadResult> fetchProducts() async {
  HttpClient? client;
  try {
    client = HttpClient();
    final request = await client.getUrl(Uri.parse(productsApiUrl));
    final response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      return ProductLoadResult(
        products: loadFallbackProducts(),
        fromFallback: true,
      );
    }

    final body = await response.transform(utf8.decoder).join();
    final decoded = jsonDecode(body) as Map<String, dynamic>;
    final data = decoded['data'] as List<dynamic>;

    final products = data
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();

    if (products.isEmpty) {
      return ProductLoadResult(
        products: loadFallbackProducts(),
        fromFallback: true,
      );
    }

    return ProductLoadResult(products: products, fromFallback: false);
  } catch (_) {
    return ProductLoadResult(
      products: loadFallbackProducts(),
      fromFallback: true,
    );
  } finally {
    client?.close(force: true);
  }
}
