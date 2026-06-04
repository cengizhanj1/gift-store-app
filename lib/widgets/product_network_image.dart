import 'package:flutter/material.dart';

/// Network product image with loading and error fallback.
class ProductNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final BoxFit fit;

  const ProductNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: colorScheme.surfaceContainerHighest,
              child: Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: colorScheme.primaryContainer.withValues(alpha: 0.5),
              child: Icon(
                Icons.image_not_supported_outlined,
                size: height * 0.35,
                color: colorScheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
