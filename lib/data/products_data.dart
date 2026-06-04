import 'dart:convert';

import '../models/product.dart';

/// Banner image from WANTAPI (used on home screen).
const String bannerImageUrl = 'https://wantapi.com/assets/banner.png';

/// Local fallback JSON — used when the API is unavailable.
const String _fallbackProductsJson = r'''
{
  "data": [
    {
      "id": 1,
      "name": "iPhone 15 Pro",
      "tagline": "Titanium. So strong. So light. So Pro.",
      "description": "Titanium design with A17 Pro chip, advanced camera system, and all-day battery life.",
      "price": "$999",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/iphone.png",
      "specs": { "chip": "A17 Pro", "material": "Titanium" }
    },
    {
      "id": 2,
      "name": "MacBook Pro 14",
      "tagline": "Pro to the max.",
      "description": "Powerful M3 chip, stunning Liquid Retina XDR display, and up to 18 hours of battery.",
      "price": "$1,599",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/macbook_silver.png",
      "specs": { "chip": "M3 Pro", "display": "14.2 inch" }
    },
    {
      "id": 3,
      "name": "iPad Air",
      "tagline": "Light. Bright. Full of might.",
      "description": "Thin and light design with M1 chip, perfect for work, creativity, and entertainment.",
      "price": "$599",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/ipad_air.png",
      "specs": { "chip": "M1", "display": "10.9 inch" }
    },
    {
      "id": 4,
      "name": "AirPods Pro",
      "tagline": "Adaptive Audio.",
      "description": "Active Noise Cancellation, Adaptive Audio, and personalized Spatial Audio experience.",
      "price": "$249",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/airpods.png",
      "specs": { "chip": "H2", "audio": "Spatial Audio" }
    },
    {
      "id": 5,
      "name": "HomePod",
      "tagline": "Profound sound.",
      "description": "Room-filling sound, Siri intelligence, and smart home hub capabilities.",
      "price": "$299",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/homepod.png",
      "specs": { "audio": "Computational", "home": "Smart Hub" }
    },
    {
      "id": 6,
      "name": "HomePod Mini",
      "tagline": "Color-pop.",
      "description": "Compact smart speaker with impressive sound and seamless HomeKit integration.",
      "price": "$99",
      "currency": "USD",
      "image": "https://wantapi.com/assets/images/homepod_mini.png",
      "specs": { "size": "3.3 inches", "audio": "360-degree" }
    }
  ]
}
''';

/// Loads the offline fallback product list.
List<Product> loadFallbackProducts() {
  final decoded = jsonDecode(_fallbackProductsJson) as Map<String, dynamic>;
  final data = decoded['data'] as List<dynamic>;
  return data
      .map((item) => Product.fromJson(item as Map<String, dynamic>))
      .toList();
}
