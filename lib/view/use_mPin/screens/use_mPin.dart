import 'dart:convert';

import 'package:ekisan_credit/view/profile/screens/profile_screen.dart';
import 'package:ekisan_credit/view/splash/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';
import '../../../Utils/shared_preference_helper.dart';
import '../../../bloc/check_side_bar/check_side_bar_bloc.dart';
import '../../../bloc/check_side_bar/check_side_bar_event.dart';
import '../../../bloc/check_side_bar/check_side_bar_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/get_farmer/get_farmer_state.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../home/screens/home_screen.dart';
import '../../home/widgets/home_screen_widget.dart';
import '../../login/widget/login_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UseMPinScreen extends StatelessWidget {
  static String routeName = "use-mPin";

  const UseMPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.mainPageBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Column(
            children: [
              const LoginHeader(),
              Stack(
                children: [
                  Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(45)),
                            child: const Center(
                                child: Icon(
                                  Icons.question_mark_outlined,
                                  size: 18,
                                ))),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextWidget(
                        text: AppLocalizations.of(context)!.enterMpin,
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSize.header,
                      )
                    ],
                  ),
                ],
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



  final ValueNotifier<String> mPin = ValueNotifier<String>("");

  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    String? token = await appSharedPreferenceHelper.getCustomerData('token');
    String? mPin = await appSharedPreferenceHelper.getCustomerData('mPin');

    if (token != null && mPin != null) {
      String jsonData = '{"token": "$token", "mPin": "$mPin"}';

      return jsonData; // Both token and mPin are present
    }
    return null; // Neither token nor mPin is present
  }
  final ValueNotifier<String> mPinValue = ValueNotifier<String>("");

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      if (kDebugMode) {
        print(e);
      }
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      // setState(() {
      //   _isAuthenticating = true;
      //   _authorized = 'Authenticating';
      // });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      // setState(() {
      //   _isAuthenticating = false;
      // });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // setState(() {
      //   _isAuthenticating = false;
      //   _authorized = 'Error - ${e.message}';
      // });
      if (kDebugMode) {
        print(authenticated ? 'True' : 'False');
      } // Add this line to print the result

      return;
    }


    if (!mounted) {
      return;
    }

    // print("00000000iiii000000");
    // print(authenticated);
    if(authenticated){
      WidgetsBinding.instance
          .addPostFrameCallback((_) {
        context.read<GetFarmerBloc>().add(
            GetFarmerDetails(body: const {}));
      });
    }

    // setState(
    //         () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');

  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();

    setState(() => _isAuthenticating = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GetFarmerBloc>().stream.listen((event) {
        if (event is GetFarmerSuccess) {
          if (mounted) {
            context.read<CheckSideBarBloc>().add(GetSidebar());
            context.read<CheckSideBarBloc>().stream.listen((state) {
              if (state is CheckSideBarSuccess) {
                if (mounted) {
                  context
                      .read<GetFarmerFamilyDetailBloc>()
                      .add(GetFarmerFamilyDetails());
                }
                // context
                //     .read<GetFarmerFamilyDetailBloc>().stream.listen((event) {
                //
                // });
                if (state.checkSideBarResponseModel.data!.viewLoan == true) {
                  // Navigator.pushNamedAndRemoveUntil(context,  HomeScreen.routeName, (r) => false);

                  Navigator.pushReplacementNamed(
                    context,
                    HomeScreen.routeName,
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(context,  HomeScreenWidget.routeName, (r) => false);

                }
              }
            });
          }

        }
      });
    });
    super.initState();
  }

  bool isHideText = true;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
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
    return Column(
      children: [
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: mPinValue,
              builder: (BuildContext context, String valueMPin, Widget? child) {
                return Row(
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
                          return value != mPinValue.value ? 'Pin is incorrect' : null;
                        },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },

                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {

                          // Navigator.pushNamed(context, DashboardScreen.routeName);
                          debugPrint('onCompletoooed: $pin');
                          debugPrint('onCompletedMPIN VAL: ${mPinValue.value}');
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return FutureBuilder<String?>(
                                future: loadData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      final data = snapshot.data;

                                      Map<String, dynamic> jsonData =
                                      jsonDecode(data!);
                                      String mPinData = jsonData['mPin'];

                                      if(mounted){
                                        Future.delayed(const Duration(seconds: 1),(){

                                          mPinValue.value = jsonData['mPin'];
                                        });
                                      }

                                      if (mPinData == pin) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.read<GetFarmerBloc>().add(
                                              GetFarmerDetails(body: const {}));
                                        });
                                      } else {

                                        print("00000000000000009876");
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      // No data available, navigate to onboarding
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.pushReplacementNamed(
                                            context, SplashScreen.routeName);
                                      });
                                    }
                                  }
                                  return AlertDialog(
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 14,
                                        ),
                                        CircularProgressIndicator(),
                                        SizedBox(
                                          height: 14,
                                        ),

                                      ],
                                    ),
                                    backgroundColor: AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  );
                                },
                              );

                            },
                          );
                        },
                        onChanged: (value) {
                          mPin.value = value;
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
                );
              },

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              AppTextWidget(
                text: AppLocalizations.of(context)!.forgetMpin,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                width: 4,
              ),
              AppTextWidget(
                text: AppLocalizations.of(context)!.reset,
                fontWeight: FontWeight.w500,
                textColor: AppColors.testBrownColor,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder(
            valueListenable: mPin,
            builder: (BuildContext context, String value, Widget? child) {
              if (value.length > 3) {
                return InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder<String?>(
                            future: loadData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data;

                                  Map<String, dynamic> jsonData =
                                  jsonDecode(data!);
                                  String mPinData = jsonData['mPin'];
                                  mPinValue.value = mPinData;
                                  if (mPinData == mPin.value) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      context.read<GetFarmerBloc>().add(
                                          GetFarmerDetails(body: const {}));
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  // No data available, navigate to onboarding
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.pushReplacementNamed(
                                        context, SplashScreen.routeName);
                                  });
                                }
                              }
                              return PopScope(
                                  canPop: false,
                                  child: AlertDialog(
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 14,
                                        ),
                                        CircularProgressIndicator(),
                                        SizedBox(
                                          height: 14,
                                        ),

                                      ],
                                    ),
                                    backgroundColor: AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                  ));
                            },
                          );

                        },
                      );
                    },
                    child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.unlock));
              }
              return CommonButton(
                buttonName: AppLocalizations.of(context)!.unlock,
                buttonColor: AppColors.grayColor,
              );
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        if(_supportState == _SupportState.supported)
          InkWell(
            onTap: (){
              _authenticate();
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondOutLineColor),
                borderRadius: BorderRadius.circular(45),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: AppTextWidget(
                  text: AppLocalizations.of(context)!.useSystemPassKey,
                  textColor: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}


enum _SupportState {
  unknown,
  supported,
  unsupported,
}
