import 'package:flutter/material.dart';

class ProductTextInfo extends StatelessWidget {
  final String title;
  final String data;

  const ProductTextInfo({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: data,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
