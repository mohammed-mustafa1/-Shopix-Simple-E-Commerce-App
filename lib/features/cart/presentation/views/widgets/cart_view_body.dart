import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shopix/core/componantes/main_button.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_state.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopix/features/cart/presentation/views/widgets/cart_list_item.dart';
import 'package:shopix/features/products/presentation/views/product_details_view.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
          log(state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Gap(16),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final cart = state.cartItems[index];
                      return Dismissible(
                        key: ValueKey(cart.product.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          context.read<CartCubit>().removeFromCart(
                            product: cart.product,
                          );
                        },
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsView(product: cart.product),
                            ),
                          ),
                          child: CartListItem(
                            cart: cart,
                            onDecrementQuantity: () {
                              context.read<CartCubit>().decrementQuantity(
                                product: cart.product,
                              );
                            },
                            onIncrementQuantity: () {
                              context
                                  .read<CartCubit>()
                                  .addToCartOrIncrementQuantity(
                                    product: cart.product,
                                  );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(8),
                    Text(
                      'Total: \$${state.cartItems.map((e) => e.product.price! * e.quantity).reduce((value, element) => value + element).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(8),
                    MainButton(text: 'Checkout', onPressed: () {}),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
