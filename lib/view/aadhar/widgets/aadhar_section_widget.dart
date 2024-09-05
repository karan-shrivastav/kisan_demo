import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/cubit/login/farmer_login_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/generate_captcha.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AadharSectionWidget extends StatefulWidget {
  const AadharSectionWidget({super.key});

  @override
  State<AadharSectionWidget> createState() => _AadharSectionWidgetState();
}

class _AadharSectionWidgetState extends State<AadharSectionWidget> {
  late final TextEditingController myController;
  late String fieldName;
  late final IconData myIcon;
  late Color prefixIconColor;
  final _aadharNumberController = TextEditingController();
  final _captchaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  AppSharedPreferenceHelper appSharedPreferenceHelper =
      AppSharedPreferenceHelper();

  @override
  void dispose() {
    _aadharNumberController.dispose();
    _captchaController.dispose();
    super.dispose();
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
          text: AppLocalizations.of(context)!.linkAadhaar,
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
                labelText: AppLocalizations.of(context)!.aadharNumber,
                vertical: 15,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    AppFormValidation.validateAadhar(context, value),
                suffix: const Icon(Icons.dialpad_sharp),
                length: 12,
                onChange: (value) {},
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: InkWell(
                      onTap: () {
                        _captchaValue.value =
                            GenerateCaptcha.generateRandomString();
                      },
                      child: const Icon(Icons.refresh_outlined)),
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
      ],
    );
  }
}
