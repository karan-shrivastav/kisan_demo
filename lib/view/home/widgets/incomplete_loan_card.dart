import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class IncompleteLoanCard extends StatelessWidget {
  final String? badgeText;
  final IconData? badgeIcon;
  final String? headingText;
  final String? descriptionText;
  final String? linkText;
  final bool? isCloseButton;
  final VoidCallback? onClose;
  final VoidCallback? onLinkTap;
  const IncompleteLoanCard({
    super.key,
    this.badgeText,
    this.badgeIcon,
    this.headingText,
    this.descriptionText,
    this.linkText,
    this.isCloseButton = false,
    this.onClose,
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.yellowBackGroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColors.secondOutLineColor, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 8, right: 16),
                  child: Row(
                    children: [
                      Icon(
                        badgeIcon,
                        color: AppColors.iconInsideYellowColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AppTextWidget(
                        text: badgeText ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (isCloseButton == true) const Icon(Icons.close)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const Icon(
              //   Icons.error,
              //   size: 24,
              //   color: AppColors.iconInsideYellowColor,
              // ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: headingText ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    AppTextWidget(
                      text: descriptionText ?? '',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onLinkTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.secondOutLineColor, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AppTextWidget(
                      text: linkText ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
