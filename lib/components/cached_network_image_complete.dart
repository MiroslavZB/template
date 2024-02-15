import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageComplete extends StatelessWidget {
  final String imageUrl;
  final String? cacheKey;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? squareSize;
  final Widget? errorWidget;
  final Widget? loadingWidget;

  const CachedNetworkImageComplete({
    super.key,
    required this.imageUrl,
    this.cacheKey,
    this.fit,
    this.width,
    this.height,
    this.squareSize,
    this.errorWidget,
    // handles issues with loading of some images
    this.loadingWidget = const Center(child: CircularProgressIndicator(strokeWidth: 4)),
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: squareSize ?? width,
      height: squareSize ?? height,
      cacheKey: cacheKey ?? imageUrl,
      errorWidget: (_, __, ___) => errorWidget ?? const Center(child: Icon(Icons.error)),
      placeholder: loadingWidget == null ? null : (_, __) => loadingWidget!,
    );
  }
}
