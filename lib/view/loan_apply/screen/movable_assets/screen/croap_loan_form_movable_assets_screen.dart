import 'package:ekisan_credit/utils/money_formater.dart';
import 'package:ekisan_credit/view/loan_apply/screen/borrower_details/screens/borrower_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../widget/loan_apply_header.dart';
import '../widget/add_particulars_of_movable_assets_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormMovableAssetsScreen extends StatefulWidget {
  static const routeName = 'crop-loan-form-movable-assets';

  const CropLoanFormMovableAssetsScreen({super.key});

  @override
  State<CropLoanFormMovableAssetsScreen> createState() =>
      _CropLoanFormMovableAssetsScreenState();
}

class _CropLoanFormMovableAssetsScreenState
    extends State<CropLoanFormMovableAssetsScreen> {
  CurrencyFormatter currencyFormatter = CurrencyFormatter();

  @override
  Widget build(BuildContext context) {
    final otherDetailsCubit = context.watch<OtherDetailsCubit>();
    final movableAssets = otherDetailsCubit.state.loanAssetsList
        .where((element) => element.assetType == "Movable")
        .toList();
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
                          text:
                              AppLocalizations.of(context)!.movableAssetsOwned,
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
                            otherDetailsCubit.clearAsset();
                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const AddParticularsOfMovableWidget();
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
                      .where((element) => element.assetType == "Movable")
                      .isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: movableAssets.length,
                              itemBuilder: (BuildContext context, int index) {
                                final loanAsset = movableAssets[index];

                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: AppTextWidget(
                                    text: loanAsset.assetName ?? '',
                                    fontSize: AppTextSize.contentSize16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  subtitle: AppTextWidget(
                                    text: loanAsset.presentMarketValue ?? '',
                                    fontSize: AppTextSize.contentSize14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading:
                                      const Icon(Icons.currency_rupee_outlined),
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
                                    .getTotalPresentMarketValueOfMovable()),
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
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:  CommonButton(
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.greenColor,
                      buttonColor: Colors.transparent,
                      buttonTextColor: AppColors.greenColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                if (movableAssets.isNotEmpty)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, BorrowerDetailsScreen.routeName);
                      },
                      child: CommonButton(
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
          ],
        ),
      ),
    );
  }
}
