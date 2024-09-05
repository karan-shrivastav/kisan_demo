import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';

class ProfileBottomsheetRowWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? color;
  final Function? onTap;
  const ProfileBottomsheetRowWidget(
      {super.key, this.title, this.icon, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap==null?{

        }:onTap!();
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: color ?? AppColors.mainPageBackgroundColor),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 12,
            ),
            AppTextWidget(
              text: '$title',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
