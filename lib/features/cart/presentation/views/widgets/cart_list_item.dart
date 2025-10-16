import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopix/features/products/presentation/widgets/product_image.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    super.key,
    required this.cart,
    this.onIncrementQuantity,
    this.onDecrementQuantity,
  });
  final Cart cart;
  final void Function()? onIncrementQuantity;
  final void Function()? onDecrementQuantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: ProductImage(imageUrl: cart.product.thumbnail ?? ''),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cart.product.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: onDecrementQuantity,

                      icon: const Icon(Icons.remove),
                    ),
                    Gap(4),
                    Text(
                      cart.quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Gap(4),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: onIncrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                    Spacer(),
                    Text(
                      '${(cart.product.price! * cart.quantity).toStringAsFixed(2)} \$',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
