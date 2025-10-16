import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopix/features/products/data/model/product/review.dart';
import 'package:shopix/features/products/presentation/widgets/reviews_list_item.dart';

class ReviewsListView extends StatelessWidget {
  const ReviewsListView({super.key, required this.reviews});

  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Gap(16),
      itemCount: reviews.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final rev = reviews[index];
        return ReviewsListItem(review: rev);
      },
    );
  }
}
