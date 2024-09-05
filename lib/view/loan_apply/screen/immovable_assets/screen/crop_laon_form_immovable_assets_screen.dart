import 'package:ekisan_credit/cubit/model/other_details_cubit_model.dart';
import 'package:ekisan_credit/utils/money_formater.dart';
import 'package:ekisan_credit/view/loan_apply/screen/movable_assets/screen/croap_loan_form_movable_assets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../widget/loan_apply_header.dart';
import '../../land_details/widget/crop_laon_form_add_land_widget.dart';
import '../widget/add_particulars_of_immovable_assets_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormImmovableAssetsScreen extends StatefulWidget {
  static const routeName = "crop-loan-form-immovable-assets";

  const CropLoanFormImmovableAssetsScreen({super.key});

  @override
  State<CropLoanFormImmovableAssetsScreen> createState() =>
      _CropLoanFormImmovableAssetsScreenState();
}

class _CropLoanFormImmovableAssetsScreenState
    extends State<CropLoanFormImmovableAssetsScreen> {
  CurrencyFormatter currencyFormatter = CurrencyFormatter();

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
                          // isExtended: true,
                          backgroundColor: AppColors.greenColor,
                          onPressed: () {
                            context.read<OtherDetailsCubit>().clearAsset();
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
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.loanAssetsList
                                      .where((e) => e.assetType == "Immovable")
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final loanAsset = immovableAssets[index];

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
                                text: currencyFormatter.formatCurrency(context
                                        .read<OtherDetailsCubit>()
                                        .getTotalPresentMarketValueOfImmovable()) ??
                                    '',
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
                          child: AppTextWidget(text: AppLocalizations.of(context)!.pleaseAddAtleast)),
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
                  child: CommonButton(
                    buttonName: AppLocalizations.of(context)!.cancel,
                    borderColor: AppColors.greenColor,
                    buttonColor: Colors.transparent,
                    buttonTextColor: AppColors.greenColor,
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
                            context, CropLoanFormMovableAssetsScreen.routeName);
                      },
                      child:  CommonButton(
                        buttonName: AppLocalizations.of(context)!.cancel,
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
          ],
        ),
      ),
    );
  }
}
