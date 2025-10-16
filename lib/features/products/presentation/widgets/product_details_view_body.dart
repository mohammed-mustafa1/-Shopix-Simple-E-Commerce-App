import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopix/core/componantes/main_button.dart';
import 'package:shopix/core/errors/service_locator.dart';
import 'package:shopix/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:shopix/features/products/data/model/product/product.dart';
import 'package:shopix/features/products/presentation/widgets/product_image.dart';
import 'package:shopix/features/products/presentation/widgets/rating_with_text.dart';
import 'package:shopix/features/products/presentation/widgets/reviews_list_view.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final images = product.images ?? [];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: images.length,
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ProductImage(imageUrl: images[index]),
                              ),
                            ),
                          ),
                          const Gap(8),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final isSelected = currentIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.orange
                                            : Colors.grey.shade300,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          child: Text(
                            product.title ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite, color: Colors.orange),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      '${calculatePriceBeforeDiscount(product.price ?? 0, product.discountPercentage ?? 0)} \$',
                      style: const TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 1.5,
                      ),
                    ),
                    Text(
                      '${product.price ?? 0} \$',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingWithText(rating: product.rating ?? 0),
                    const Gap(8),
                    Text(product.description ?? ''),
                    const Gap(16),
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    ReviewsListView(reviews: product.reviews ?? []),
                  ],
                ),
              ),
            ),
            MainButton(
              text: 'Add to cart',
              onPressed: () {
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
            ),
          ],
        ),
      ),
    );
  }
}

String calculatePriceBeforeDiscount(double price, double discount) {
  final beforeDiscount = price / (1 - discount / 100);
  return beforeDiscount.toStringAsFixed(2);
}
