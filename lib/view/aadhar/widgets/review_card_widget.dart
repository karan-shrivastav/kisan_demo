import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';

class ReviewCardWidget extends StatelessWidget {
  final String? firstTitle;
  final String? secondTitle;

  const ReviewCardWidget({
    super.key,
    this.firstTitle,
    this.secondTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: AppTextWidget(
                text: firstTitle ?? '',
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: 1,
          color: AppColors.secondOutLineColor,
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: AppTextWidget(
                text: secondTitle ?? '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
