import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/app_extensions.dart';

import 'data.dart';

class AvatarCarouselSlider extends StatelessWidget {
  const AvatarCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: context.spaceHeight * 0.2,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
      ),
      items: List.generate(AvatarData.avatarList.length, (index) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                //todo
              },
              child: CircleAvatar(
                radius: context.spaceHeight * 0.1,
                backgroundImage: AssetImage(AvatarData.avatarList[index].imagePath),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
