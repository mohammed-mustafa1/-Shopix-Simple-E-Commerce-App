import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RatingWithText extends StatelessWidget {
  final double rating;

  const RatingWithText({super.key, required this.rating});
  final int maxStars = 5;
  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < maxStars; i++)
          Icon(
            i < fullStars
                ? Icons.star
                : hasHalfStar && i == fullStars
                ? Icons.star_half
                : Icons.star_border,
            color: Colors.orange,
            size: 18,
          ),
        Gap(6),
        Text(
          "(${rating.toStringAsFixed(1)})",
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
