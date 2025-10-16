import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopix/core/componantes/main_loading_indecator.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) {
        return MainLoadingIndecator();
      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
    );
  }
}
