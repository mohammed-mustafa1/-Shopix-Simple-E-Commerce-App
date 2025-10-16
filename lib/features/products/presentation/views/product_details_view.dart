import 'package:flutter/material.dart';
import 'package:shopix/features/products/data/model/product/product.dart';
import 'package:shopix/features/products/presentation/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? '')),
      body: ProductDetailsViewBody(product: product),
    );
  }
}
