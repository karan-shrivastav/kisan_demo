import 'package:ekisan_credit/view/aadhar/screens/aadhar_otp_screen.dart';
import 'package:ekisan_credit/view/aadhar/screens/aadhar_review_screen.dart';
import 'package:ekisan_credit/view/aadhar/screens/aadhar_successfully_linked_screen.dart';
import 'package:ekisan_credit/view/aadhar/screens/adhar_screen.dart';
import 'package:ekisan_credit/view/edit_profile/screens/edit_contact_information_first_screen.dart';
import 'package:ekisan_credit/view/edit_profile/screens/edit_contact_information_second_screen.dart';
import 'package:ekisan_credit/view/edit_profile/screens/edit_personal_information_first_screen.dart';
import 'package:ekisan_credit/view/edit_profile/screens/edit_same_current_permanent_address_screen.dart';
import 'package:ekisan_credit/view/home/screens/add_joint_applicant_screen.dart';
import 'package:ekisan_credit/view/home/screens/home_screen.dart';
import 'package:ekisan_credit/view/home/screens/joint_applicant_adhar_verify%20screen.dart';
import 'package:ekisan_credit/view/home/screens/loan_list_screen.dart';
import 'package:ekisan_credit/view/home/screens/view_joint_applicant.dart';
import 'package:ekisan_credit/view/home/widgets/home_screen_widget.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_applicant/screens/incomplete_loan_applicant.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_bank_details/screens/incomplete_crop_loan_form_bank_details.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_borrower_details/screens/imcomplete_borrower_details_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_crop_loan_form_crop_details/screens/incomplete_crop_loan_form_crop_details_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_crop_loan_form_crop_details/screens/incomplete_crop_loan_form_crop_details_screen2.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_declaration/screens/incomplete_declartion_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_guarantors_details/screens/incomplete_guarantors_details_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_immovable_assets/incomplete_crop_loan_form_immovable_assets_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_land/screens/incomplete_land_detail_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_liabilities_guarantor/screens/incomplete_liabilities_guarantor_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_loan_purpose/screens/incomplete_loan_purpose_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_movable_assets/incomplete_crop_loan_form_movable_assets_screen.dart';
import 'package:ekisan_credit/view/incomplete_loan/screens/incomplete_other_details/screens/incomplete_crop_loan_form_other_details_screen.dart';
import 'package:ekisan_credit/view/land/screen/add_land_screen.dart';
import 'package:ekisan_credit/view/land/screen/edit_land_details_screen.dart';
import 'package:ekisan_credit/view/land/screen/view_land_details_screen.dart';
import 'package:ekisan_credit/view/language/language.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/accept_and_save_first_screen.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/accept_and_save_second_screen.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_preview_joint_applicant.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_preview_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/borrower_details/screens/borrower_details_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/crop_loan_form_bank_details.dart';
import 'package:ekisan_credit/view/loan_apply/screen/crop_loan_form_crop_details.dart';
import 'package:ekisan_credit/view/loan_apply/screen/declaration/screen/crop_laon_form_declaration_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/immovable_assets/screen/crop_laon_form_immovable_assets_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/guarantor_details/screens/guarantors_details_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/land_details/screen/land_detail_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/liabilities_guarantor/screens/liabilities_guarantor_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/movable_assets/screen/croap_loan_form_movable_assets_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/other_details/screen/other_details_screen.dart';
import 'package:ekisan_credit/view/loan_request/loan_applicant/loan_applicant.dart';
import 'package:ekisan_credit/view/loan_request/screens/loan_purpose_screen.dart';
import 'package:ekisan_credit/view/loan_type/screen/loan_type_screen.dart';
import 'package:ekisan_credit/view/onboarding/screen/onboarding_screen.dart';
import 'package:ekisan_credit/view/profile/screens/address_information_screen.dart';
import 'package:ekisan_credit/view/family/screens/family_screen.dart';
import 'package:ekisan_credit/view/profile/screens/peramanent_address_information_screen.dart';
import 'package:ekisan_credit/view/profile/screens/personal_information_screen.dart';
import 'package:ekisan_credit/view/profile/screens/profile_screen.dart';
import 'package:ekisan_credit/view/profile/screens/religion_information_screen.dart';
import 'package:ekisan_credit/view/profile/screens/same_current_permanent_address_screen.dart';
import 'package:ekisan_credit/view/register/screen/register_screen.dart';
import 'package:ekisan_credit/view/set_up_mpin/screens/confirm_m_pin.dart';
import 'package:ekisan_credit/view/set_up_mpin/screens/mpin_craeted_successfully.dart';
import 'package:ekisan_credit/view/set_up_mpin/screens/set_mpin_screen.dart';
import 'package:ekisan_credit/view/splash/screen/splash_screen.dart';
import 'package:ekisan_credit/view/use_mPin/screens/use_mPin.dart';
import 'package:ekisan_credit/view/verify_otp/screens/verify_otp_screen.dart';
import 'package:ekisan_credit/view/verify_otp/widget/successfully_registered_screen.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_address_information_screen.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_family_information_screen.dart';
import 'package:ekisan_credit/view/viewProfile/screens/view_personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'view/edit_profile/screens/edit_family_screen.dart';
import 'view/edit_profile/screens/edit_personal_information_second_screen.dart';
import 'view/edit_profile/screens/edit_personal_information_third_screen.dart';
import 'view/login/screen/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  OnBoardingScreen.routeName : (context)=> const OnBoardingScreen(),
  SplashScreen.routeName : (context)=> const SplashScreen(),

  VerifyOtpScreen.routeName: (context) => const VerifyOtpScreen(),
  

  SuccessfullyRegisteredScreen.routeName: (context) =>
      const SuccessfullyRegisteredScreen(),
  SetMPinScreen.routeNAme: (context) =>  SetMPinScreen(),
  ConfirmMPinScreen.routeName: (context) => const ConfirmMPinScreen(),
  MPinCreatedSuccessfully.routeName: (context) =>
      const MPinCreatedSuccessfully(),
  UseMPinScreen.routeName: (context) => const UseMPinScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  PersonalInformationScreen.routeName: (context) =>
      const PersonalInformationScreen(),
  AddressInformationScreen.routeName: (context) =>
      const AddressInformationScreen(),
  FamilyScreen.routeName: (context) => const FamilyScreen(),
  ReligionInformationScreen.routeName: (context) => ReligionInformationScreen(),
  PermanentAddressInformationScreen.routeName: (context) =>
      const PermanentAddressInformationScreen(),
  ViewPersonalInformationScreen.routeName: (context) =>
      const ViewPersonalInformationScreen(),
  ViewAddressInformationScreen.routeName: (context) =>
      const ViewAddressInformationScreen(),
  ViewFamilyInformationScreen.routeName: (context) =>
      const ViewFamilyInformationScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  EditPersonalInformationFirstScreen.routeName: (context) =>
      const EditPersonalInformationFirstScreen(),
  EditPersonalInformationSecondScreen.routeName: (context) =>
      const EditPersonalInformationSecondScreen(),
  EditPersonalInformationThirdScreen.routeName: (context) =>
      const EditPersonalInformationThirdScreen(),
  SameCurrentPermanentAddressScreen.routeName: (context) =>
      const SameCurrentPermanentAddressScreen(),
  EditContactInformationSecondScreen.routeName: (context) =>
      const EditContactInformationSecondScreen(),
  EditContactInformationFirstScreen.routeName: (context) =>
      const EditContactInformationFirstScreen(),
  EditContactInformationFirstScreen.routeName: (context) =>
      const EditContactInformationFirstScreen(),
  EditSameCurrentPermanentAddressScreen.routeName: (context) =>
      const EditSameCurrentPermanentAddressScreen(),
  EditFamilyScreen.routeName: (context) => const EditFamilyScreen(),
  AddJointApplicantScreen.routeName: (context) =>
      const AddJointApplicantScreen(),
  LanguageScreen.routeName: (context) => const LanguageScreen(),
  ViewJointApplicant.routeName: (context) => const ViewJointApplicant(),
  AddLandScreen.routeName: (context) => const AddLandScreen(),
  ViewLandDetailsScreen.routeName: (context) => const ViewLandDetailsScreen(),
  EditLandDetailScreen.routeName: (context) => const EditLandDetailScreen(),
  LoanTypeScreen.routeName: (context) => const LoanTypeScreen(),
  CropLoanFormBankDetail.routeName: (context) => const CropLoanFormBankDetail(),
  CropLoanFromCropDetailsScreen.routeName: (context) =>
      const CropLoanFromCropDetailsScreen(),
  LoanPurpose.routeName: (context) => const LoanPurpose(),
  LoanApplicant.routeName: (context) => const LoanApplicant(),
  LandDetailScreen.routeName: (context) => const LandDetailScreen(),
  CropLoanFormOtherDetailsScreen.routeName: (context) =>
      const CropLoanFormOtherDetailsScreen(),
  CropLoanFormImmovableAssetsScreen.routeName: (context) =>
      const CropLoanFormImmovableAssetsScreen(),
  CropLoanFormMovableAssetsScreen.routeName: (context) =>
      const CropLoanFormMovableAssetsScreen(),
  GuarantorsDetailsScreen.routeName: (context) =>
      const GuarantorsDetailsScreen(),
  BorrowerDetailsScreen.routeName: (context) => const BorrowerDetailsScreen(),
  LiabilitiesGuarantorScreen.routeName: (context) =>
      const LiabilitiesGuarantorScreen(),
  GuarantorsDetailsScreen.routeName: (context) =>
      const GuarantorsDetailsScreen(),
  CropLoanFormDeclarationScreen.routeName: (context) =>
      const CropLoanFormDeclarationScreen(),
  LoanListScreen.routeName: (context) => const LoanListScreen(),
  HomeScreenWidget.routeName: (context) => const HomeScreenWidget(),
  LoanPreviewScreen.routeName: (context) => const LoanPreviewScreen(),
  AcceptAndSaveFirstScreen.routeName: (context) =>
      const AcceptAndSaveFirstScreen(),
  AcceptAndSaveSecondScreen.routeName: (context) =>
      const AcceptAndSaveSecondScreen(),
  IncompleteCropLoanFormBankDetail.routeName: (context) =>
      const IncompleteCropLoanFormBankDetail(),
  IncompleteBorrowerDetailsScreen.routeName: (context) =>
      const IncompleteBorrowerDetailsScreen(),
  IncompleteCropLoanFromCropDetailsScreen.routeName: (context) =>
      const IncompleteCropLoanFromCropDetailsScreen(),
  IncompleteGuarantorsDetailsScreen.routeName: (context) =>
      const IncompleteGuarantorsDetailsScreen(),
  IncompleteCropLoanFormImmovableAssetsScreen.routeName: (context) =>
      const IncompleteCropLoanFormImmovableAssetsScreen(),
  IncompleteLandDetailScreen.routeName: (context) =>
      const IncompleteLandDetailScreen(),
  IncompleteLiabilitiesGuarantorScreen.routeName: (context) =>
      const IncompleteLiabilitiesGuarantorScreen(),
  IncompleteCropLoanFormMovableAssetsScreen.routeName: (context) =>
      const IncompleteCropLoanFormMovableAssetsScreen(),
  IncompleteCropLoanFormOtherDetailsScreen.routeName: (context) =>
      const IncompleteCropLoanFormOtherDetailsScreen(),
  IncompleteLoanPurpose.routeName: (context) => const IncompleteLoanPurpose(),
  CropLoanFromCropDetailsScreen2.routeName: (context) =>
      const CropLoanFromCropDetailsScreen2(),
  IncompleteLoanApplicant.routeName: (context) =>
      const IncompleteLoanApplicant(),
  LoanPreviewJointApplicant.routeName: (context) =>
      const LoanPreviewJointApplicant(),
  IncompleteCropLoanFormDeclarationScreen.routeName: (context) =>
      const IncompleteCropLoanFormDeclarationScreen(),
  AadharScreen.routeName: (context) => const AadharScreen(),
  AadharOtpScreen.routeName: (context) => const AadharOtpScreen(),
  AAdharSuccessfullyLinkedScreen.routeName: (context) => const AAdharSuccessfullyLinkedScreen(),
  AadharReviewScreen.routeName: (context) => const AadharReviewScreen(),
  JointApplicantAadharVerifyScreen.routeName: (context) => const JointApplicantAadharVerifyScreen(),
};
