import 'package:ekisan_credit/bloc/loan_preview/loan_details_basic/loan_details_preview_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/about_laon_detail/about_laon_detail_cubit.dart';
import 'package:ekisan_credit/view/loan_apply/loan_preview/screens/loan_preview_joint_applicant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../../bloc/loan_preview/loan_asset_preview/laon_asset_preview_event.dart';
import '../../../../bloc/loan_preview/loan_asset_preview/loan_asset_preview_bloc.dart';
import '../../../../bloc/loan_preview/loan_details_basic/loan_details_preview_bloc.dart';
import '../../../../bloc/loan_preview/loan_details_basic/loan_details_preview_event.dart';
import '../../../../bloc/loan_preview/loan_guarantor_preview/loan_guarantor_preview_bloc.dart';
import '../../../../bloc/loan_preview/loan_guarantor_preview/loan_guarantor_preview_event.dart';
import '../../../../bloc/loan_preview/loan_preview_joint_applicant/loan_preview_joint_applicant_bloc.dart';
import '../../../../bloc/loan_preview/loan_preview_joint_applicant/loan_preview_joint_applicant_event.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/money_formater.dart';
import '../../widget/loan_apply_header.dart';
import 'accept_and_save_first_screen.dart';
import 'land_details_preview_screen.dart';
import 'others_details_preview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanPreviewScreen extends StatefulWidget {
  static const routeName = 'loan-preview-screen';

  const LoanPreviewScreen({super.key});

  @override
  State<LoanPreviewScreen> createState() => _LoanPreviewScreenState();
}

class _LoanPreviewScreenState extends State<LoanPreviewScreen> {
  late List<bool> _isExpanded;
  late List<bool> _isExpandedYear;

  CurrencyFormatter formatter = CurrencyFormatter();

  @override
  void initState() {
    final cropResponseData = context.read<SaveCropNewBloc>();
    final int loanId = cropResponseData
        .saveCropResponseModel.data!.userProposedDetails!.first.loanId;
    final bodyRequest = {"masterId": loanId};
    context.read<AboutLoanDetailCubit>().updateModel(loanId: loanId.toString());
    context
        .read<LoanDetailsNewPreviewBloc>()
        .add(GetLoanDetailsNewPreviewData(bodyRequest: bodyRequest));
    context
        .read<PreviewBasicsDetailsBloc>()
        .add(GetPreviewBasicsDetails(bodyRequest: bodyRequest));

    context
        .read<LoanDetailsNewBloc>()
        .add(GetNewLoanDetails(bodyRequest: bodyRequest));

    _isExpanded = List<bool>.filled(100, false);
    _isExpandedYear = List<bool>.filled(5, false);

    super.initState();
  }

  double roundToNearestHundred(double value) {
    return (value / 100).round() * 100;
  }

  List<Map<String, double>> calculateYearData(double firstAmount,
      double secondAmount, double thirdAmount, double totalAmount) {
    List<Map<String, double>> yearDataList = [];

    for (int i = 0; i < 5; i++) {
      yearDataList.add({
        "firstAmount": firstAmount,
        "secondAmount": secondAmount,
        "thirdAmount": thirdAmount,
        "totalAmount": totalAmount,
      });

      firstAmount = roundToNearestHundred(firstAmount * 1.1);
      secondAmount = roundToNearestHundred(secondAmount * 1.1);
      thirdAmount = roundToNearestHundred(thirdAmount * 1.1);
      totalAmount = firstAmount + secondAmount + thirdAmount;
    }

    return yearDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
              pageNumber: 5,
              percentageFirst: 100,
              percentageSecond: 100,
              percentageThird: 100,
              percentageFourth: 50,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.preview,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.greenColor,
                  child: Icon(Icons.add, color: AppColors.whiteColor),
                ),
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, LoanPreviewJointApplicant.routeName);
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.backgroundGreenLightColor,
                    child: Icon(Icons.group_add, color: AppColors.iconColor),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.backgroundGreenLightColor,
                  child: Icon(Icons.landscape_outlined,
                      color: AppColors.iconColor),
                ),
                SizedBox(
                  width: 16,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.backgroundGreenLightColor,
                  child: Icon(Icons.article, color: AppColors.iconColor),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<LoanDetailsNewPreviewBloc,
                    LoanDetailsNewPreviewState>(
                  builder:
                      (BuildContext context, LoanDetailsNewPreviewState state) {
                    if (state is LoanDetailsNewPreviewSuccess) {
                      double firstAmount = state
                          .loanDetailsNewPreviewResponseModel
                          .data
                          ?.loanDetailMapper
                          ?.firstAmount;
                      double secondAmount = state
                          .loanDetailsNewPreviewResponseModel
                          .data
                          ?.loanDetailMapper
                          ?.secondAmount;
                      double thirdAmount = state
                          .loanDetailsNewPreviewResponseModel
                          .data
                          ?.loanDetailMapper
                          ?.thirdAmount;
                      double totalAmount = state
                          .loanDetailsNewPreviewResponseModel
                          .data
                          ?.loanDetailMapper
                          ?.totalAmount;
                      List<Map<String, double>> yearDataList =
                          calculateYearData(
                        firstAmount,
                        secondAmount,
                        thirdAmount,
                        totalAmount,
                      );
                      return Column(
                        children: [
                           AppTextWidget(
                            text: AppLocalizations.of(context)!.kcc_CropLimitEligibility,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.cropDetails,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.loanDetailsNewPreviewResponseModel
                                .data?.cropDetailDtos?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final cropDetails = state
                                  .loanDetailsNewPreviewResponseModel
                                  .data
                                  ?.cropDetailDtos?[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          _isExpanded[index] =
                                              !_isExpanded[index];
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                text:
                                                    cropDetails?.cropName ?? '',
                                                fontSize:
                                                    AppTextSize.contentSize16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              AppTextWidget(
                                                text: cropDetails
                                                        ?.croppingSeasonName ??
                                                    '',
                                                fontSize:
                                                    AppTextSize.contentSize14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: _isExpanded[index],
                                      child: Container(
                                        color: AppColors.backGroundColor,
                                        child: Column(
                                          children: [
                                            Divider(
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.state,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: cropDetails
                                                            ?.stateName ??
                                                        '',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AppTextSize
                                                        .contentSize12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            /******* Family Consumption ********/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.district,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: cropDetails
                                                            ?.districtName ??
                                                        '',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AppTextSize
                                                        .contentSize12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            /******* Land Type  ********/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.landType,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text:
                                                        cropDetails?.landType ??
                                                            '',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AppTextSize
                                                        .contentSize12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                   AppTextWidget(
                                                    text: AppLocalizations.of(context)!.landSize,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: cropDetails?.area
                                                            .toString() ??
                                                        '',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AppTextSize
                                                        .contentSize12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.landSizeInAcre,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: cropDetails
                                                            ?.areaInAcre
                                                            .toString() ??
                                                        '',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: AppTextSize
                                                        .contentSize12,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                           Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!.yearWiseKccLimit,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.builder(
                            itemCount: yearDataList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              List<String> yearNames = [
                                AppLocalizations.of(context)!.firstYear,
                                AppLocalizations.of(context)!.secondYear,
                              AppLocalizations.of(context)!.thirdYear,
                              AppLocalizations.of(context)!.forthYear,
                              AppLocalizations.of(context)!.fifthYear,
                              ];

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        setState(() {
                                          _isExpandedYear[index] =
                                              !_isExpandedYear[index];
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppTextWidget(
                                            text: yearNames[index],
                                            fontSize: AppTextSize.contentSize16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: _isExpandedYear[index],
                                      child: Container(
                                        color: AppColors.backGroundColor,
                                        child: Column(
                                          children: [
                                            Divider(
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.productionLimit,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 18,
                                                      ),
                                                      AppTextWidget(
                                                        text: yearDataList[
                                                                    index]
                                                                ["firstAmount"]
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AppTextSize
                                                            .contentSize12,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            /******* Family Consumption ********/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.familyConsumption,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 18,
                                                      ),
                                                      AppTextWidget(
                                                        text: yearDataList[
                                                                    index]
                                                                ["secondAmount"]
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AppTextSize
                                                            .contentSize12,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            /******* Farm Maintance  ********/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 32, right: 40, top: 32),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.farmMaintenance,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 18,
                                                      ),
                                                      AppTextWidget(
                                                        text: yearDataList[
                                                                    index]
                                                                ["thirdAmount"]
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AppTextSize
                                                            .contentSize12,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                            /******* Total ********/

                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 17),
                                              child: Divider(
                                                height: 1,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 32,
                                                right: 40,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppTextWidget(
                                                    text: AppLocalizations.of(context)!.total,
                                                    fontSize: AppTextSize
                                                        .contentSize16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        size: 18,
                                                      ),
                                                      AppTextWidget(
                                                        text: yearDataList[
                                                                    index]
                                                                ["totalAmount"]
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: AppTextSize
                                                            .contentSize12,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                           AppTextWidget(
                            text: AppLocalizations.of(context)!.basicDetails,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.applicationType,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  AppTextWidget(
                                    text: state
                                            .loanDetailsNewPreviewResponseModel
                                            .data
                                            ?.loanDetailMapper
                                            ?.loanPurpose ??
                                        '',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child:  AppTextWidget(
                                      text:
                                          AppLocalizations.of(context)!.whetherCoveredUnder,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  AppTextWidget(
                                    text: state
                                            .loanDetailsNewPreviewResponseModel
                                            .data
                                            ?.loanDetailMapper
                                            ?.covered ??
                                        '',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                               Align(
                                alignment: Alignment.centerLeft,
                                child: AppTextWidget(
                                  text: AppLocalizations.of(context)!.yourPreferredBankToApplyKccLoan,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.bankType,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: state
                                              .loanDetailsNewPreviewResponseModel
                                              .data
                                              ?.loanDetailMapper
                                              ?.bankType ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.stateName,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: state
                                              .loanDetailsNewPreviewResponseModel
                                              .data
                                              ?.loanDetailMapper
                                              ?.stateName ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.districtName,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: state
                                              .loanDetailsNewPreviewResponseModel
                                              .data
                                              ?.loanDetailMapper
                                              ?.districtName ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.bankName,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: state
                                              .loanDetailsNewPreviewResponseModel
                                              .data
                                              ?.loanDetailMapper
                                              ?.bankName ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.branchName,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppTextWidget(
                                      text: state
                                              .loanDetailsNewPreviewResponseModel
                                              .data
                                              ?.loanDetailMapper
                                              ?.entityLevelName ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              if (state.loanDetailsNewPreviewResponseModel.data
                                      ?.loanDetailMapper?.pacsLevelName !=
                                  null)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextWidget(
                                            text: AppLocalizations.of(context)!.pacsName,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppTextWidget(
                                            text: state
                                                    .loanDetailsNewPreviewResponseModel
                                                    .data
                                                    ?.loanDetailMapper
                                                    ?.pacsLevelName ??
                                                '',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 24,
                              ),
                              const LoanPreviewJointApplicant(),
                               AppTextWidget(
                                text: AppLocalizations.of(context)!.loanPurpose,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.currency_rupee),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.costOfCultivation,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: formatter.formatCurrency(state
                                            .loanDetailsNewPreviewResponseModel
                                            .data
                                            ?.loanDetailMapper
                                            ?.firstAmount),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.currency_rupee),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.postHarvest,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: formatter.formatCurrency(state
                                            .loanDetailsNewPreviewResponseModel
                                            .data!
                                            .loanDetailMapper!
                                            .secondAmount),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.currency_rupee),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.farmMaintenance,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: formatter.formatCurrency(state
                                            .loanDetailsNewPreviewResponseModel
                                            .data!
                                            .loanDetailMapper!
                                            .thirdAmount),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.currency_rupee),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Row(
                                         children: [
                                           Expanded(
                                             child: AppTextWidget(
                                              text:
                                                  AppLocalizations.of(context)!.kccLimitForFirstYear,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                                                                   ),
                                           ),
                                         ],
                                       ),
                                      AppTextWidget(
                                        text: formatter.formatCurrency(state
                                            .loanDetailsNewPreviewResponseModel
                                            .data
                                            ?.loanDetailMapper
                                            ?.totalAmount),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const LandDetailsPreviewScreen(),
                              const SizedBox(
                                height: 24,
                              ),
                              /******** Other Details *****************/
                              const OtherDetailsPreview(),
                            ],
                          )
                        ],
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AcceptAndSaveFirstScreen.routeName,
                    );
                  },
                  child: CommonButton(
                    buttonName: AppLocalizations.of(context)!.next,
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
