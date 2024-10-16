import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';

class ProductComments extends StatelessWidget {
  final String userImage;
  final String comment;
  final double rating;

  const ProductComments({ 
    required this.userImage,
    required this.comment,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(userImage),
            ),
            const SizedBox(width: ApplicationStylesConstants.spacing10Sp),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildStars(rating),
                      const SizedBox(width: 10),
                      Text(rating.toString(), 
                      style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: ApplicationStylesConstants.spacing10Sp),
                  Text(
                    comment,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      IconData icon = i <= rating ? Icons.star : Icons.star_border;
      if (i == rating.floor() + 1 && rating - rating.floor() >= 0.5 && rating - rating.floor() < 1.0) {
        icon = Icons.star_half;
      }
      stars.add(Icon(icon, color: ApplicationColors.lightOrange));
    }
    return Row(children: stars); 
  }
}
