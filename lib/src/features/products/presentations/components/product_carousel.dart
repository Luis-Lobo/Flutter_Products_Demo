import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';

class ProductCarousel extends StatelessWidget {
  final CarouselSliderController controller;
  final List<String> imagesUrls;
  final ValueNotifier<int> currentUrl;

  const ProductCarousel({required this.controller, required this.imagesUrls, required this.currentUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imagesUrls.map((path) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(path),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          carouselController: controller,
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              currentUrl.value = index;
            },
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: currentUrl,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagesUrls.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark ? ApplicationColors.grey800 : ApplicationColors.black36)
                          .withOpacity(currentUrl.value == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
