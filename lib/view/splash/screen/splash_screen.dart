import 'package:ekisan_credit/view/onboarding/screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';  // Import dart:io at the beginning of your file

import '../../../Utils/shared_preference_helper.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../aadhar/screens/adhar_screen.dart';
import '../../login/screen/login_screen.dart';
import '../../set_up_mpin/screens/set_mpin_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../use_mPin/screens/use_mPin.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String?> loadData() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper = AppSharedPreferenceHelper();
    String? token = await appSharedPreferenceHelper.getCustomerData('token');
    String? mPin = await appSharedPreferenceHelper.getCustomerData('mPin');

    if (token != null && mPin != null) {
      return 'both'; // Both token and mPin are present
    } else if (token != null) {
      return 'token'; // Only token is present
    } else if (mPin != null) {
      return 'mPin'; // Only mPin is present
    }
    return null; // Neither token nor mPin is present
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the application?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (dii) async {

      },
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder<String?>(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {

                if (snapshot.hasData) {
                  String data = snapshot.data!;
                  if (data == 'both') {
                    // Both token and mPin are available
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
                    // });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacementNamed(context, UseMPinScreen.routeName);
                    });

                  } else {
                    // Navigate to onboarding because one or both are missing
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
                    // });

                    return const OnBoardingScreen();
                  }
                } else {
                  // No data available, navigate to onboarding
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
                  // });

                  return const OnBoardingScreen();
                }
              }
              return  const CircularProgressIndicator();
            },
          ),
      
      
      
        ),
      ),
    );
  }
}
