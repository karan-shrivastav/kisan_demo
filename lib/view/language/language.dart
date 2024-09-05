import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../cubit/shared_pareference_value/shared_preference_cubit.dart';
import '../../utils/screen_argument.dart';
import '../../utils/shared_preference_helper.dart';
import '../../language/language_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_size.dart';
import '../../common_widget/app_text_widget.dart';
import '../login/screen/login_screen.dart';

class LanguageScreen extends StatelessWidget {
  static const routeName = "language-screen";

  const LanguageScreen({super.key});

  Future<void> handleLanguageChange(BuildContext context, Locale locale) async {
    final appSharedPreferenceHelper = AppSharedPreferenceHelper();
    final appSharedPreferenceHelperCubit =
        context.read<AppSharedPreferenceHelperCubit>();

    // Fetch all needed shared preferences in parallel
    final results = await Future.wait([
      appSharedPreferenceHelper.getCustomerData("farmerId"),
      appSharedPreferenceHelper.getCustomerData("token"),
      appSharedPreferenceHelper.getCustomerData("userId"),
      appSharedPreferenceHelper.getCustomerData("incompleteLoanId"),
    ]);

    final getFarmerId = results[0];
    final token = results[1];
    final userId = results[2];
    final incompleteLoanId = results[3];

    if (getFarmerId != null) {
      appSharedPreferenceHelperCubit.updateModel(
        farmerId: getFarmerId,
        token: token,
        userId: userId,
        incompleteLoanId: incompleteLoanId,
      );

      // Change the language
      context.read<LanguageBloc>().add(LanguageEvent(locale));

      // Wait for a short duration to ensure language change is processed
      await Future.delayed(const Duration(milliseconds: 500));

      // Save updated values back to shared preferences
      await Future.wait([
        appSharedPreferenceHelper.saveCustomerData(
            "farmerId", appSharedPreferenceHelperCubit.state.farmerId),
        appSharedPreferenceHelper.saveCustomerData(
            "token", appSharedPreferenceHelperCubit.state.token),
        appSharedPreferenceHelper.saveCustomerData(
            "userId", appSharedPreferenceHelperCubit.state.userId),
        appSharedPreferenceHelper.saveCustomerData("incompleteLoanId",
            appSharedPreferenceHelperCubit.state.incompleteLoanId),
      ]);
    } else {
      context.read<LanguageBloc>().add(LanguageEvent(locale));
    }
  }

  Expanded buildLanguageSelectionTile({
    required BuildContext context,
    required String assetPath,
    required String language,
    required Locale locale,
    required String arg,
  }) {
    return Expanded(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              handleLanguageChange(context, locale);

              if (arg == "Dashboard") {
                Navigator.pushNamed(context, LoginScreen.routeName);
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              height: 178,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xFF73796E)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(assetPath),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: AppTextWidget(
              text: language,
              textColor: AppColors.primary,
              fontSize: AppTextSize.contentSize16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ScreenArgumentsLanguage;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 56),
            const Center(
              child: AppTextWidget(
                text: "Select Language",
                fontSize: 36,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: const Color(0xFFE1E4DA),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for Your Language",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/hindi.svg",
                            language: 'Hindi',
                            locale: const Locale('hi', 'IN'),
                            arg: args.screenName),
                        const SizedBox(width: 20),
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/english.svg",
                            language: 'English',
                            locale: const Locale('en', 'US'),
                            arg: args.screenName),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/bangali.svg",
                            language: 'Bangali',
                            locale: const Locale('bn', 'IN'),
                            arg: args.screenName),
                        const SizedBox(width: 20),
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/maliyalam.svg",
                            language: 'Maliyali',
                            locale: const Locale('ml', 'IN'),
                            arg: args.screenName),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/telugu.svg",
                            language: 'Telugu',
                            locale: const Locale('te', 'IN'),
                            arg: args.screenName),
                        const SizedBox(width: 20),
                        buildLanguageSelectionTile(
                            context: context,
                            assetPath: "assets/images/kannada.svg",
                            language: 'Kannada',
                            locale: const Locale('kn', 'IN'),
                            arg: args.screenName),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
