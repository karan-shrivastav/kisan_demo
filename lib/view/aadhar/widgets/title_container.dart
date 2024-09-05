import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';

class TitleContainer extends StatelessWidget {
  final String? title;
  const TitleContainer({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: AppTextWidget(
          text: title ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
