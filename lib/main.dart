import 'package:ekisan_credit/bloc/add_land/add_land_bloc.dart';
import 'package:ekisan_credit/bloc/apply_loan_request/apply_loan_request_bloc.dart';
import 'package:ekisan_credit/bloc/check_side_bar/check_side_bar_bloc.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_bloc.dart';
import 'package:ekisan_credit/bloc/show_otp/show_otp_bloc.dart';
import 'package:ekisan_credit/cubit/add_land/add_land_cubit.dart';
import 'package:ekisan_credit/cubit/add_land/edit_land_cubit.dart';
import 'package:ekisan_credit/cubit/login/farmer_login_cubit.dart';
import 'package:ekisan_credit/language/language_state.dart';
import 'package:ekisan_credit/routes.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/onboarding/screen/onboarding_screen.dart';
import 'package:ekisan_credit/view/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Utils/shared_preference_helper.dart';
import 'bloc/Add_address/add_address_bloc.dart';
import 'bloc/add_joint_applicant/add_joint_applicant_bloc.dart';
import 'bloc/apply_loan_save_crop/save_crop_bloc.dart';
import 'bloc/bank_list/bank_list_bloc.dart';
import 'bloc/bank_type/bank_type_bloc.dart';
import 'bloc/banks_bank_by_type/banks_bank_by_type_bloc.dart';
import 'bloc/branch/branch_list_bloc.dart';
import 'bloc/check_ekyc/check_ekyc_bloc.dart';
import 'bloc/crop_name/crop_name_bloc.dart';
import 'bloc/delete_family/delete_family_bloc.dart';
import 'bloc/delete_joint_applicant/delete_joint_applicant_bloc.dart';
import 'bloc/delete_land/delete_land_bloc.dart';
import 'bloc/district/district_bloc.dart';
import 'bloc/family/add_family_member_bloc.dart';
import 'bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import 'bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import 'bloc/get_land_details/get_land_details_bloc.dart';
import 'bloc/laon_list/laon_list_bloc.dart';
import 'bloc/loan_assets/loan_assets_bloc.dart';
import 'bloc/loan_basic/get_loan_basic_bloc.dart';
import 'bloc/loan_count/loan_count_bloc.dart';
import 'bloc/loan_count/loan_count_event.dart';
import 'bloc/loan_guarantor/loan_guarantor_bloc.dart';
import 'bloc/loan_preview/land_details_preview/land_details_preview_bloc.dart';
import 'bloc/loan_preview/loan_asset_preview/loan_asset_preview_bloc.dart';
import 'bloc/loan_preview/loan_details_basic/loan_details_preview_bloc.dart';
import 'bloc/loan_preview/loan_guarantor_preview/loan_guarantor_preview_bloc.dart';
import 'bloc/loan_preview/loan_preview_joint_applicant/loan_preview_joint_applicant_bloc.dart';
import 'bloc/lovs_type/lovs_type_data_bloc.dart';
import 'bloc/pacs/pacs_list_bloc.dart';
import 'bloc/register_farmer/register_farmer_bloc.dart';
import 'bloc/relationships/relationship_bloc.dart';
import 'bloc/save_land_details/save_land_details_bloc.dart';
import 'bloc/save_other_details/save_other_details_bloc.dart';
import 'bloc/selected_joint_applicant/selected_joint_applicant_bloc.dart';
import 'bloc/selected_land_details/selected_land_details_bloc.dart';
import 'bloc/state/state_bloc.dart';
import 'bloc/submit_laon_request/submit_loan_request_bloc.dart';
import 'bloc/timer/timer_bloc.dart';
import 'bloc/update_contact_info/update_contact_info_bloc.dart';
import 'bloc/village/get_vilage_bloc.dart';
import 'bloc/get_farmer/get_farmer_bloc.dart';
import 'bloc/update_personal_info/update_personal_info_bloc.dart';
import 'cubit/about_laon_detail/about_laon_detail_cubit.dart';
import 'cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import 'cubit/apply_laon/add_crop_cubit.dart';
import 'cubit/apply_laon/add_crop_list_cubit.dart';
import 'cubit/apply_laon/apply_loan_info_cubit.dart';
import 'cubit/apply_laon/kcc_limit_cubit.dart';
import 'cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import 'cubit/asset_id/asset_id_cubit.dart';
import 'cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'cubit/farmer_family_cubit/farmer_family_member_cubit.dart';
import 'cubit/incomplete_loan/incomplete_loan_cubit.dart';
import 'cubit/joint_applicant/joint_applicant_cubit.dart';
import 'cubit/joint_applicant/loan_applicant_cubit.dart';
import 'cubit/loan_purpose/loan_purpose_cubit.dart';
import 'cubit/shared_pareference_value/shared_preference_cubit.dart';
import 'language/language_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final appSharedPreferenceHelper = AppSharedPreferenceHelper();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(BlocProvider(
        create: (context) => LanguageBloc(), child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SendOtpBloc>(create: (context) => SendOtpBloc()),
          BlocProvider<ShowOtpBloc>(create: (context) => ShowOtpBloc()),
          BlocProvider<RegisterFarmerBloc>(
              create: (context) => RegisterFarmerBloc()),
          BlocProvider<FarmerInfoCubit>(create: (context) => FarmerInfoCubit()),
          BlocProvider<GetLovsTypeDataNewBloc>(
              create: (context) => GetLovsTypeDataNewBloc()),
          BlocProvider<RelationshipDataBloc>(
              create: (context) => RelationshipDataBloc()),
          BlocProvider<CreateFarmerUserInfoCubit>(
              create: (context) => CreateFarmerUserInfoCubit()),
          BlocProvider<StateBloc>(create: (context) => StateBloc()),
          BlocProvider<DistrictBlocNew>(create: (context) => DistrictBlocNew()),
          BlocProvider<GetVillageNewBloc>(
              create: (context) => GetVillageNewBloc()),
          BlocProvider<GetFarmerBloc>(create: (context) => GetFarmerBloc()),
          BlocProvider<UpdatePersonalInfoBloc>(
              create: (context) => UpdatePersonalInfoBloc()),
          BlocProvider<CreateFarmerCurrentAddressCubit>(
              create: (context) => CreateFarmerCurrentAddressCubit()),
          BlocProvider<AddAddressBloc>(create: (context) => AddAddressBloc()),
          BlocProvider<CreateFarmerPermanentAddressCubit>(
              create: (context) => CreateFarmerPermanentAddressCubit()),
          BlocProvider<UpdateContactInfoBloc>(
              create: (context) => UpdateContactInfoBloc()),
          BlocProvider<AddFamilyMemberBloc>(
              create: (context) => AddFamilyMemberBloc()),
          BlocProvider<FarmerFamilyMemberCubit>(
              create: (context) => FarmerFamilyMemberCubit()),
          BlocProvider<GetFarmerFamilyDetailBloc>(
              create: (context) => GetFarmerFamilyDetailBloc()),
          BlocProvider<TimerBloc>(
              create: (context) => TimerBloc(ticker: const Ticker())),
          BlocProvider<DeleteFamilyBloc>(
              create: (context) => DeleteFamilyBloc()),
          BlocProvider<JointApplicantInfoCubit>(
              create: (context) => JointApplicantInfoCubit()),
          BlocProvider<AddJointApplicantBloc>(
              create: (context) => AddJointApplicantBloc()),
          BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
          // Add the LanguageBloc here
          BlocProvider<GetJointApplicantBloc>(
              create: (context) => GetJointApplicantBloc()),
          BlocProvider<AddLandIrrigatedNonIrrigatedCubit>(
              create: (context) => AddLandIrrigatedNonIrrigatedCubit()),
          BlocProvider<AddLandCubit>(create: (context) => AddLandCubit()),
          BlocProvider<AddLandDataBloc>(create: (context) => AddLandDataBloc()),
          BlocProvider<GetLandDataBloc>(create: (context) => GetLandDataBloc()),
          BlocProvider<EditLandCubit>(create: (context) => EditLandCubit()),
          BlocProvider<DeleteLandDataBloc>(
              create: (context) => DeleteLandDataBloc()),
          BlocProvider<DeleteJointApplicantBloc>(
              create: (context) => DeleteJointApplicantBloc()),
          BlocProvider<LoanJointApplicantInfoCubit>(
              create: (context) => LoanJointApplicantInfoCubit()),
          BlocProvider<BankTypeNewBloc>(create: (context) => BankTypeNewBloc()),
          BlocProvider<BanksNewBankByTypeBloc>(
              create: (context) => BanksNewBankByTypeBloc()),
          BlocProvider<GetBankListNewBloc>(
              create: (context) => GetBankListNewBloc()),
          BlocProvider<ApplyLoanInfoCubit>(
              create: (context) => ApplyLoanInfoCubit()),
          BlocProvider<BranchListNewBloc>(
              create: (context) => BranchListNewBloc()),
          BlocProvider<CropNameNewBloc>(create: (context) => CropNameNewBloc()),
          BlocProvider<AddNewCropCubit>(create: (context) => AddNewCropCubit()),
          BlocProvider<AddCropCubit>(create: (context) => AddCropCubit()),
          BlocProvider<KccLimitCubit>(create: (context) => KccLimitCubit()),
          BlocProvider<SaveCropNewBloc>(create: (context) => SaveCropNewBloc()),
          BlocProvider<LoanPurposeCubit>(
              create: (context) => LoanPurposeCubit()),
          BlocProvider<LoanListBloc>(create: (context) => LoanListBloc()),
          BlocProvider<GetLoanBasicBloc>(
              create: (context) => GetLoanBasicBloc()),
          BlocProvider<IncompleteLoanInfoCubit>(
              create: (context) => IncompleteLoanInfoCubit()),
          BlocProvider<ApplyLoanRequestBloc>(
              create: (context) => ApplyLoanRequestBloc()),
          BlocProvider<SaveLandDetailsNewBloc>(
              create: (context) => SaveLandDetailsNewBloc()),
          BlocProvider<OtherDetailsCubit>(
              create: (context) => OtherDetailsCubit()),
          BlocProvider<SelectedJointApplicantBloc>(
              create: (context) => SelectedJointApplicantBloc()),
          BlocProvider<SaveOtherDetailsNewBloc>(
              create: (context) => SaveOtherDetailsNewBloc()),
          BlocProvider<LoanDetailsNewPreviewBloc>(
              create: (context) => LoanDetailsNewPreviewBloc()),
          BlocProvider<PreviewBasicsDetailsBloc>(
              create: (context) => PreviewBasicsDetailsBloc()),
          BlocProvider<SelectedLandBloc>(
              create: (context) => SelectedLandBloc()),
          BlocProvider<LoanAssetsBloc>(create: (context) => LoanAssetsBloc()),
          BlocProvider<LandDetailsNewPreviewBloc>(
              create: (context) => LandDetailsNewPreviewBloc()),
          BlocProvider<LoanAssetPreviewNewBloc>(
              create: (context) => LoanAssetPreviewNewBloc()),
          BlocProvider<LoanDetailsNewBloc>(
              create: (context) => LoanDetailsNewBloc()),
          BlocProvider<SubmitLoanRequestBloc>(
              create: (context) => SubmitLoanRequestBloc()),
          BlocProvider<AboutLoanDetailCubit>(
              create: (context) => AboutLoanDetailCubit()),
          BlocProvider<LoanGuarantorBloc>(
              create: (context) => LoanGuarantorBloc()),
          BlocProvider<PacsListNewBloc>(create: (context) => PacsListNewBloc()),
          BlocProvider<CheckSideBarBloc>(
              create: (context) => CheckSideBarBloc()),
          BlocProvider<CheckEkyCBloc>(create: (context) => CheckEkyCBloc()),
          BlocProvider<LoanCountBloc>(create: (context) => LoanCountBloc()),
          BlocProvider<AssetIdCubit>(create: (context) => AssetIdCubit()),
          BlocProvider<AppSharedPreferenceHelperCubit>(
              create: (context) => AppSharedPreferenceHelperCubit()),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            Locale locale = const Locale('en', 'US');
            // Locale locale = const Locale('hi', 'IN');
            if (state is LanguageLoaded) {
              locale = state.locale;
            }
            return MaterialApp(
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF406836),
                  background: AppColors.mainPageBackgroundColor,
                ),
                navigationBarTheme: NavigationBarThemeData(
                  labelTextStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                useMaterial3: true,
              ),
              routes: routes,
              home: const SplashScreen(),
            );
          },
        ));
  }
}

