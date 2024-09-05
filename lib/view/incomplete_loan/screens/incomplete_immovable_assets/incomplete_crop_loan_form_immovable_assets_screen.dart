import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../Utils/shared_preference_helper.dart';
import '../../../../bloc/loan_assets/loan_assets_bloc.dart';
import '../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../cubit/model/other_details_cubit_model.dart';
import '../../../loan_apply/screen/immovable_assets/widget/add_particulars_of_immovable_assets_widget.dart';
import '../../../loan_apply/widget/loan_apply_header.dart';
import '../incomplete_movable_assets/incomplete_crop_loan_form_movable_assets_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteCropLoanFormImmovableAssetsScreen extends StatefulWidget {
  static const routeName = "incomplete-crop-loan-form-immovable-assets";

  const IncompleteCropLoanFormImmovableAssetsScreen({super.key});

  @override
  State<IncompleteCropLoanFormImmovableAssetsScreen> createState() =>
      _IncompleteCropLoanFormImmovableAssetsScreenState();
}

class _IncompleteCropLoanFormImmovableAssetsScreenState
    extends State<IncompleteCropLoanFormImmovableAssetsScreen> {
  var loanAssetBloc = LoanAssetsBloc();
  var lovTypeBloc = GetLovsTypeDataNewBloc();

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  int lovId = 0;
  int assetTypeId = 0;
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final otherDetailsCubit = context.watch<OtherDetailsCubit>();
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.assetsOwned,
                          fontSize: AppTextSize.contentSize22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: FloatingActionButton(
                          backgroundColor: AppColors.greenColor,
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const AddParticularsOfImmovableWidget();
                                });
                          },
                          // isExtended: true,
                          child: const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (otherDetailsCubit.state.loanAssetsList
                      .where((element) => element.assetType == "Immovable")
                      .isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                              builder: (BuildContext context,
                                  OtherDetailsState state) {
                                final immovableAssets = state.loanAssetsList
                                    .where((e) => e.assetType == "Immovable")
                                    .toList();
                                Set<LoanAsset> dataSet =
                                    immovableAssets.toSet();
                                List<LoanAsset> filteredList = dataSet.toList();

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final loanAsset = filteredList[index];
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: AppTextWidget(
                                        text: loanAsset.assetName ?? '',
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      subtitle: AppTextWidget(
                                        text:
                                            loanAsset.presentMarketValue ?? '',
                                        fontSize: AppTextSize.contentSize14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      leading: const Icon(
                                          Icons.currency_rupee_outlined),
                                      trailing: InkWell(
                                        onTap: () {
                                          context
                                              .read<OtherDetailsCubit>()
                                              .deleteLoanAssetById(
                                                  loanAsset.listId);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: AppTextWidget(
                                text: AppLocalizations.of(context)!.totalValue,
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: AppTextWidget(
                                text: context
                                    .read<OtherDetailsCubit>()
                                    .getTotalPresentMarketValueOfImmovable()
                                    .toString(),
                                fontSize: AppTextSize.contentSize11,
                                fontWeight: FontWeight.w400,
                              ),
                              leading:
                                  const Icon(Icons.currency_rupee_outlined),
                            )
                          ],
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.pleaseAddAtleast,
                        ),
                      ),
                    )
                ],
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
                if ((otherDetailsCubit.state.loanAssetsList
                    .where((element) => element.assetType == "Immovable")
                    .isNotEmpty))
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            IncompleteCropLoanFormMovableAssetsScreen
                                .routeName);
                      },
                      child:  CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                      ),
                    ),
                  )
                else
                   Expanded(
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                      buttonColor: AppColors.grayColor,
                    ),
                  )
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
