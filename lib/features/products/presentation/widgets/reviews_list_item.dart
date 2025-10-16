import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shopix/features/products/data/model/product/review.dart';
import 'package:shopix/features/products/presentation/widgets/rating_with_text.dart';

class ReviewsListItem extends StatelessWidget {
  const ReviewsListItem({
    super.key,
    required this.review,
  });

  final Review? review;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                // Text(rev?.reviewerName ?? ''),
                Text(
                  // rev?.date.toString() ??
                      DateTime.now().toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Gap(4),
            RatingWithText(
              rating: review?.rating?.toDouble() ?? 0,
            ),
            const Gap(8),
            Text(
              review?.comment ?? '',
              style: const TextStyle(
                color: Colors.black54,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
