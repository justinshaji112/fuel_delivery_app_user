import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/models/carousel_model.dart';
import 'package:gap/gap.dart';

class CarouselWidget extends StatefulWidget {
  final List<CarouselModel> carousels;

  const CarouselWidget({
    required this.carousels,
    super.key,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();


  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = widget.carousels.map(
      (e) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(e.image),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ).toList();
    return Column(
      children: [
        CarouselSlider(
          items: carouselItems,
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 170,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const Gap(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselItems.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 20 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: _currentIndex == entry.key
                    ? Colors.black
                    : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}