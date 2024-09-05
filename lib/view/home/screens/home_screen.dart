import 'package:ekisan_credit/bloc/check_ekyc/check_ekyc_bloc.dart';
import 'package:ekisan_credit/bloc/loan_count/loan_count_bloc.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/land/screen/add_land_screen.dart';
import 'package:ekisan_credit/view/land/screen/land_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/check_ekyc/check_ekyc_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_state.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../bloc/loan_count/loan_count_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../loan_apply/screen/crop_loan_form_bank_details.dart';
import '../widgets/joint_applicant_widget.dart';
import '../widgets/loan_screen_widget.dart';
import 'add_joint_applicant_screen.dart';
import 'joint_applicant_adhar_verify screen.dart';
import 'loan_list_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<GetJointApplicantBloc>()
        .add(GetJointApplicantList(body: const {"search": ""}));

    // Only initialize once
    if (!initialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      // Retrieve the passed argument(s), or use default values
      currentPageIndex = args?['currentPageIndex'] ?? 0;
      initialized = true;
    }

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
  }

  @override
  void initState() {
    // TODO: implement initState

    context
        .read<LoanCountBloc>()
        .add(GetLoanCount(bodyRequest: const {"lan": "en"}));
    context.read<CheckEkyCBloc>().add(CheckEkyC());

    // LoanCountBloc
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          // If there's navigation history, pop the view
          Navigator.of(context).pop();
          return false; // Indicate that we handled the back press
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
              ) ??
              false; // Default to not exiting if null response from dialog
        }
      },
      child: BlocConsumer<GetFarmerBloc, GetFarmerState>(
        builder: (BuildContext context, GetFarmerState state) {
          if (state is GetFarmerSuccess) {
            // context
            //     .read<GetJointApplicantBloc>()
            //     .add(GetJointApplicantList(body: const {"search": ""}));
          }
          return Scaffold(
            floatingActionButton: currentPageIndex != 0 &&
                    currentPageIndex != 3 &&
                    currentPageIndex != 4
                ? SizedBox(
                    width: 135,
                    child: FloatingActionButton.extended(
                      backgroundColor: AppColors.yellowBackGroundColor,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CropLoanFormBankDetail.routeName);
                      },
                      label: AppTextWidget(
                        text: AppLocalizations.of(context)!.newLoan,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  )
                : currentPageIndex == 3
                    ? SizedBox(
                        width: 197,
                        child: FloatingActionButton.extended(
                          backgroundColor: AppColors.yellowBackGroundColor,
                          onPressed: () {
                            Navigator.pushNamed(context,
                                JointApplicantAadharVerifyScreen.routeName);
                            // Navigator.pushNamed(
                            //     context, AddJointApplicantScreen.routeName);
                          },
                          label: AppTextWidget(
                            text:
                                AppLocalizations.of(context)!.addJointApplicant,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                          ),
                        ),
                      )
                    : currentPageIndex == 4
                        ? SizedBox(
                            width: 120,
                            child: FloatingActionButton.extended(
                              backgroundColor: AppColors.yellowBackGroundColor,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AddLandScreen.routeName);
                              },
                              label: AppTextWidget(
                                text: AppLocalizations.of(context)!.addLand,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                              ),
                            ),
                          )
                        : const SizedBox(),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(
                  () {
                    currentPageIndex = index;
                  },
                );
              },
              indicatorColor: AppColors.backgroundGreenLightColor,
              selectedIndex: currentPageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.home,
                    size: 18,
                  ),
                  icon: const Icon(
                    Icons.home_outlined,
                    size: 18,
                  ),
                  label: AppLocalizations.of(context)!.home,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.article,
                    size: 18,
                  ),
                  icon: const Icon(
                    Icons.article_outlined,
                    size: 18,
                  ),
                  label: AppLocalizations.of(context)!.loan,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.inbox,
                    size: 18,
                  ),
                  icon: const Icon(
                    Icons.inbox_outlined,
                    size: 18,
                  ),
                  label: AppLocalizations.of(context)!.status,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.group,
                    size: 18,
                  ),
                  icon: const Icon(
                    Icons.group_outlined,
                    size: 18,
                  ),
                  label: AppLocalizations.of(context)!.jointApplicant,
                ),
                NavigationDestination(
                  selectedIcon: const Icon(
                    Icons.landscape,
                    size: 18,
                  ),
                  icon: const Icon(
                    Icons.landscape_outlined,
                    size: 18,
                  ),
                  label: AppLocalizations.of(context)!.land,
                ),
              ],
            ),
            body: <Widget>[
              //const HomeScreenWidget(),
              const LoanScreenWidget(),
              const LoanListScreen(),
              Card(
                shadowColor: Colors.transparent,
                margin: const EdgeInsets.all(8.0),
                child: SizedBox.expand(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.statusPage,
                    ),
                  ),
                ),
              ),
              const JointApplicantWidget(),
              const LandListScreen()
            ][currentPageIndex],
          );
        },
        listener: (BuildContext context, GetFarmerState state) {},
      ),
    );
  }
}
