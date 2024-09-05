import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/login/widget/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common_button.dart';
import '../widgets/aadhar_section_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'aadhar_otp_screen.dart';

class AadharScreen extends StatefulWidget {
  static String routeName = '/aadhar-screen';

  const AadharScreen({super.key});

  @override
  State<AadharScreen> createState() => _AadharScreenState();
}

class _AadharScreenState extends State<AadharScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.mainPageBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        LoginHeader(),
                        AadharSectionWidget(),
                      ],
                    ),
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AadharOtpScreen.routeName,
                        // arguments: ScreenArguments(
                        //     screenName: AppLocalizations.of(context)!.login,
                        //     mobileNumber: farmerInfoCubit.mobileNumber ?? ''),
                      );
                    },
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
