import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_extensions.dart';

class MovieDetailsDesign extends StatelessWidget {
  IconData icon;
  String text;

  MovieDetailsDesign(this.text, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.withPadding(8),
      width: context.spaceWidth * 0.3,
      height: context.spaceHeight * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF282A28),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, color: AppColors.yellow, size: 50),
          Text(
            text,
            style: context.text.bodyMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
