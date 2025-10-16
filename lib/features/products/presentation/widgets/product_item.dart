import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopix/core/errors/service_locator.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopix/features/products/data/model/product/product.dart';
import 'package:shopix/features/products/presentation/widgets/discount_badge.dart';
import 'package:shopix/features/products/presentation/widgets/product_image.dart';
import 'package:shopix/features/products/presentation/widgets/rating_with_text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              product.discountPercentage != null &&
                      product.discountPercentage! >= 1
                  ? DiscountBadge(dicount: product.discountPercentage ?? 0)
                  : const SizedBox(),
              ProductImage(imageUrl: product.thumbnail ?? ''),
            ],
          ),
        ),
        Gap(8),
        RatingWithText(rating: product.rating ?? 0),
        Text(product.category ?? '', style: TextStyle(color: Colors.black54)),
        Flexible(
          child: Text(
            product.title ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Gap(6),
        Text(
          calculatePriceBeforeDescount(
            product.price ?? 0,
            product.discountPercentage ?? 0,
          ).toString(),
          style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.lineThrough,
            decorationThickness: 1.5,
          ),
        ),
        Row(
          children: [
            Text(
              '${product.price} \$',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                getIt<CartCubit>().addToCartOrIncrementQuantity(
                  product: product,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product added to cart 🛒'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  'Add To Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String calculatePriceBeforeDescount(double price, double discount) {
  return (price / (1 - discount / 100)).toStringAsFixed(2);
}
