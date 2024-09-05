import 'package:ekisan_credit/bloc/get_farmer/get_farmer_bloc.dart';
import 'package:ekisan_credit/bloc/get_farmer/get_farmer_state.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/main.dart';
import 'package:ekisan_credit/services/toast_alert.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Utils/shared_preference_helper.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../language/language.dart';
import '../../onboarding/screen/onboarding_screen.dart';
import '../../viewProfile/screens/view_personal_information_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/profile_bottomsheet_row_widget.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  AppSharedPreferenceHelper appSharedPreferenceHelper =
      AppSharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.secondOutLineColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 92,
              padding: const EdgeInsets.only(left: 12),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundGreenLightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 85,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.blue,
                            ),
                            Positioned(
                              top: 0,
                              left: 53,
                              child: Icon(
                                Icons.verified,
                                color: AppColors.greenColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      BlocConsumer<GetFarmerBloc, GetFarmerState>(
                        builder: (BuildContext context, GetFarmerState state) {
                          if (state is GetFarmerSuccess) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppTextWidget(
                                  text: state.getFarmerDetails.data?.fullName ??
                                      '',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppTextWidget(
                                  text:
                                      '+91 ${state.getFarmerDetails.data?.mobileNo ?? ''}',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        listener:
                            (BuildContext context, GetFarmerState state) {},
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: AppColors.greyIconColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  ProfileBottomsheetRowWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ViewPersonalInformationScreen.routeName);
                    },
                    icon: Icons.account_circle_outlined,
                    title: AppLocalizations.of(context)!.viewProfile,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProfileBottomsheetRowWidget(
                    onTap: () {
                      Navigator.pushNamed(context, LanguageScreen.routeName);
                    },
                    icon: Icons.g_translate,
                    title: AppLocalizations.of(context)!.changeLanguage,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProfileBottomsheetRowWidget(
                    icon: Icons.developer_board,
                    title: AppLocalizations.of(context)!.howTo,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProfileBottomsheetRowWidget(
                    icon: Icons.settings,
                    title: AppLocalizations.of(context)!.settings,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      appSharedPreferenceHelper.clearCustomerData("token");
                      appSharedPreferenceHelper.clearCustomerData("userId");
                      appSharedPreferenceHelper
                          .clearCustomerData("refreshToken");
                      appSharedPreferenceHelper.clearCustomerData("farmerId");
                      appSharedPreferenceHelper
                          .clearCustomerData("farmerMobileNumber");
                      context
                          .read<GetFarmerFamilyDetailBloc>()
                          .add(ClearGetFamilyDetails());

                      // Navigator.pushReplacementNamed(
                      //     context, SplashScreen.routeName);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const MyApp()),
                        ModalRoute.withName('/'),
                      );
                      // Navigator.pushNamedAndRemoveUntil(context,  SplashScreen.routeName, (r) => false);
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        color: AppColors.redBackgroundColor,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          AppTextWidget(
                            text: AppLocalizations.of(context)!.logOut,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProfileBottomsheetRowWidget(
                    color: Colors.transparent,
                    icon: Icons.help_outline_outlined,
                    title: AppLocalizations.of(context)!.privacyPolicy,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ProfileBottomsheetRowWidget(
                    color: Colors.transparent,
                    icon: Icons.article,
                    title: AppLocalizations.of(context)!.termsOfUse,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            AppTextWidget(
                              text: '+91 9090909090',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: AppTextWidget(
                            text: 'admin@gmail.com',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
