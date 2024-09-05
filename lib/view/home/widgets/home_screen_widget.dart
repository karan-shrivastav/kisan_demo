import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/home/widgets/circle_insided_column_widget.dart';
import 'package:ekisan_credit/view/home/widgets/home_card_widget.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_preview_screen.dart';
import 'package:ekisan_credit/view/loan_type/screen/loan_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../edit_profile/screens/edit_personal_information_first_screen.dart';
import '../../profile/screens/profile_bottom_sheet.dart';
import '../../profile/screens/profile_screen.dart';
import '../../viewProfile/screens/view_personal_information_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreenWidget extends StatefulWidget {
  static const routeName = "home-screen-widget";

  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  bool isFinish = false;

  // Create a GlobalKey
  double dragPercentage = 0.0;
  final GlobalKey _swipeKey = GlobalKey();
  double? containerWidth;
  int isNavigate = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final lovsTypeData = [
      "AREAUNIT",
      "OWNERSHIP",
      "LANDTYPE",
      "SOURCEIRRIGATIONNAME",
      "GENDER",
      "NAMINGTITLE",
      "IDPROOF",
      "RELIGIONNAME",
      "CASTE",
      "OCCUPATION",
      "CROPPINGDETAIL"
    ];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_swipeKey.currentContext != null) {
        final RenderBox renderBox =
            _swipeKey.currentContext!.findRenderObject() as RenderBox;
        containerWidth =
            renderBox.size.width; // Get the container width after rendering
      }
    });
  }

// Represents how far the swipe has gone

  @override
  Widget build(BuildContext context) {
    final farmerDetails = context.watch<GetFarmerBloc>().getFarmerResponseModel;
    final getFarmerFamilyDetailsBloc = context
        .watch<GetFarmerFamilyDetailBloc>()
        .getFarmerFamilyDetailResponseModel;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 59,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 AppTextWidget(
                  text: AppLocalizations.of(context)!.ekisanCredit,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.greenColor,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const ProfileBottomSheet();
                      },
                    );
                  },
                  child: const Icon(
                    Icons.account_circle_outlined,
                    size: 20,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.expansionTileColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                           Row(
                            children: [
                              AppTextWidget(
                                text: AppLocalizations.of(context)!.profile,
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          HomeCardWidget(
                            title:  AppLocalizations.of(context)!.personalInformation,
                            leadingIcon: Icons.person,
                            trailingIcon: farmerDetails.data != null
                                ? Icons.check
                                : Icons.error,
                            color: farmerDetails.data != null
                                ? AppColors.backGroundGreenColor
                                : AppColors.backGroundColor,
                            circleBackgroundColor: farmerDetails.data != null
                                ? AppColors.circleAvatarGreenColor
                                : AppColors.circleAvatarGreyColor,
                          ),
                          const CircleInsideColumnWidget(),
                          const SizedBox(
                            height: 16,
                          ),
                          HomeCardWidget(
                            title: AppLocalizations.of(context)!.addressInformation,
                            leadingIcon: Icons.home,
                            trailingIcon: farmerDetails.data != null &&
                                    farmerDetails.data?.addressDtos != null &&
                                    farmerDetails.data!.addressDtos!.isNotEmpty
                                ? Icons.check
                                : Icons.error,
                            color: farmerDetails.data != null &&
                                    farmerDetails.data?.addressDtos != null &&
                                    farmerDetails.data!.addressDtos!.isNotEmpty
                                ? AppColors.backGroundGreenColor
                                : AppColors.backGroundColor,
                            circleBackgroundColor: farmerDetails.data != null &&
                                    farmerDetails.data?.addressDtos != null &&
                                    farmerDetails.data!.addressDtos!.isNotEmpty
                                ? AppColors.circleAvatarGreenColor
                                : AppColors.circleAvatarGreyColor,
                          ),
                          const CircleInsideColumnWidget(),
                          const SizedBox(
                            height: 16,
                          ),
                          HomeCardWidget(
                            title: AppLocalizations.of(context)!.familyInformation,
                            leadingIcon: Icons.group_add,
                            trailingIcon:
                                getFarmerFamilyDetailsBloc.dataList != null &&
                                        getFarmerFamilyDetailsBloc
                                            .dataList!.isNotEmpty
                                    ? Icons.check
                                    : Icons.error,
                            color:
                                getFarmerFamilyDetailsBloc.dataList != null &&
                                        getFarmerFamilyDetailsBloc
                                            .dataList!.isNotEmpty
                                    ? AppColors.backGroundGreenColor
                                    : AppColors.backGroundColor,
                            circleBackgroundColor:
                                getFarmerFamilyDetailsBloc.dataList != null &&
                                        getFarmerFamilyDetailsBloc
                                            .dataList!.isNotEmpty
                                    ? AppColors.circleAvatarGreenColor
                                    : AppColors.circleAvatarGreyColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (
                          getFarmerFamilyDetailsBloc.dataList != null &&
                              getFarmerFamilyDetailsBloc
                                  .dataList!.isNotEmpty)
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ViewPersonalInformationScreen.routeName,
                                );
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(100)),
                                child:  Row(
                                  children: [
                                    const Spacer(),
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.viewProfile,
                                      textColor: AppColors.whiteColor,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )else

                            if (farmerDetails.data == null &&
                                farmerDetails.data?.addressDtos == null
                            )
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ProfileScreen.routeName,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(100)),
                                  child:  Row(
                                    children: [
                                      const Spacer(),
                                      const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.createProfile,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              )else
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    EditPersonalInformationFirstScreen.routeName,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(100)),
                                  child:  Row(
                                    children: [
                                      const Spacer(),
                                      const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.editProfile,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),



                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    getFarmerFamilyDetailsBloc.dataList != null &&
                            getFarmerFamilyDetailsBloc.dataList!.isNotEmpty
                        ? Container(
                            height: 88,
                            key: _swipeKey,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.expansionTileColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (true) {
                                      setState(() {
                                        dragPercentage +=
                                            details.primaryDelta! / 300.00;
                                        dragPercentage =
                                            dragPercentage.clamp(0.0, 1.0);
                                        if (dragPercentage > 0.7) {
                                          isNavigate++;
                                        } else {}
                                      });
                                      if (dragPercentage > 0.7 &&
                                          isNavigate == 1) {
                                        Navigator.pushNamed(
                                            context, LoanTypeScreen.routeName);
                                      }
                                    }
                                  },
                                  onHorizontalDragEnd: (details) {
                                    setState(() {
                                      dragPercentage = 0.0;
                                      isNavigate = 0;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: dragPercentage * (300.00 ?? 0),
                                        // Use the safely obtained width
                                        child: FloatingActionButton(
                                          foregroundColor: AppColors.whiteColor,
                                          backgroundColor: AppColors.primary,
                                          child: const Icon(Icons.keyboard_double_arrow_right,

                                          size: 35,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: AppTextWidget(
                                            text: AppLocalizations.of(context)!.swipeToApplyForLoan,
                                            fontSize: AppTextSize.contentSize20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.yellowBackGroundColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.applyForLoan,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  HomeCardWidget(
                                    title:
                                       AppLocalizations.of(context)!.finishProfileToStartApplyForALoan,
                                    showTrailing: false,
                                    leadingIcon: Icons.error,
                                    color: AppColors.yellowDarkColor,

                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo() {
    // Build your profile info here
    return Container(); // Placeholder
  }
}
