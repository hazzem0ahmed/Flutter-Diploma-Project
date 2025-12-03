import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtonWidget({super.key,required this.text,required this.onPressed});
  ElevatedButtonWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.055,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
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
               fontWeight: FontWeight.w600,
               fontSize: 20,
               color: AppColors.black,
             ),),
           ],
         )),
    );
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

