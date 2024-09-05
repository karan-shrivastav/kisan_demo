import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_asset_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/loan_preview/loan_details_basic/loan_details_preview_bloc.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/money_formater.dart';
import 'loan_preview_gurrantor_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherDetailsPreview extends StatefulWidget {
  const OtherDetailsPreview({super.key});

  @override
  State<OtherDetailsPreview> createState() => _OtherDetailsPreviewState();
}

class _OtherDetailsPreviewState extends State<OtherDetailsPreview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CurrencyFormatter formatter = CurrencyFormatter();

  @override
  Widget build(BuildContext context) {
    final loanDetailsNewPreviewBloc =
        context.watch<LoanDetailsNewPreviewBloc>();
    final otherDetails =
        loanDetailsNewPreviewBloc.loanDetailsNewPreviewResponseModel;
    return Column(
      children: [
         AppTextWidget(
          text: AppLocalizations.of(context)!.otherDetails,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: AppLocalizations.of(context)!.lastYearAnnualIncome,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            AppTextWidget(
              text: otherDetails.data?.loanDetailMapper?.lastYear ?? '',
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   AppTextWidget(
                    text: AppLocalizations.of(context)!.agriculturalIncome,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: formatter.formatCurrency(
                        otherDetails.data?.loanDetailMapper?.agricultureIncome),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.otherIncome,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: formatter.formatCurrency(
                        otherDetails.data?.loanDetailMapper?.otherIncome),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   AppTextWidget(
                    text: AppLocalizations.of(context)!.alliedIncome,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: formatter.formatCurrency(
                        otherDetails.data?.loanDetailMapper?.alliedIncome),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const LoanAssetPreviewScreen(),
        const LoanPreviewGuarantorScreen()
      ],
    );
  }
}
