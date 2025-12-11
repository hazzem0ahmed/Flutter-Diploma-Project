import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';


class OnBoardingTemp extends StatelessWidget {
  final String image;
  final String title;
  final String? subtitle;

  const OnBoardingTemp({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.85,
            child:Stack(children: [
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),

            ],),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),

                  if (subtitle != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
