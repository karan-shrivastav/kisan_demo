import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'aadhar_review_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AAdharSuccessfullyLinkedScreen extends StatelessWidget {
  static const routeName = "/aadhar-successfully-linked";
  const AAdharSuccessfullyLinkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.backGroundColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 160,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AadharReviewScreen.routeName);
                                },
                                child: Image.asset(
                                    "assets/images/eKiasn_logo.png")))
                      ],
                    ),
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.linkAadhaar,
                      fontWeight: FontWeight.w600,
                      fontSize: AppTextSize.header,
                    ),
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.forAllFinancialNeeds,
                      fontWeight: FontWeight.w500,
                      fontSize: AppTextSize.contentSize14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 40),
                      child: AppTextWidget(
                        text: AppLocalizations.of(context)!
                            .yourAadhaarIsSuccessfullyLinkedPleaseVerifyYourDetails,
                        fontSize: AppTextSize.header,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.greenColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
