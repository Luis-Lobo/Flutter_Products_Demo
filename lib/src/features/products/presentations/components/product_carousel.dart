import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarousel extends StatelessWidget {
  final CarouselSliderController controller;
  final List<String> imagesUrls;

  const ProductCarousel({
    required this.controller, 
    required this.imagesUrls, 
    super.key});

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
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              // Handle indicator updates if needed (optional)
            },
          ),
        ),
       /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
          //    onPressed: () => controller.previousPage(),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => controller.nextPage(),
            ),
          ],
        ), */
      ],
    );
  }
}
