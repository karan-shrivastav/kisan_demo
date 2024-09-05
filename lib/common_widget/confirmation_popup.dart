import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationPopup extends StatelessWidget {
  final Function? function;
  final String? title;
  final String? description;
  const ConfirmationPopup({
    super.key,
    this.function,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.redAccent,
          ),
          const SizedBox(
            height: 14,
          ),
          AppTextWidget(
            text: title ?? AppLocalizations.of(context)!.areYouSure,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 5,
          ),
          AppTextWidget(
            text: description ??
                AppLocalizations.of(context)!.youWontBeAbleToRevertThis,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textColor: AppColors.iconColor,
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CommonButton(
                    buttonName: AppLocalizations.of(context)!.cancell,
                    buttonColor: AppColors.whiteColor,
                    borderColor: AppColors.secondOutLineColor,
                    buttonTextColor: AppColors.secondOutLineColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (function != null) {
                      function!();
                    }
                  },
                  child: CommonButton(
                    buttonName: AppLocalizations.of(context)!.yes,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
