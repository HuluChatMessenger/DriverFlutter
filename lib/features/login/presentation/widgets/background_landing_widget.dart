import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget backgroundLandingWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: ListView(
      children: [
        CarouselSlider(
          items: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/landing_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/landing_2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/landing_3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            viewportFraction: 1,
          ),
        ),
      ],
    ),
  );
}
