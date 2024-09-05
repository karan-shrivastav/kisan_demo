
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_size.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  const AppTextWidget(
      {super.key,
        required this.text,
        this.textAlign = TextAlign.start,
        this.textColor = AppColors.textBlackColor,
        this.fontSize = AppTextSize.contentSize14,
        this.letterSpacing = 0.0,
        this.overflow,
        this.fontWeight = FontWeight.normal,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,

      ),
    );
  }
}