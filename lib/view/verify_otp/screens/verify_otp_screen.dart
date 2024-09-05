import 'package:ekisan_credit/bloc/check_side_bar/check_side_bar_bloc.dart';
import 'package:ekisan_credit/bloc/check_side_bar/check_side_bar_event.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_bloc.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_event.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_state.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_state.dart';
import 'package:ekisan_credit/bloc/register_farmer/register_farmer_bloc.dart';
import 'package:ekisan_credit/bloc/register_farmer/register_farmer_event.dart';
import 'package:ekisan_credit/bloc/register_farmer/register_farmer_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:ekisan_credit/view/home/screens/home_screen.dart';
import 'package:ekisan_credit/view/home/widgets/home_screen_widget.dart';
import 'package:ekisan_credit/view/verify_otp/widget/successfully_registered_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import '../../../bloc/check_side_bar/check_side_bar_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/otp/send_otp_bloc.dart';
import '../../../bloc/otp/send_otp_event.dart';
import '../../../bloc/timer/timer_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_text_size.dart';
import '../../../utils/screen_argument.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../set_up_mpin/screens/set_mpin_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  static const routeName = '/verify-otp';

  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
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
  void initState() {
    super.initState();
    appSharedPreferenceHelper.clearCustomerData("token");
    appSharedPreferenceHelper.clearCustomerData("userId");
    appSharedPreferenceHelper.clearCustomerData("refreshToken");
    appSharedPreferenceHelper.clearCustomerData("farmerId");
    appSharedPreferenceHelper.clearCustomerData("farmerMobileNumber");
    context.read<GetFarmerFamilyDetailBloc>().add(ClearGetFamilyDetails());
    context.read<GetFarmerBloc>().add(ResetFarmerDetails());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!_isNavigationPerformed) {
        context.read<GetFarmerBloc>().stream.listen((event) {
          if (event is GetFarmerSuccess) {
          if(mounted){
            context.read<CheckSideBarBloc>().add(GetSidebar());
          }
            if (mounted) {
              context.read<CheckSideBarBloc>().stream.listen((state) {
                if (state is CheckSideBarSuccess) {
                 if(mounted){
                   context
                       .read<GetFarmerFamilyDetailBloc>()
                       .add(GetFarmerFamilyDetails());
                 }
                  // context
                  //     .read<GetFarmerFamilyDetailBloc>().stream.listen((event) {
                  //
                  // });
                  // if (state.checkSideBarResponseModel.data!.viewLoan == true) {
                  //   Navigator.pushReplacementNamed(
                  //     context,
                  //     HomeScreen.routeName,
                  //   );
                  // } else {
                  //   Navigator.pushReplacementNamed(
                  //     context,
                  //     HomeScreenWidget.routeName,
                  //   );
                  //
                  //   // if (farmerState is GetFarmerSuccess) {
                  //   //   context
                  //   //       .read<GetFarmerFamilyDetailBloc>()
                  //   //       .add(GetFarmerFamilyDetails());
                  //   //   final loginVerify = context.read<SendOtpBloc>();
                  //   //
                  //   //   if (loginVerify
                  //   //               .loginVerifyOtpResponseModel.data?.farmerRegistered ==
                  //   //           true &&
                  //   //       farmerState.getFarmerDetails.data != null) {
                  //   //     Navigator.pushReplacementNamed(
                  //   //       context,
                  //   //       HomeScreenWidget.routeName,
                  //   //     );
                  //   //   } else if (loginVerify
                  //   //               .loginVerifyOtpResponseModel.data?.farmerRegistered ==
                  //   //           false &&
                  //   //       farmerState.getFarmerDetails.data != null) {
                  //   //     Navigator.pushReplacementNamed(
                  //   //       context,
                  //   //       HomeScreenWidget.routeName,
                  //   //     );
                  //   //   } else if (loginVerify
                  //   //               .loginVerifyOtpResponseModel.data?.farmerRegistered ==
                  //   //           false &&
                  //   //       farmerState.getFarmerDetails.data == null) {
                  //   //     Navigator.pushReplacementNamed(
                  //   //       context,
                  //   //       HomeScreenWidget.routeName,
                  //   //     );
                  //   //   }
                  //   //   _isNavigationPerformed = true;
                  //   // }
                  // }


                if(mounted){
                  Navigator.pushNamed(context, SetMPinScreen.routeNAme);
                }
                } else {

                }
              });
            }
          }
        });

        _isNavigationPerformed = true;
      }
    });
  }

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
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
            AppTextWidget(
              text: args.screenName == "Register"
                  ? AppLocalizations.of(context)!.register
                  : AppLocalizations.of(context)!.login,
              fontSize: AppTextSize.header,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 159,
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
                        text: "+91",
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      AppTextWidget(
                        text: args.mobileNumber ?? '',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: AppTextWidget(
                    text: AppLocalizations.of(context)!.editNumber,
                    textColor: AppColors.outLineColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,

                  ),
                )
              ],
            ),
            /*********** Enter OTP******************/
            SizedBox(
              height: 40,
            ),
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
                        onTap: () {
                          if (args.screenName == "Register") {
                            final bodyRequest = {
                              "authType": "CREATE_FARMER",
                              "otpType": "mobile",
                              "mobileNo": args.mobileNumber
                            };
                            context
                                .read<SendOtpBloc>()
                                .add(GetNewOtp(bodyRequest: bodyRequest));
                            context
                                .read<TimerBloc>()
                                .add(const TimerStarted(300));
                          } else {
                            final bodyRequest = {
                              "authType": "AUTHENTICATE",
                              "otpType": "mobile",
                              "mobileNo": args.mobileNumber
                            };
                            context
                                .read<SendOtpBloc>()
                                .add(GetNewOtp(bodyRequest: bodyRequest));
                            context
                                .read<TimerBloc>()
                                .add(const TimerStarted(300));
                          }
                        },
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
                    // debugPrint('onChanged: $value');
                    // setState(() {
                    //
                    // });

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
                  // errorPinTheme: defaultPinTheme.copyBorderWith(
                  //   border: Border.all(color: Colors.redAccent),
                  // ),
                ),
              ),
            ),
            if (args.screenName == "Register")
              ValueListenableBuilder(
                valueListenable: _isCompleted,
                builder: (BuildContext context, String value, Widget? child) {
                  return Column(
                    children: [
                      _isCompleted.value.length > 5
                          ? BlocConsumer<RegisterFarmerBloc,
                              RegisterFarmerState>(
                              builder: (BuildContext context,
                                  RegisterFarmerState state) {
                                if (state is RegisterFarmerLoading) {
                                  return  CommonButton(
                                    buttonName: AppLocalizations.of(context)!.loading,
                                    buttonColor: AppColors.grayColor,
                                  );
                                }

                                return InkWell(
                                  onTap: () {
                                    final bodyRequest = {
                                      "mobileNo": args.mobileNumber,
                                      "otp": _isCompleted.value
                                    };
                                    context.read<RegisterFarmerBloc>().add(
                                        RegisterFarmer(
                                            bodyRequest: bodyRequest));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: AppColors.greenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Center(
                                      child: AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.verifyOTP,
                                        textColor: AppColors.whiteColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              listener: (BuildContext context,
                                  RegisterFarmerState state) {
                                if (state is RegisterFarmerSuccess) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SuccessfullyRegisteredScreen.routeName,
                                  );

                                  //
                                  // Navigator.pushNamed(context,
                                  //     SuccessfullyRegisteredScreen.routeName);
                                }
                              },
                            )
                          : CommonButton(
                              buttonName: AppLocalizations.of(context)!.verifyOTP,
                              buttonColor: AppColors.grayColor,
                            )
                    ],
                  );
                },
              )
            else
              ValueListenableBuilder(
                valueListenable: _isCompleted,
                builder: (BuildContext context, String value, Widget? child) {
                  return BlocConsumer<SendOtpBloc, SendOtpState>(
                    builder: (BuildContext context, SendOtpState state) {
                      if (state is LoginVerifyOtpLoading) {
                        return  CommonButton(
                          buttonName:AppLocalizations.of(context)!.loading,
                          buttonColor: AppColors.grayColor,
                        );
                      }

                      return _isCompleted.value.length > 5
                          ? InkWell(
                              onTap: () {
                                final bodyRequest = {
                                  "authType": "AUTHENTICATE",
                                  "otpType": "mobile",
                                  "mobileNo": args.mobileNumber,
                                  "otp": _isCompleted.value
                                };
                                context.read<SendOtpBloc>().add(
                                    LoginVerifyOtp(bodyRequest: bodyRequest));
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
                                    text: AppLocalizations.of(context)!.verifyOTP,
                                    textColor: AppColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : CommonButton(
                              buttonName: AppLocalizations.of(context)!.verifyOTP,
                              buttonColor: AppColors.grayColor,
                            );
                    },
                    listener: (BuildContext context, SendOtpState state) {
                      if (state is LoginVerifyOtpSuccess) {
                        AppSharedPreferenceHelper().saveCustomerData(
                            "farmerMobileNumber",
                            state.loginVerifyOtpResponseModel.data?.userName);

                        if (mounted) {
                          context
                              .read<GetFarmerBloc>()
                              .add(GetFarmerDetails(body: const {}));
                        }
                      }
                    },
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
