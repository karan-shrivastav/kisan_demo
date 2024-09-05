import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import '../../../bloc/timer/timer_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'aadhar_successfully_linked_screen.dart';

class AadharOtpScreen extends StatefulWidget {
  static const routeName = '/aadhar-otp-screen';

  const AadharOtpScreen({super.key});

  @override
  State<AadharOtpScreen> createState() => _AadharOtpScreenState();
}

class _AadharOtpScreenState extends State<AadharOtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<String> _isCompleted = ValueNotifier<String>("");

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  AppSharedPreferenceHelper appSharedPreferenceHelper =
      AppSharedPreferenceHelper();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<TimerBloc>().add(const TimerStarted(300));
    super.didChangeDependencies();
  }

  String enteredString = '';
  bool _isNavigationPerformed = false;

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
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 76,
            ),
            Image.asset("assets/images/logos.png"),
            const SizedBox(
              height: 22,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 165,
                    height: 32,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondOutLineColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 9.5,
                        ),
                        SvgPicture.asset('assets/images/user_profile.svg',
                            semanticsLabel: 'A red up arrow'),
                        const SizedBox(
                          width: 9.5,
                        ),
                        const AppTextWidget(
                          text: "909090909090",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /*********** Enter OTP******************/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.enterOtp,
                  fontSize: 20,
                ),
                const Spacer(),
                BlocBuilder<TimerBloc, TimerState>(
                  builder: (BuildContext context, TimerState state) {
                    if (state is TimerRunComplete) {
                      return InkWell(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.resendOtp,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.primary,
                        ),
                      );
                    }
                    return Row(
                      children: [
                        AppTextWidget(
                          text: "${AppLocalizations.of(context)!.resendOtpIn} ",
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                        AppTextWidget(
                          text: formatTime(context
                              .select((TimerBloc bloc) => bloc.state.duration)),
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.primary,
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Pinput(
                  length: 6,
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
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                    setState(() {});

                    _isCompleted.value = value;
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
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isCompleted,
              builder: (BuildContext context, String value, Widget? child) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AAdharSuccessfullyLinkedScreen.routeName,
                          (route) =>
                              false, // Predicate that always returns false to remove all routes
                        );
                      },
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.login,
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
