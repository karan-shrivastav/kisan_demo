import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../login/screen/login_screen.dart';
import '../../use_mPin/screens/use_mPin.dart';

class MPinCreatedSuccessfully extends StatelessWidget {
  static String routeName = "m-pin-created-successfully";

  const MPinCreatedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    Center(child: Image.asset("assets/images/eKiasn_logo.png"))
                  ],
                ),
                AppTextWidget(
                  text: AppLocalizations.of(context)!.ekisanCredit,
                  fontWeight: FontWeight.w600,
                  fontSize: AppTextSize.header,
                ),
                AppTextWidget(
                  text: AppLocalizations.of(context)!.forAllFinancialNeeds,
                  fontWeight: FontWeight.w500,
                  fontSize: AppTextSize.contentSize14,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 40),
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!
                                  .mPinGeneratedSuccessfully,
                              fontSize: AppTextSize.header,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.greenColor,
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, LoginScreen.routeName);
                      Navigator.pushNamedAndRemoveUntil(context, UseMPinScreen.routeName, (r) => false);


                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: AppColors.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.next,
                          textColor: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 0, child: Container()),
        ],
      ),
    );
  }
}
