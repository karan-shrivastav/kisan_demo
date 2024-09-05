import 'package:ekisan_credit/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../cubit/apply_laon/add_crop_cubit.dart';
import '../../../../../cubit/loan_purpose/loan_purpose_cubit.dart';
import '../../../../../cubit/model/laon_purpose_cubit_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/money_formater.dart';
import '../../../../../utils/text_input_formate.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../../../loan_request/loan_applicant/loan_applicant.dart';
import '../../incomplete_applicant/screens/incomplete_loan_applicant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteLoanPurpose extends StatefulWidget {
  static const routeName = "incomplete-loan-purpose";
  const IncompleteLoanPurpose({super.key});

  @override
  State<IncompleteLoanPurpose> createState() => _IncompleteLoanPurposeState();
}

class _IncompleteLoanPurposeState extends State<IncompleteLoanPurpose> {
  bool isHypothecationChecked = false;
  bool isAgriculturalChecked = false;
  bool isOtherChecked = false;

  final TextEditingController _costOfCultivationTextEditingController =
      TextEditingController();

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  @override
  void initState() {
    final saveCropDetails = context.read<SaveCropNewBloc>();
    _costOfCultivationTextEditingController.text =
        '${saveCropDetails.saveCropResponseModel.data?.loanMasterRequestPayload?.firstAmount}';
    super.initState();
  }

  List<String> limitRate = [
    "1",
    "1.1",
    "1.21",
    "1.331",
    "1.46410",
  ];

  void setDataLimit() {
    final addCropInObject = context.read<AddCropCubit>().state;
    final loanPurposeCubit = context.read<LoanPurposeCubit>();

    double amt1 = 0;
    double amt2 = 0;
    double amt3 = 0;
    double amt4 = 0;

    double? mainAmount = addCropInObject.mainAmount;
    String totalInAcre = "1";
    amt1 = amt1 +
        (((mainAmount! *
                        double.parse(totalInAcre) *
                        double.parse(limitRate[0])) /
                    100)
                .round() *
            100);
    amt2 = amt2 +
        (((0.1 *
                        mainAmount *
                        double.parse(totalInAcre) *
                        double.parse(limitRate[0])) /
                    100)
                .round() *
            100);
    amt3 = amt3 +
        (((0.2 *
                        mainAmount *
                        double.parse(totalInAcre) *
                        double.parse(limitRate[0])) /
                    100)
                .round() *
            100);
    amt4 = amt4 +
        (((1.3 *
                        mainAmount *
                        double.parse(totalInAcre) *
                        double.parse(limitRate[0])) /
                    100)
                .round() *
            100);

    TextEditingController prLimit =
        TextEditingController(text: amt1.toStringAsFixed(2));
    TextEditingController fmCom =
        TextEditingController(text: amt2.toStringAsFixed(2));
    TextEditingController farmMan =
        TextEditingController(text: amt3.toStringAsFixed(2));
    TextEditingController total =
        TextEditingController(text: amt4.toStringAsFixed(2));

    String fAmt = '${double.parse(prLimit.text.replaceAll(',', ''))}';
    prLimit.value = TextEditingValue(
        text: fAmt,
        selection: TextSelection.collapsed(
          offset: fAmt.length,
        ));

    String sAmt = '${double.parse(fmCom.text.replaceAll(',', ''))}';

    fmCom.value = TextEditingValue(
        text: sAmt,
        selection: TextSelection.collapsed(
          offset: sAmt.length,
        ));

    String tAmt = '${double.parse(farmMan.text.replaceAll(',', ''))}';
    farmMan.value = TextEditingValue(
        text: tAmt,
        selection: TextSelection.collapsed(
          offset: tAmt.length,
        ));

    String fourthAmt = '${double.parse(total.text.replaceAll(',', ''))}';
    total.value = TextEditingValue(
        text: fourthAmt,
        selection: TextSelection.collapsed(
          offset: fourthAmt.length,
        ));

    loanPurposeCubit.updateModel(
        firstAmount: prLimit.text,
        secondAmount: fmCom.text,
        thirdAmount: farmMan.text);
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

  @override
  Widget build(BuildContext context) {
    final saveCropDetails = context.read<SaveCropNewBloc>();
    final loanPurposeCubit = context.watch<LoanPurposeCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
              headerName:  AppLocalizations.of(context)!.cropLoanForm,
              pageNumber: 2,
              percentageFirst: 100,
              percentageSecond: 50,
              percentageThird: 0,
              percentageFourth: 0,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.loanRequest,
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
                     Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text:AppLocalizations.of(context)!.loanPurpose,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                     Align(
                      alignment: Alignment.centerLeft,
                      child: AppTextWidget(
                        text: AppLocalizations.of(context)!.costOfCultivation,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CommonTextField(
                      controller: _costOfCultivationTextEditingController,
                      labelText:AppLocalizations.of(context)!.amount,
                      prefixIcon: Icons.currency_rupee,
                      showPrefixIcon: true,
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
                    const SizedBox(
                      height: 8,
                    ),
                    const PostHarvest(),
                     CommonTextField(
                      labelText: AppLocalizations.of(context)!.describeOtherSecurity,
                      prefixIcon: Icons.currency_rupee,
                      showPrefixIcon: true,
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
                      Navigator.of(context).pop();
                    },
                    child:  CommonButton(
                      buttonName: AppLocalizations.of(context)!.cancell,
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
                            child:  CommonButton(
                              buttonName: AppLocalizations.of(context)!.next,
                            ),
                          );
                        } else if (firstAmount > 1) {
                          return InkWell(
                            onTap: () {
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
                                  context, IncompleteLoanApplicant.routeName);
                            },
                            child:  CommonButton(
                              buttonName: AppLocalizations.of(context)!.next,
                            ),
                          );
                        }
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
                    text:AppLocalizations.of(context)!.postHarvest,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 7),
                child: Icon(Icons.currency_rupee),
              ),
              const SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   AppTextWidget(
                    text: AppLocalizations.of(context)!.farmMaintance,
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
