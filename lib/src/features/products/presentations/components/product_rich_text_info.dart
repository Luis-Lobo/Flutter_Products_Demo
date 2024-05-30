import 'package:flutter/material.dart';

class ProductRichTextInfo extends StatelessWidget {
  final String title;
  final String data;
  final AlignmentGeometry? alignment;

  const ProductRichTextInfo({
    super.key,
    required this.title,
    required this.data,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: alignment ?? Alignment.bottomLeft,
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
    );
  }
}
