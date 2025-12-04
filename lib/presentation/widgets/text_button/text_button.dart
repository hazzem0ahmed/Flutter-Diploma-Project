import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  const TextButtonWidget({super.key,required this.text,this.fontWeight = FontWeight.w400,});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      //todo
    }, child: Text(text,style: TextStyle(
      fontSize: 14,
      fontWeight: fontWeight,
      color: AppColors.yellow,
    ),));
  }
}
