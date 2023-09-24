import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage cachedNetworkImageHandler({
  required String imageUrl,
  String? cacheKey,
  BoxFit? fit,
  double? width,
  double? height,
  double? squareSize,
  Widget? errorWidget,
  Widget? loadingWidget = const Center(child: CircularProgressIndicator(strokeWidth: 4)),
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    width: squareSize ?? width,
    height: squareSize ?? height,
    cacheKey: cacheKey ?? imageUrl,
    errorWidget: (_, __, ___) => errorWidget ?? const Center(child: Icon(Icons.error)),
    placeholder: loadingWidget == null ? null : (_, __) => loadingWidget,
  );
}
