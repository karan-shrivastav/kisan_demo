import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/loan_purpose/loan_purpose_cubit.dart';
import 'package:ekisan_credit/utils/money_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/model/laon_purpose_cubit_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/text_input_formate.dart';
import '../../loan_apply/widget/loan_apply_header.dart';
import '../loan_applicant/loan_applicant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanPurpose extends StatefulWidget {
  static const routeName = "loan-purpose";

  const LoanPurpose({super.key});

  @override
  State<LoanPurpose> createState() => _LoanPurposeState();
}

class _LoanPurposeState extends State<LoanPurpose> {
  bool isChecked = false;
  final TextEditingController _costOfCultivationTextEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: implement didChangeDependencies
    final saveCropDetails = context.read<SaveCropNewBloc>();
    final amountData = _costOfCultivationTextEditingController.text =
        '${saveCropDetails.saveCropResponseModel.data?.loanMasterRequestPayload?.firstAmount}';

    // Ensure the value is a valid number before formatting
    final amount = saveCropDetails
        .saveCropResponseModel.data?.loanMasterRequestPayload?.firstAmount;

    if (amount != null) {
      _costOfCultivationTextEditingController.text =
          currencyFormatter.formatCurrency(amount);
    }
  }

  double roundToNearestHundred(double value) {
    return (value / 100).round() * 100;
  }

  List<Map<String, double>> calculateYearData(
    double firstAmount,
  ) {
    List<Map<String, double>> yearDataList = [];
    final loanPurposeCubit = context.read<LoanPurposeCubit>();

    double secondAmount = 0.0;
    double thirdAmount = 0.0;

    firstAmount = roundToNearestHundred(firstAmount);
    secondAmount = roundToNearestHundred(firstAmount / 10);
    thirdAmount = roundToNearestHundred(secondAmount + firstAmount / 10);

    loanPurposeCubit.updateModel(
        firstAmount: firstAmount.toString(),
        secondAmount: secondAmount.toString(),
        thirdAmount: thirdAmount.toString());
    return yearDataList;
  }

  CurrencyFormatter currencyFormatter = CurrencyFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const LoanApplyHeaderWidget(
              headerName: 'Crop Loan Form',
              pageNumber: 2,
              percentageFirst: 100,
              percentageSecond: 50,
              percentageThird: 0,
              percentageFourth: 0,
            ),
            const AppTextWidget(
              text: 'Loan Request',
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Loan Purpose',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: 'Cost of cultivation',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      labelText: 'Amount',
                      prefixIcon: Icons.currency_rupee,
                      showPrefixIcon: true,
                      keyboardType: TextInputType.number,
                      controller: _costOfCultivationTextEditingController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          if (value.isNotEmpty) {
                            double data =
                                double.tryParse(value.replaceAll(',', '')) ??
                                    0.0;
                            calculateYearData(data);
                            context
                                .read<LoanPurposeCubit>()
                                .updateModel(firstAmount: value);
                          } else {
                            context
                                .read<LoanPurposeCubit>()
                                .updateModel(firstAmount: "0");
                          }
                          context
                              .read<LoanPurposeCubit>()
                              .updateModel(firstAmount: value);
                        } else {
                          context
                              .read<LoanPurposeCubit>()
                              .updateModel(firstAmount: "0");
                        }

                        // Future.delayed(Duration(seconds: 2),(){
                        //   setDataLimit();
                        // });
                      },
                    ),
                    const PostHarvest(),
                    BlocBuilder<LoanPurposeCubit, LoanPurposeCubitModel>(
                      builder: (BuildContext context, state) {
                        double firstAmount = double.tryParse(
                                state.firstAmount!.replaceAll(',', '')) ??
                            0.0;

                        if (firstAmount >= 116000 && state.other == true) {
                          return CommonTextField(
                            labelText: 'Describe Other Security',
                            length: 20,
                            onChange: (value) {
                              context
                                  .read<LoanPurposeCubit>()
                                  .updateModel(otherDescription: value);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CommonButton(
                      buttonName: 'CANCEL',
                      buttonColor: Colors.transparent,
                      borderColor: AppColors.secondOutLineColor,
                      buttonTextColor: AppColors.transparentButtonTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BlocBuilder<LoanPurposeCubit, LoanPurposeCubitModel>(
                    builder:
                        (BuildContext context, LoanPurposeCubitModel state) {
                      if (state.firstAmount != null &&
                          state.firstAmount!.isNotEmpty) {
                        double firstAmount = double.tryParse(
                                state.firstAmount!.replaceAll(',', '')) ??
                            0.0;

                        if (firstAmount > 116000 &&
                            state.other == true &&
                            state.agriculture == true) {
                          return InkWell(
                            onTap: () {
                              @override
                              final lovsTypeData = [
                                "GENDER",
                                "IDPROOF",
                              ];

                              context.read<GetLovsTypeDataNewBloc>().add(
                                    GetLovsTypeDataNewList(
                                      bodyRequest: lovsTypeData,
                                    ),
                                  );

                              Navigator.pushNamed(
                                  context, LoanApplicant.routeName);
                            },
                            child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.next,
                            ),
                          );
                        } else if (firstAmount > 1) {
                          return InkWell(
                            onTap: () {
                              @override
                              final lovsTypeData = [
                                "GENDER",
                                "IDPROOF",
                              ];

                              context.read<GetLovsTypeDataNewBloc>().add(
                                    GetLovsTypeDataNewList(
                                      bodyRequest: lovsTypeData,
                                    ),
                                  );

                              Navigator.pushNamed(
                                  context, LoanApplicant.routeName);
                            },
                            child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.next,
                            ),
                          );
                        }
                      }

                      return CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                        buttonColor: AppColors.grayColor,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class PostHarvest extends StatefulWidget {
  const PostHarvest({super.key});

  @override
  State<PostHarvest> createState() => _PostHarvestState();
}

class _PostHarvestState extends State<PostHarvest> {
  final ValueNotifier<bool> _agricultural = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _other = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final loanPurposeCubit = context.watch<LoanPurposeCubit>();
    double firstAmount = double.tryParse(
            loanPurposeCubit.state.firstAmount!.replaceAll(',', '')) ??
        0.0;
    CurrencyFormatter currencyFormatter = CurrencyFormatter();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.currency_rupee),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.postHarvest,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  AppTextWidget(
                    text: currencyFormatter.formatCurrency(double.parse(
                        loanPurposeCubit.state.secondAmount ?? '0.0')),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.currency_rupee),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.farmMaintenance,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  AppTextWidget(
                    text: currencyFormatter.formatCurrency(double.parse(
                        loanPurposeCubit.state.thirdAmount ?? '0.0')),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      AppTextWidget(
                        text: AppLocalizations.of(context)!.hypoThecationOfCrop,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  if (firstAmount >= 116000)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppTextWidget(
                            text: AppLocalizations.of(context)!.securityOffered,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _agricultural,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return Checkbox(
                                  checkColor: Colors.white,
                                  value: _agricultural.value,
                                  onChanged: (bool? value) {
                                    _agricultural.value = value!;
                                    loanPurposeCubit.updateModel(
                                        agriculture: value);
                                  },
                                );
                              },
                            ),
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.agricultural,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: _other.value,
                              onChanged: (bool? value) {
                                _other.value = value!;
                                loanPurposeCubit.updateModel(other: value);
                              },
                            ),
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.other,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
