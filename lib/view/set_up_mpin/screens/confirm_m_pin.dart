import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:ekisan_credit/view/set_up_mpin/screens/mpin_craeted_successfully.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/mPin_screen_argument.dart';

class ConfirmMPinScreen extends StatelessWidget {
  static String routeName = 'confirm-m-pin';

  const ConfirmMPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 76,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                    )),
                AppTextWidget(
                  text: AppLocalizations.of(context)!.setupMpin,
                  fontWeight: FontWeight.w400,
                  fontSize: AppTextSize.header,
                ),
                SizedBox(
                  width: 39,
                  height: 37,
                  child: Image.asset("assets/images/eKiasn_logo.png"),
                ),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextWidget(
                text: AppLocalizations.of(context)!.enterTheSameDigit,
                fontWeight: FontWeight.w500,
                textColor: AppColors.textBlackColor,
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const MPinWidget()
        ],
      ),
    );
  }
}

class MPinWidget extends StatefulWidget {
  const MPinWidget({super.key});

  @override
  State<MPinWidget> createState() => _MPinWidgetState();
}

class _MPinWidgetState extends State<MPinWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool isHideText = true;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final ValueNotifier<String> confirmMPin = ValueNotifier<String>("");
  final appSharedPreferenceHelper = AppSharedPreferenceHelper;

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.secondOutLineColor;
    const fillColor = Colors.transparent;
    const borderColor = AppColors.secondOutLineColor;
    final args =
    ModalRoute.of(context)!.settings.arguments as MPinScreenArgument;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: AppTextSize.contentSize16,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
    );
    return Column(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Pinput(
                    length: 4,
                    obscureText: isHideText,
                    controller: pinController,
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      return value == args.newMPin ? null : 'Pin is incorrect';
                    },
                    // onClipboardFound: (value) {
                    //   debugPrint('onClipboardFound: $value');
                    //   pinController.setText(value);
                    // },

                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      // Navigator.pushNamed(context, DashboardScreen.routeName);
                      debugPrint('onCompleted: $pin');
                    },
                    onChanged: (value) {
                      confirmMPin.value = value;
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    // errorPinTheme: defaultPinTheme.copyBorderWith(
                    //   border: Border.all(color: Colors.redAccent),
                    // ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isHideText = !isHideText;
                  });
                },
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: isHideText
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        AppTextWidget(
          text: AppLocalizations.of(context)!.someTextForUsageAboutMPin,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder(
            valueListenable: confirmMPin,
            builder: (BuildContext context, String value, Widget? child) {
              return value == args.newMPin
                  ? InkWell(
                  onTap: () {
                    AppSharedPreferenceHelper appSharedPreferenceHelper =
                    AppSharedPreferenceHelper();

                    appSharedPreferenceHelper.saveCustomerData(
                        "mPin", value);
                    Navigator.pushNamed(
                        context, MPinCreatedSuccessfully.routeName);
                  },
                  child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.generate))
                  : CommonButton(
                  buttonColor: AppColors.grayColor,
                  buttonName: AppLocalizations.of(context)!.generate);
            },
          ),
        )
      ],
    );
  }
}
