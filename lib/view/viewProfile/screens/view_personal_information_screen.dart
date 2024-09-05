import 'package:ekisan_credit/view/profile/screens/address_information_screen.dart';
import 'package:ekisan_credit/view/profile/screens/peramanent_address_information_screen.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_address_information_screen.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_family_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_state.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../edit_profile/screens/edit_personal_information_first_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../widgets/view_profile_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewPersonalInformationScreen extends StatefulWidget {
  static String routeName = "view-personal-information-screen";

  const ViewPersonalInformationScreen({super.key});

  @override
  State<ViewPersonalInformationScreen> createState() =>
      _ViewPersonalInformationScreenState();
}

class _ViewPersonalInformationScreenState
    extends State<ViewPersonalInformationScreen> {
  String selectedTab = '';
  String? name = '';
  String? sonOf = '';
  String? gender = '';
  String? contactNumber = '';
  String? emailId = '';
  String? dateOfBirth = '';
  String? religion = '';
  String? identityProof = '';
  String? identityProofNumber = '';
  String? caste = '';
  String? occupation = '';
  String? physicallyChallanged = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selectedTab = AppLocalizations.of(context)!.personal;
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    name = getFarmerResponseModel.data?.fullName ?? '';
    sonOf = getFarmerResponseModel.data?.relativeName;
    gender = getFarmerResponseModel.data?.genderName;
    contactNumber = '${getFarmerResponseModel.data?.mobileNo}';
    emailId = getFarmerResponseModel.data?.email;
    dateOfBirth = DateFormat('dd/MM/yyyy').format(DateTime.parse(
        getFarmerResponseModel.data?.dateOfBirth.toString() ?? ''));
    religion = getFarmerResponseModel.data?.religionName;
    identityProof = getFarmerResponseModel.data?.proofOfIdentityName;
    identityProofNumber = getFarmerResponseModel.data?.idProofNumber;
    caste = getFarmerResponseModel.data?.castName;
    occupation = getFarmerResponseModel.data?.occupationName;
    physicallyChallanged = getFarmerResponseModel.data?.physicallyChallenged;

    context.read<GetFarmerBloc>().stream.listen((event) {
      if (event is GetFarmerSuccess) {
        if (mounted) {
          context
              .read<GetFarmerFamilyDetailBloc>()
              .add(GetFarmerFamilyDetails());
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 34,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                AppTextWidget(
                  text: AppLocalizations.of(context)!.profile,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, EditPersonalInformationFirstScreen.routeName);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.backgroundGreenLightColor),
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: AppColors.iconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            ViewProfileHeader(
              onValueSelected: (String val) {
                setState(() {
                  selectedTab = val;
                });
              },
              contentList: [
                ViewProfileModel(
                    icon: Icons.person,
                    name: AppLocalizations.of(context)!.personal),
                ViewProfileModel(
                    icon: Icons.home,
                    name: AppLocalizations.of(context)!.address),
                ViewProfileModel(
                    icon: Icons.group_add,
                    name: AppLocalizations.of(context)!.family),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            if (selectedTab == AppLocalizations.of(context)!.personal)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.backgroundGreenLightColor,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.name,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: name ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.sonOf,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: sonOf ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .gender,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: gender ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .contactNumber,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: contactNumber ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .emailId,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: emailId ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .dateOfBirth,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: dateOfBirth ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .religion,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: religion ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .proofOfIdentity,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: identityProof ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .proofOfIdentityNumber,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: identityProofNumber ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.caste,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: caste ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .occupation,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: occupation ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .physicallyChallenged,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextWidget(
                                        text: physicallyChallanged ?? '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (selectedTab == AppLocalizations.of(context)!.address)
              const ViewAddressInformationScreen(),
            if (selectedTab == AppLocalizations.of(context)!.family)
              const ViewFamilyInformationScreen()
          ],
        ),
      ),
    );
  }
}
