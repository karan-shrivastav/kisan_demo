import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/custom_progress_bar.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final int pageNumber;
  final double? percentageFirst;
  final double? percentageSecond;
  final double? percentageThird;
  final double? percentageFourth;
  const HeaderWidget({
    super.key,
    required this.pageNumber,
    this.percentageFirst,
    this.percentageSecond,
    this.percentageThird,
    this.percentageFourth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: AppColors.secondOutLineColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: ShapeDecoration(
                color: AppColors.backgroundGreenLightColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: pageNumber > 1
                      ? const Radius.circular(0)
                      : const Radius.circular(100),
                  bottomRight: pageNumber > 1
                      ? const Radius.circular(0)
                      : const Radius.circular(100),
                  topLeft: const Radius.circular(100),
                  bottomLeft: const Radius.circular(100),
                )),
              ),
              child: Row(
                children: [
                   const CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 16,
                    child: ImageIcon(
                      AssetImage("assets/images/crop.png"),
                      color: AppColors.textBlackColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageFirst ?? 0.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: ShapeDecoration(
                color: pageNumber == 1
                    ? Colors.transparent
                    : AppColors.backgroundGreenLightColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: pageNumber > 2
                      ? const Radius.circular(0)
                      : const Radius.circular(100),
                  bottomRight: pageNumber > 2
                      ? const Radius.circular(0)
                      : const Radius.circular(100),
                )),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 16,
                    child: Icon(
                      Icons.group_add,
                      color: AppColors.textBlackColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageSecond ?? 0.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: ShapeDecoration(
                color: pageNumber > 2
                    ? AppColors.backgroundGreenLightColor
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: pageNumber > 3
                        ? const Radius.circular(0)
                        : const Radius.circular(100),
                    bottomRight: pageNumber > 3
                        ? const Radius.circular(0)
                        : const Radius.circular(100),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 16,
                    child: Icon(
                      Icons.landscape_outlined,
                      color: AppColors.textBlackColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageThird ?? 0.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: ShapeDecoration(
                color: pageNumber > 3
                    ? AppColors.backgroundGreenLightColor
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: pageNumber > 4
                        ? const Radius.circular(0)
                        : const Radius.circular(100),
                    bottomRight: pageNumber > 4
                        ? const Radius.circular(0)
                        : const Radius.circular(100),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 16,
                    child: Icon(
                      Icons.article,
                      color: AppColors.textBlackColor,
                      size: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageFourth ?? 0.0,
                        color: AppColors.greenColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.only(right: 14),

            decoration: ShapeDecoration(
              color:
                  pageNumber > 4 ?  AppColors.backgroundGreenLightColor : Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
            child: const Icon(
              Icons.check,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
