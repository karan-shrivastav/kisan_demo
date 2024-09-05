import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CircleInsideColumnWidget extends StatelessWidget {
  const CircleInsideColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 12.5,
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.backgroundGreenLightColor,
          child: CircleAvatar(
            radius: 3,
            backgroundColor: AppColors.textBlackColor,
          ),
        ),
        SizedBox(
          height: 3.5,
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.backgroundGreenLightColor,
          child: CircleAvatar(
            radius: 3,
            backgroundColor: AppColors.textBlackColor,
          ),
        ),
        SizedBox(
          height: 3.5,
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.backgroundGreenLightColor,
          child: CircleAvatar(
            radius: 3,
            backgroundColor: AppColors.textBlackColor,
          ),
        ),    
      ],
    );
  }
}
