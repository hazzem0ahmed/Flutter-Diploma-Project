import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class FormDesign extends StatefulWidget {
  String hintText;
  IconData prefixIcon;
  TextInputType textType;
  bool obSecureText;

  FormDesign(
    this.hintText,
    this.prefixIcon,
    this.obSecureText,
    this.textType, {
    super.key,
  });

  @override
  State<FormDesign> createState() => _FormDesignState();
}

class _FormDesignState extends State<FormDesign> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obSecureText,
      keyboardType: widget.textType,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),

      decoration: InputDecoration(
        suffixIcon: widget.textType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  widget.obSecureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.obSecureText = !widget.obSecureText;
                  });
                },
              )
            : null,
        prefixIcon: Icon(widget.prefixIcon,color: AppColors.white,),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.grey),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.grey),
        ),
        filled: true,
        fillColor: AppColors.grey.withAlpha(50),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.red),
        ),
      ),
    );
  }
}
