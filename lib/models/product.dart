/// Product model — matches WANTAPI product fields.
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String currency;
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// Numeric price for cart totals (strips currency symbols safely).
  double get priceValue => parsePriceValue(price);

  /// Price label shown in the UI (e.g. "$999").
  String get displayPrice => price;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] as int : int.parse('${json['id']}'),
      name: json['name'] as String,
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price']?.toString() ?? '0',
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String? ?? '',
      specs: _parseSpecs(json['specs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }

  static Map<String, String> _parseSpecs(dynamic specs) {
    if (specs is! Map) return {};
    return specs.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
  }

  static double parsePriceValue(String priceText) {
    final cleaned = priceText.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  /// Search across name, tagline, description, and spec values.
  bool matchesSearch(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    if (name.toLowerCase().contains(q)) return true;
    if (tagline.toLowerCase().contains(q)) return true;
    if (description.toLowerCase().contains(q)) return true;
    for (final value in specs.values) {
      if (value.toLowerCase().contains(q)) return true;
    }
    return false;
  }
}
