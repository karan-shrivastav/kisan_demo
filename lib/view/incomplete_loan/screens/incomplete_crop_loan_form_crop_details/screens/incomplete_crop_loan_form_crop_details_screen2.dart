import 'package:ekisan_credit/bloc/apply_loan_save_crop/save_crop_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/cubit/about_laon_detail/about_laon_detail_cubit.dart';
import 'package:ekisan_credit/cubit/apply_laon/kcc_limit_cubit.dart';
import 'package:ekisan_credit/cubit/incomplete_loan/incomplete_loan_cubit.dart';
import 'package:ekisan_credit/cubit/loan_purpose/loan_purpose_cubit.dart';
import 'package:ekisan_credit/cubit/model/kcc_limit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/loan_apply/screen/edit_crop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_event.dart';
import '../../../../../cubit/apply_laon/add_crop_list_cubit.dart';
import '../../../../../cubit/model/add_crop_cubit_model.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_add_crop/screens/incomplete_add_crop_screen2.dart';
import '../../incomplete_loan_purpose/screens/incomplete_loan_purpose_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFromCropDetailsScreen2 extends StatefulWidget {
  static const routeName = "crop-loan-form-crop-details-second";

  const CropLoanFromCropDetailsScreen2({super.key});

  @override
  State<CropLoanFromCropDetailsScreen2> createState() =>
      _CropLoanFromCropDetailsScreen2State();
}

class _CropLoanFromCropDetailsScreen2State
    extends State<CropLoanFromCropDetailsScreen2> {
  // Boolean list to track the visibility of content
  late List<bool> _isExpanded;
  List<String> limitRate = [
    "1",
    "1.1",
    "1.21",
    "1.331",
    "1.46410",
  ];

  @override
  void initState() {
    final kccLimit = context.read<KccLimitCubit>();
    kccLimit.clearAllData();
    setDataLimit();
    // Initialize the visibility list according to your item count
    _isExpanded = List<bool>.filled(5, false); // Adjust the count as needed
    super.initState();
  }

  void setDataLimit() {
    final addCropList = context.read<AddNewCropCubit>();
    final kccLimitCubit = context.read<KccLimitCubit>();
    for (int i = 0; i < 5; i++) {
      double amt1 = 0;
      double amt2 = 0;
      double amt3 = 0;
      double amt4 = 0;
      for (int index = 0; index < addCropList.state.length; index++) {
        double? mainAmount = addCropList.state[index].mainAmount;

        amt1 = amt1 +
            (((addCropList.state[index].mainAmount! *
                            double.parse(
                                addCropList.state[index].totalInAcre ?? '0') *
                            double.parse(limitRate[i])) /
                        100)
                    .round() *
                100);
        amt2 = amt2 +
            (((0.1 *
                            mainAmount! *
                            double.parse(
                                addCropList.state[index].totalInAcre ?? '0') *
                            double.parse(limitRate[i])) /
                        100)
                    .round() *
                100);
        amt3 = amt3 +
            (((0.2 *
                            mainAmount *
                            double.parse(
                                addCropList.state[index].totalInAcre ?? '0') *
                            double.parse(limitRate[i])) /
                        100)
                    .round() *
                100);
        amt4 = amt4 +
            (((1.3 *
                            mainAmount *
                            double.parse(
                                addCropList.state[index].totalInAcre ?? '0') *
                            double.parse(limitRate[i])) /
                        100)
                    .round() *
                100);
      }
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

      kccLimitCubit.addCrop(KccCubitModel(
          productionLimit: prLimit.text,
          familyConsumption: fmCom.text,
          farmMaintenance: farmMan.text,
          total: total.text));
    }
  }

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
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
              percentageFirst: 100,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.basicDetails,
              fontSize: AppTextSize.contentSize24,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 AppTextWidget(
                  text: AppLocalizations.of(context)!.cropDetails,
                  fontSize: AppTextSize.contentSize22,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    // isExtended: true,
                    backgroundColor: AppColors.greenColor,
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return const AddCropScreen2();
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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //  Center(
                  //   child: AppTextWidget(text: "Please Add At least 1 Crop!",
                  //   fontWeight: FontWeight.w400,
                  //     fontSize: AppTextSize.contentSize22,
                  //   ),
                  // ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<AddNewCropCubit,
                              List<AddNewCropCubitModel>>(
                            builder: (context, cropsData) {
                              return ListView.builder(
                                itemCount: cropsData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            return const EditCropScreen();
                                          });
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: AppTextWidget(
                                        text: cropsData[index].cropName ?? '',
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          context
                                              .read<AddNewCropCubit>()
                                              .deleteCrop(index);
                                          context
                                              .read<KccLimitCubit>()
                                              .clearAllData();
                                          setDataLimit();
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      subtitle: AppTextWidget(
                                        text: cropsData[index]
                                                .croppingSeasonName ??
                                            '',
                                        fontSize: AppTextSize.contentSize14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child:  AppTextWidget(
                                    text:AppLocalizations.of(context)!.eligKccLimitForAllFiveYears ,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppTextSize.contentSize22,
                                  ),
                                ),
                              )
                            ],
                          ),
                          BlocBuilder<KccLimitCubit, List<KccCubitModel>>(
                            builder: (BuildContext context,
                                List<KccCubitModel> state) {
                              return ListView.builder(
                                itemCount: state.length,
                                physics: const NeverScrollableScrollPhysics(),
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
                                              _isExpanded[index] =
                                                  !_isExpanded[index];
                                            });
                                          },
                                          child:  Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppTextWidget(
                                                text: yearNames[index],
                                                fontSize:
                                                    AppTextSize.contentSize16,
                                                fontWeight: FontWeight.w400,
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
                                                const Divider(
                                                  height: 1,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32, right: 40),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                       AppTextWidget(
                                                        text:
                                                        AppLocalizations.of(context)!.productionLimit,
                                                        fontSize: AppTextSize
                                                            .contentSize16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .currency_rupee,
                                                            size: 18,
                                                          ),
                                                          AppTextWidget(
                                                            text: state[index]
                                                                    .productionLimit ??
                                                                '',
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32,
                                                          right: 40,
                                                          top: 32),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                       AppTextWidget(
                                                        text:
                                                        AppLocalizations.of(context)!.familyConsumption,
                                                        fontSize: AppTextSize
                                                            .contentSize16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .currency_rupee,
                                                            size: 18,
                                                          ),
                                                          AppTextWidget(
                                                            text: state[index]
                                                                    .familyConsumption ??
                                                                '',
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 32,
                                                          right: 40,
                                                          top: 32),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                       AppTextWidget(
                                                        text: AppLocalizations.of(context)!.farmMaintance,
                                                        fontSize: AppTextSize
                                                            .contentSize16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .currency_rupee,
                                                            size: 18,
                                                          ),
                                                          AppTextWidget(
                                                            text: state[index]
                                                                    .farmMaintenance ??
                                                                '',
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

                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 17),
                                                  child: Divider(
                                                    height: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .currency_rupee,
                                                            size: 18,
                                                          ),
                                                          AppTextWidget(
                                                            text: state[index]
                                                                    .total ??
                                                                '',
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
                                                const SizedBox(
                                                  height: 16,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:  CommonButton(
                            buttonName: AppLocalizations.of(context)!.back,
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
                        child: BlocBuilder<AddNewCropCubit,
                            List<AddNewCropCubitModel>>(
                          builder: (BuildContext context,
                              List<AddNewCropCubitModel> state) {
                            if (state.isNotEmpty) {
                              return BlocConsumer<SaveCropNewBloc,
                                  SaveCropNewState>(
                                builder: (BuildContext context,
                                    SaveCropNewState saveCropNewState) {
                                  return InkWell(
                                    onTap: () async {
                                      if (saveCropNewState
                                          is SaveCropNewSuccess) {
                                        print(saveCropNewState
                                            .saveCropResponseModel
                                            .data
                                            ?.userProposedDetails
                                            ?.first
                                            .id);
                                      }

                                      final kccLimitCubit =
                                          context.read<KccLimitCubit>().state;
                                      final incompleteLoanInfoCubit = context
                                          .read<IncompleteLoanInfoCubit>()
                                          .state;
                                      Future<String?> getFarmerId() async {
                                        AppSharedPreferenceHelper
                                            appSharedPreferenceHelper =
                                            AppSharedPreferenceHelper();
                                        return appSharedPreferenceHelper
                                            .getCustomerData('farmerId');
                                      }

                                      String farmerId =
                                          await getFarmerId() ?? '';

                                      String? loanId =
                                          await getIncompleteLoanId();
                                      final requestBody = {
                                        "loanMasterRequestPayload": {
                                          "farmerId": farmerId,
                                          "productMasterId": 1,
                                          "id": loanId,
                                          "firstAmount": kccLimitCubit
                                              .first.productionLimit,
                                          "secondAmount": kccLimitCubit
                                              .first.familyConsumption,
                                          "thirdAmount": kccLimitCubit
                                              .first.farmMaintenance,
                                          "totalAmount":
                                              kccLimitCubit.first.total,
                                          "loanPurpose": "New",
                                          "covered": "Yes",
                                          "bankMasterId":
                                              incompleteLoanInfoCubit
                                                  .bankMasterId,
                                          "entityLevelId":
                                              incompleteLoanInfoCubit
                                                  .entityLevelId,
                                          "stateId":
                                              incompleteLoanInfoCubit.stateId,
                                          "districtId": incompleteLoanInfoCubit
                                              .districtId,
                                          "pacsLevelId": " ",
                                          "whereToApply": "",
                                        },
                                        if (saveCropNewState
                                            is SaveCropNewSuccess)
                                          "userProposedDetails": [
                                            for (int i = 0;
                                                i <
                                                    saveCropNewState
                                                        .saveCropResponseModel
                                                        .data!
                                                        .userProposedDetails!
                                                        .length;
                                                i++) // Assuming proposedCropDto contains the data
                                              {
                                                "id": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .id,
                                                "croppingSeasonId":
                                                    saveCropNewState
                                                        .saveCropResponseModel
                                                        .data!
                                                        .userProposedDetails?[i]
                                                        .croppingSeasonId,
                                                "areaUnitId": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .areaUnitId,
                                                "area": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .area,
                                                "areaInAcre": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .areaInAcre,
                                                "landType": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .landType,
                                                "acreAmount": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .acreAmount,
                                                "bankSofId": 1,
                                                "cropName": saveCropNewState
                                                    .saveCropResponseModel
                                                    .data!
                                                    .userProposedDetails?[i]
                                                    .cropName,
                                                "landTypeId":
                                                    '${saveCropNewState.saveCropResponseModel.data!.userProposedDetails?[i].landTypeId}'
                                              }
                                          ]
                                        else
                                          "userProposedDetails": [
                                            for (var crop
                                                in state) // Assuming proposedCropDto contains the data
                                              {
                                                "id": "",
                                                "croppingSeasonId":
                                                    crop.croppingSeasonId,
                                                "areaUnitId": crop.areaUnitId,
                                                "area": 1,
                                                "areaInAcre": crop.totalInAcre,
                                                "landType": crop.landTypeName,
                                                "acreAmount": crop.mainAmount,
                                                // Assuming this value is constant or from somewhere else
                                                "bankSofId": 1,
                                                "cropName": crop.cropName,
                                                "landTypeId":
                                                    '${crop.landTypeId}'
                                              }
                                          ]
                                      };

                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                        (timeStamp) {
                                          context.read<SaveCropNewBloc>().add(
                                                SaveCropNew(
                                                    requestBody: requestBody),
                                              );
                                        },
                                      );
                                    },
                                    child:  CommonButton(
                                      buttonName: AppLocalizations.of(context)!.save,
                                    ),
                                  );
                                },
                                listener: (BuildContext context,
                                    SaveCropNewState state) {
                                  if (state is SaveCropNewSuccess) {
                                    final loanPurposeCubit =
                                        context.read<LoanPurposeCubit>();
                                    final aboutLoanDetail =
                                        context.read<AboutLoanDetailCubit>();
                                    loanPurposeCubit.updateModel(
                                        firstAmount: state
                                            .saveCropResponseModel
                                            .data
                                            ?.loanMasterRequestPayload
                                            ?.firstAmount
                                            .toString(),
                                        secondAmount: state
                                            .saveCropResponseModel
                                            .data
                                            ?.loanMasterRequestPayload
                                            ?.secondAmount
                                            .toString(),
                                        thirdAmount: state
                                            .saveCropResponseModel
                                            .data
                                            ?.loanMasterRequestPayload
                                            ?.thirdAmount
                                            .toString(),
                                        masterId: state
                                            .saveCropResponseModel
                                            .data
                                            ?.loanMasterRequestPayload
                                            ?.id);
                                    aboutLoanDetail.updateModel(
                                        loanId:
                                            '${state.saveCropResponseModel.data?.loanMasterRequestPayload?.id}');

                                    // context.read<LoanPurposeCubit>().updateModel(
                                    //   firstAmount:
                                    // );
                                    // Navigator.pushNamed(
                                    //     context, LandDetailScreen.routeName);
                                    Navigator.pushNamed(context,
                                        IncompleteLoanPurpose.routeName);
                                  }
                                },
                              );
                            }

                            return  CommonButton(
                              buttonName: AppLocalizations.of(context)!.save,
                              buttonColor: AppColors.grayColor,
                            );
                          },
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
          ],
        ),
      ),
    );
  }
}
