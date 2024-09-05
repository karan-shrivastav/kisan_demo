import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessfullyRegisteredScreen extends StatelessWidget {
  static const routeName = "/successfully-registered";

  const SuccessfullyRegisteredScreen({super.key});

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
              SizedBox(
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
                            child: Image.asset("assets/images/eKiasn_logo.png"))
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
                              text: AppLocalizations.of(context)!.welcome,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (route) =>
                                false, // Predicate that always returns false to remove all routes
                          );
                          // Navigator.pushNamed(context, SetMPinScreen.routeNAme);
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
                              text: AppLocalizations.of(context)!.loginCaps,
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
        ),
      ),
    );
  }
}
