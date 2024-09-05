import 'package:ekisan_credit/view/login/screen/login_screen.dart';
import 'package:ekisan_credit/view/register/widget/register_section.dart';
import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../login/widget/login_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "register-screen";
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LoginHeader(),
                     const RegisterSection(),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                           AppTextWidget(
                            text: AppLocalizations.of(context)!.alreadyAUser,
                            textColor: AppColors.textColorPrimary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.10,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.popUntil(context, ModalRoute.withName(LoginScreen.routeName));
                            },
                            child:  AppTextWidget(text: AppLocalizations.of(context)!.login,
                              textColor: AppColors.testBrownColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.10,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),


          ],
        ),
      ),
    );
  }
}
