import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/mPin_screen_argument.dart';
import 'package:ekisan_credit/view/set_up_mpin/screens/confirm_m_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetMPinScreen extends StatelessWidget {
  static const routeNAme = "set-m-pin";

  const SetMPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          // If there's navigation history, pop the view
          Navigator.of(context).pop();
          return false;  // Indicate that we handled the back press
        } else {
          // If no navigation history, show a confirmation dialog
          return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Do you really want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ?? false;  // Default to not exiting if null response from dialog
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.mainPageBackgroundColor,
        body: SafeArea(
          child: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarColor: AppColors.mainPageBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 59,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(45)),
                          child: const Center(
                              child: Icon(
                            Icons.question_mark_outlined,
                            size: 18,
                          ))),
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
                      text: AppLocalizations.of(context)!.enterDigitMpin,
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
          ),
        ),
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

  final ValueNotifier<String> newMPin = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.secondOutLineColor;
    const fillColor = Colors.transparent;
    const borderColor = AppColors.secondOutLineColor;
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
                      return '';
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
                      newMPin.value = value;
                      // debugPrint('onChanged: $value');
                      // setState(() {
                      //
                      // });
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
            valueListenable: newMPin,
            builder: (BuildContext context, String value, Widget? child) {
              return newMPin.value.length > 3
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ConfirmMPinScreen.routeName,
                        arguments: MPinScreenArgument(newMPin: value)
                        );
                      },
                      child: CommonButton(
                          buttonName: AppLocalizations.of(context)!.next))
                  : CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                      buttonColor: AppColors.grayColor,
                    );
            },
          ),
        )
      ],
    );
  }
}
