import 'package:ekisan_credit/bloc/loan_assets/loan_assets_bloc.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/asset_id/asset_id_cubit.dart';
import 'package:ekisan_credit/cubit/incomplete_loan/incomplete_loan_cubit.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/loan_assets/loan_assets_event.dart';
import '../../../../../bloc/loan_assets/loan_assets_state.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../cubit/model/other_details_cubit_model.dart';
import '../../../../../model/response/loan_assets_response_model.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_immovable_assets/incomplete_crop_loan_form_immovable_assets_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteCropLoanFormOtherDetailsScreen extends StatefulWidget {
  static const routeName = "incomplete-crop-loan-form-other-details";

  const IncompleteCropLoanFormOtherDetailsScreen({super.key});

  @override
  State<IncompleteCropLoanFormOtherDetailsScreen> createState() =>
      _IncompleteCropLoanFormOtherDetailsScreenState();
}

class _IncompleteCropLoanFormOtherDetailsScreenState
    extends State<IncompleteCropLoanFormOtherDetailsScreen> {
  final TextEditingController _agriculturalIncomeController =
      TextEditingController();
  final TextEditingController _otherIncomeController = TextEditingController();
  final TextEditingController _alliedIncomeController = TextEditingController();

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  var loanAssetBloc = LoanAssetsBloc();
  var lovTypeBloc = GetLovsTypeDataNewBloc();
  List<LovTypeDataList> lovsTypeDataList = [];
  List<LoanAssetDataList> loanAssetsList = [];
  var uuid = const Uuid();

  @override
  void initState() {
    final incompleteCubit = context.read<IncompleteLoanInfoCubit>();
    final assetIdCubit = context.read<AssetIdCubit>();
    final otherDetailsCubit = context.read<OtherDetailsCubit>();
    otherDetailsCubit.clearLoanAssetList();
    _agriculturalIncomeController.text =
        '${incompleteCubit.state.agricultureIncome??'0.0'}';
    _otherIncomeController.text = '${incompleteCubit.state.otherIncome??'0.0'}';
    _alliedIncomeController.text = '${incompleteCubit.state.alliedIncome??'0.0'}';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loanAssetBloc
          .add(GetLoanAssetsDetails(loanId: await getIncompleteLoanId() ?? ''));
    });

    loanAssetBloc.stream.listen((state1) {
      if (state1 is LoanAssetsLoading) {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const AlertDialog(
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
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                AppTextWidget(
                  text: "Loading...",
                  fontSize: AppTextSize.contentSize20,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
        );
      }
      if (state1 is LoanAssetsSuccess) {
        Navigator.of(context).pop();
        loanAssetsList = state1.loanAssetsResponseModel.dataList ?? [];
        for (int i = 0; i < loanAssetsList.length; i++) {
          if (assetIdCubit.state.immovableId ==
              loanAssetsList[i].assestTypeId) {
            final otherDetailsCubit = context.read<OtherDetailsCubit>();
            otherDetailsCubit.addLoanAsset(LoanAsset(
                id: loanAssetsList[i].id,
                loanMasterId: '${loanAssetsList[i].loanMasterId}',
                assestTypeId: '${loanAssetsList[i].assestTypeId}',
                assetDataId: '${loanAssetsList[i].assetDataId}',
                particulars: loanAssetsList[i].particulars,
                presentMarketValue: '${loanAssetsList[i].presentMarketValue}',
                assetName: loanAssetsList[i].assetDataName,
                listId: uuid.v4(),
                assetType: "Immovable"));
          }
        }

        for (int j = 0; j < loanAssetsList.length; j++) {
          if (assetIdCubit.state.movableId == loanAssetsList[j].assestTypeId) {
            final otherDetailsCubit = context.read<OtherDetailsCubit>();
            otherDetailsCubit.addLoanAsset(LoanAsset(
                id: loanAssetsList[j].id,
                loanMasterId: '${loanAssetsList[j].loanMasterId}',
                assestTypeId: '${loanAssetsList[j].assestTypeId}',
                assetDataId: '${loanAssetsList[j].assetDataId}',
                particulars: loanAssetsList[j].particulars,
                presentMarketValue: '${loanAssetsList[j].presentMarketValue}',
                assetName: loanAssetsList[j].assetDataName,
                listId: uuid.v4(),
                assetType: "Movable"));
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.lastYearsAnnualIncome,
                          textColor: const Color(0xFF191D17),
                          fontSize: AppTextSize.contentSize16,
                          fontWeight: FontWeight.w400,
                        ),
                        const AppTextWidget(
                          text: "2023-24",
                          fontWeight: FontWeight.w500,
                          fontSize: AppTextSize.contentSize11,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                     Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.agricultureIncome,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      controller: _agriculturalIncomeController,
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText:AppLocalizations.of(context)!.pleaseEnterAmount,
                      prefixIcon: Icons.currency_rupee_outlined,
                      length: 10,
                      showPrefixIcon: true,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                              loanMasterOtherDetailsRequestPayload:
                                  LoanMasterOtherDetailsRequestPayload(
                                agricultureIncome: value,
                              ),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                     Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.otherIncome,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      controller: _otherIncomeController,
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.pleaseEnterAmount,
                      length: 10,
                      prefixIcon: Icons.currency_rupee_outlined,
                      showPrefixIcon: true,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                              loanMasterOtherDetailsRequestPayload:
                                  LoanMasterOtherDetailsRequestPayload(
                                otherIncome: value,
                              ),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                     Row(
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.alliedActivity,
                          fontSize: AppTextSize.contentSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      controller: _alliedIncomeController,
                      labelText: AppLocalizations.of(context)!.amount,
                      hintText: AppLocalizations.of(context)!.pleaseEnterAmount,
                      prefixIcon: Icons.currency_rupee_outlined,
                      showPrefixIcon: true,
                      length: 10,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                              loanMasterOtherDetailsRequestPayload:
                                  LoanMasterOtherDetailsRequestPayload(
                                alliedIncome: value,
                              ),
                            );
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  CommonButton(
                      buttonName: AppLocalizations.of(context)!.cancell,
                      borderColor: AppColors.greenColor,
                      buttonColor: Colors.transparent,
                      buttonTextColor: AppColors.greenColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                    builder: (BuildContext context, OtherDetailsState state) {
                      if (_agriculturalIncomeController.text.isNotEmpty &&
                          _otherIncomeController.text.isNotEmpty &&
                          _alliedIncomeController.text.isNotEmpty) {
                        return InkWell(
                          onTap: () async {
                            Navigator.pushNamed(
                                context,
                                IncompleteCropLoanFormImmovableAssetsScreen
                                    .routeName);
                          },
                          child:  CommonButton(
                            buttonName:AppLocalizations.of(context)!.next,
                          ),
                        );
                      }
                      return  CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                        buttonColor: AppColors.grayColor,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
