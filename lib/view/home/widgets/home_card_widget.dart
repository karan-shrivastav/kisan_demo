import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';

class HomeCardWidget extends StatelessWidget {
  final String? title;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? color;
  final Color? circleBackgroundColor;
  final bool showTrailing;
  const HomeCardWidget({
    super.key,
    this.color,
    this.leadingIcon,
    this.trailingIcon,
    this.title,
    this.circleBackgroundColor,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            leadingIcon,
            size: 18,
          ),
          const SizedBox(width: 10,),
          Expanded(child: AppTextWidget(text: title??'', fontSize: 14, fontWeight: FontWeight.w500,)),
          showTrailing?CircleAvatar(
            backgroundColor: circleBackgroundColor?? AppColors.circleAvatarGreenColor,
            child: Icon(
              trailingIcon,
              size: 18,
            ),
          ):const SizedBox.shrink(),
        ],
      ),
    );
  }
}
