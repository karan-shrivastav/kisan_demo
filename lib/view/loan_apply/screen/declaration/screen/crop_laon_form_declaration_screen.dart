import 'package:ekisan_credit/bloc/save_other_details/save_other_details_state.dart';
import 'package:ekisan_credit/cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../../../bloc/save_other_details/save_other_details_bloc.dart';
import '../../../../../bloc/save_other_details/save_other_details_event.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../widget/loan_apply_header.dart';
import '../../movable_assets/screen/croap_loan_form_movable_assets_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormDeclarationScreen extends StatelessWidget {
  static const routeName = "crop-loan-form-declaration";

  const CropLoanFormDeclarationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String?> getFarmerId() async {
      AppSharedPreferenceHelper appSharedPreferenceHelper =
          AppSharedPreferenceHelper();
      return appSharedPreferenceHelper.getCustomerData('farmerId');
    }

    Future<void> callApiOtherDetails(farmerId) async {
      final otherDetailsBloc = context.read<SaveOtherDetailsNewBloc>();
      final cropResponseData = context.read<SaveCropNewBloc>();
      final otherDetailCubit = context.read<OtherDetailsCubit>().state;

      List loanMovableAssetsDTOMain = [];
      List addGuarantorList = [];
      List loanLiabilityGuarantorDTO = [];
      List userLoanLiabilitiesList = [];

      for (int i = 0; i < otherDetailCubit.loanGuarantorList.length; i++) {
        addGuarantorList.add({
          "occupationDataId":
              otherDetailCubit.loanGuarantorList[i].occupationDataId,
          "guarantorName": otherDetailCubit.loanGuarantorList[i].guarantorName,
          "age": otherDetailCubit.loanGuarantorList[i].age,
          "address": otherDetailCubit.loanGuarantorList[i].address,
          "mobileNumber": otherDetailCubit.loanGuarantorList[i].mobileNumber,
          "netWorth": double.tryParse(otherDetailCubit
              .loanGuarantorList[i].netWorth!
              .replaceAll(',', ''))
        });
      }
      for (int i = 0;
          i < otherDetailCubit.loanLiabilityGuarantorList.length;
          i++) {
        loanLiabilityGuarantorDTO.add({
          "bankMasterId":
              otherDetailCubit.loanLiabilityGuarantorList[i].bankMasterId,
          "guarantorName":
              otherDetailCubit.loanLiabilityGuarantorList[i].guarantorName,
          "loanAmount": double.tryParse(otherDetailCubit
              .loanLiabilityGuarantorList[i].loanAmount!
              .replaceAll(',', '')),
          "outstanding": double.tryParse(otherDetailCubit
              .loanLiabilityGuarantorList[i].outstanding
              !.replaceAll(',', '')),
          "account_status":
              otherDetailCubit.loanLiabilityGuarantorList[i].accountStatus
        });
      }
      for (int i = 0; i < otherDetailCubit.userLoanLiabilityList.length; i++) {
        userLoanLiabilitiesList.add({
          "farmerId": farmerId,
          "accountStatusId":
              otherDetailCubit.userLoanLiabilityList[i].accountStatusId,
          "securityOfferedId":
              otherDetailCubit.userLoanLiabilityList[i].securityOfferedId,
          "bankName": otherDetailCubit.userLoanLiabilityList[i].bankName,
          "branchName": otherDetailCubit.userLoanLiabilityList[i].branchName,
          "loanPurpose": otherDetailCubit.userLoanLiabilityList[i].loanPurpose,
          "outstanding": otherDetailCubit.userLoanLiabilityList[i].outstanding
              ?.replaceAll(',', ''),
          "bankType": otherDetailCubit.userLoanLiabilityList[i].bankType
        });
      }
      for (int i = 0; i < otherDetailCubit.loanAssetsList.length; i++) {
        loanMovableAssetsDTOMain.add({
          "id": null,
          "loanId": cropResponseData
              .saveCropResponseModel.data!.userProposedDetails!.first.loanId,
          "assetDataId": otherDetailCubit.loanAssetsList[i].assetDataId,
          "assestTypeId": otherDetailCubit.loanAssetsList[i].assestTypeId,
          "particulars": otherDetailCubit.loanAssetsList[i].particulars,
          "presentMarketValue": int.parse(
              otherDetailCubit.loanAssetsList[i].presentMarketValue != null
                  ? otherDetailCubit.loanAssetsList[i].presentMarketValue!
                      .replaceAll(',', '')
                  : "")
        });
      }
      final bodyRequest = {
        "loanMasterOtherDetailsRequestPayload": {
          "agricultureIncome": otherDetailCubit
              .loanMasterOtherDetailsRequestPayload?.agricultureIncome
              ?.replaceAll(",", ''),
          "otherIncome": otherDetailCubit
              .loanMasterOtherDetailsRequestPayload?.otherIncome
              ?.replaceAll(",", ''),
          "alliedIncome": otherDetailCubit
              .loanMasterOtherDetailsRequestPayload?.alliedIncome
              ?.replaceAll(",", ''),
          "lastYear": "2023"
        },
        "loanAsset": loanMovableAssetsDTOMain,
        "loanGuarantorsList": addGuarantorList,
        "loanLiabilityGuarantors": loanLiabilityGuarantorDTO,
        "userLoanLiabilitiesList": userLoanLiabilitiesList,
        "masterId": cropResponseData
            .saveCropResponseModel.data?.loanMasterRequestPayload?.id
      };

      print(bodyRequest);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        otherDetailsBloc.add(SaveOtherDetailsNew(bodyRequest: bodyRequest));
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.otherDetails,
              fontSize: AppTextSize.contentSize22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.declaration,
                  fontSize: AppTextSize.contentSize16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: AppTextWidget(
                text: AppLocalizations.of(context)!.declarationText
                     ,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.greenColor,
                      buttonColor: Colors.transparent,
                      buttonTextColor: AppColors.greenColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BlocConsumer<SaveOtherDetailsNewBloc,
                      SaveOtherDetailsNewState>(
                    builder:
                        (BuildContext context, SaveOtherDetailsNewState state) {
                      return InkWell(
                        onTap: () async {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                 AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              scrollable: true,
                              content: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.saving,
                                    fontSize: AppTextSize.contentSize20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          );
                          final otherDetailCubit =
                              context.read<OtherDetailsCubit>();
                          final farmerId = await getFarmerId();
                          callApiOtherDetails(farmerId);
                        },
                        child:  CommonButton(
                          buttonName: AppLocalizations.of(context)!.next,
                        ),
                      );
                    },
                    listener:
                        (BuildContext context, SaveOtherDetailsNewState state) {
                      if (state is SaveOtherDetailsNewSuccess) {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                            context, LoanPreviewScreen.routeName);
                      }
                      if (state is SaveOtherDetailsNewFail) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
