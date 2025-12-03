import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  ElevatedButtonWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
      //todo
      },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),

          ),
          backgroundColor: AppColors.yellow,
          foregroundColor: AppColors.black,
        ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(text,style: TextStyle(
             fontWeight: FontWeight.w400,
             fontSize: 16,
             color: AppColors.black,
           ),),
         ],
       ));
    }
  }

