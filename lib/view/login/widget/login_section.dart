import 'package:ekisan_credit/bloc/family/get_family_detail/get_farmer_family_event.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/cubit/login/farmer_login_cubit.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/generate_captcha.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:ekisan_credit/view/register/screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  late final TextEditingController myController;
  late String fieldName;
  late final IconData myIcon;
  late Color prefixIconColor;
  final _mobileNumberController = TextEditingController();
  final _captchaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  AppSharedPreferenceHelper appSharedPreferenceHelper =
      AppSharedPreferenceHelper();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    appSharedPreferenceHelper.clearCustomerData("token");
    appSharedPreferenceHelper.clearCustomerData("userId");
    appSharedPreferenceHelper.clearCustomerData("refreshToken");
    appSharedPreferenceHelper.clearCustomerData("farmerId");
    appSharedPreferenceHelper.clearCustomerData("farmerMobileNumber");
    context.read<GetFarmerFamilyDetailBloc>().add(ClearGetFamilyDetails());
    super.didChangeDependencies();
  }

  final ValueNotifier<String> _captchaValue =
      ValueNotifier<String>(GenerateCaptcha.generateRandomString());

  @override
  Widget build(BuildContext context) {
    final farmerInfoCubit = context.read<FarmerInfoCubit>();
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        AppTextWidget(
          text: AppLocalizations.of(context)!.login,
          fontSize: AppTextSize.header,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                labelText: AppLocalizations.of(context)!.mobileNumber,
                vertical: 15,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    AppFormValidation.validateMobile(context, value),
                suffixIcon: Icons.dialpad_sharp,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                length: 10,
                onChange: (value) {
                  farmerInfoCubit.updateModel(mobileNumber: value);
                },
                prefix: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: AppTextWidget(
                    text: "+91",
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.textBlackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ValueListenableBuilder(
          valueListenable: _captchaValue,
          builder: (BuildContext context, String value, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xFFD7E8CD),
                    height: 55,
                    child: Center(
                      child: AppTextWidget(
                        text: _captchaValue.value,
                        fontWeight: FontWeight.bold,
                        fontSize: 29,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                        onTap: () {
                          _captchaValue.value =
                              GenerateCaptcha.generateRandomString();
                        },
                        child: const Icon(Icons.refresh_outlined)),
                  ),
                ),
                Expanded(
                  child: CommonTextField(
                    controller: _captchaController,
                    validator: (enteredCaptcha) =>
                        AppFormValidation.validateCaptcha(
                            captchaValue: _captchaValue.value,
                            enteredCaptcha: enteredCaptcha,
                            context: context),
                    onChange: (value) {
                      farmerInfoCubit.updateModel(captcha: value);
                    },
                    labelText: AppLocalizations.of(context)!.enterCaptcha,
                    vertical: 16,
                    horizontal: 16,
                  ),
                )
              ],
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            AppTextWidget(
              text: AppLocalizations.of(context)!.newUser,
              textColor: AppColors.textBlackColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.10,
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              child: AppTextWidget(
                text: AppLocalizations.of(context)!.register,
                textColor: AppColors.outLineColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
              ),
            )
          ],
        ),
      ],
    );
  }
}
