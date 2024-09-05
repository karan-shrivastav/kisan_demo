import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/custom_progress_bar.dart';
import 'package:flutter/material.dart';

class ProfileProgressHeader extends StatelessWidget {
  final int pageNumber;
  final double percentageFirst;
  final double percentageSecond;
  final double percentageThird;
  const ProfileProgressHeader({super.key, required this.pageNumber, required this.percentageFirst,required this.percentageSecond, required this.percentageThird});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(left: 17, right: 32),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: const Color(0xFFD7E8CD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight:
                      pageNumber > 1 ? const Radius.circular(0) : const Radius.circular(100),
                  bottomRight:
                      pageNumber > 1 ? const Radius.circular(0) : const Radius.circular(100),
                  topLeft: const Radius.circular(100),
                  bottomLeft: const Radius.circular(100),
                )
                    // borderRadius: BorderRadius.circular(22),
                    ),
              ),
              child:  Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: AppColors.textBlackColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageFirst??0.0,
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
                color: pageNumber == 1 ? Colors.transparent : const Color(0xFFD7E8CD),
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
              child:  Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 20,
                    child: Icon(
                      Icons.home,
                      color: AppColors.textBlackColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageSecond??0.0,
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
                    ? const Color(0xFFD7E8CD)
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
              child:  Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.backGroundGreenColor,
                    radius: 20,
                    child: Icon(
                      Icons.group_add,
                      color: AppColors.textBlackColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomProgressBar(
                        max: 100,
                        current: percentageThird??0.0,
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
            padding: const EdgeInsets.only(right: 10),
            decoration: ShapeDecoration(
              color: pageNumber > 3 ? const Color(0xFFD7E8CD) : Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              )),
            ),
            child: const Icon(
              Icons.check,
              size: 24,
            ),
          ),     
        ],
      ),
    );
  }
}
