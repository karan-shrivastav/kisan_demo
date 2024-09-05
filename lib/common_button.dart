import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'common_widget/app_text_widget.dart';

class CommonButton extends StatelessWidget {
  final String? buttonName;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final Widget? buttonWidget;
  const CommonButton({
    super.key,
     this.buttonName,
    this.buttonColor,
    this.borderColor,
    this.buttonTextColor,
    this.buttonWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: buttonColor?? AppColors.greenColor,
          borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: borderColor ?? Colors.transparent,
        )
      ),
      child: Center(
        child: buttonWidget??AppTextWidget(
          text: buttonName ?? '',
          textColor: buttonTextColor??AppColors.whiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
