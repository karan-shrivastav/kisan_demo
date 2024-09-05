import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/cubit/apply_laon/kcc_limit_cubit.dart';
import 'package:ekisan_credit/cubit/model/kcc_limit_model.dart';
import 'package:ekisan_credit/services/toast_alert.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/loan_apply/screen/edit_crop_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/land_details/screen/land_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_bloc.dart';
import '../../../../../bloc/apply_loan_save_crop/save_crop_event.dart';
import '../../../../../common_button.dart';
import '../../../../../cubit/apply_laon/add_crop_list_cubit.dart';
import '../../../../../cubit/incomplete_loan/incomplete_loan_cubit.dart';
import '../../../../../cubit/model/add_crop_cubit_model.dart';
import '../../../../../cubit/model/incomplete_loan_cubit_model.dart';
import '../../../../../model/response/loan_basic_response_model.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../../widgets/incomplete_add_crop_screen.dart';

class IncompleteCropLoanFromCropDetailsScreen extends StatefulWidget {
  static const routeName = "incomplete-crop-loan-form-crop-details";

  const IncompleteCropLoanFromCropDetailsScreen({super.key});

  @override
  State<IncompleteCropLoanFromCropDetailsScreen> createState() =>
      _IncompleteCropLoanFromCropDetailsScreenState();
}

class _IncompleteCropLoanFromCropDetailsScreenState
    extends State<IncompleteCropLoanFromCropDetailsScreen> {
  // Boolean list to track the visibility of content
  late List<bool> _isExpanded;
  List<AddNewCropCubitModel> cropList = [];
  List<AddNewCropCubitModel> cropListData = [];
  List<CropDetailDto>? cropDetailDtos = [];

  String? incompleteLoanId = '';

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
    AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  Future<void> getLoanId() async {
    incompleteLoanId = await getIncompleteLoanId();
    ToastAlert('Loan Id :$incompleteLoanId');
  }

  @override
  void initState() {
    getLoanId();
    final kccLimit = context.read<KccLimitCubit>();
    super.initState();
    // Initialize the visibility list according to your item count
    _isExpanded = List<bool>.filled(
        kccLimit.state.length, false); // Adjust the count as needed
  }

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const LoanApplyHeaderWidget(
              headerName: 'Crop Loan Form',
              percentageFirst: 50,
            ),
            const AppTextWidget(
              text: "Basic Details",
              fontSize: AppTextSize.contentSize24,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppTextWidget(
                  text: "Crop Details ",
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
                            return const IncompleteAddCropScreen();
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<IncompleteLoanInfoCubit,
                              IncompleteLoanCubitModel>(
                            builder: (context, crops) {
                              return ListView.builder(
                                itemCount: crops.cropDetailDto?.length,
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
                                        text: crops.cropDetailDto?[index]
                                                .cropName ??
                                            '',
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          context
                                              .read<AddNewCropCubit>()
                                              .deleteCrop(index);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      subtitle: AppTextWidget(
                                        text: crops.cropDetailDto?[index]
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
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LandDetailScreen.routeName);
                                  },
                                  child: const AppTextWidget(
                                    text: "Elig. KCC Limit For All Five Years",
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
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppTextWidget(
                                                text: "First Year",
                                                fontSize:
                                                    AppTextSize.contentSize16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              Icon(Icons.arrow_drop_down)
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
                                                      const AppTextWidget(
                                                        text:
                                                            "Production Limit",
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
                                                      const AppTextWidget(
                                                        text:
                                                            "Family Consumption",
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
                                                      const AppTextWidget(
                                                        text: "Farm Maintance",
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
                                                      const AppTextWidget(
                                                        text: "Total",
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
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CommonButton(
                      buttonName: "Back",
                      borderColor: AppColors.grayColor,
                      buttonColor: Colors.transparent,
                      buttonTextColor: AppColors.textBlackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // if (saveCropNewState
                      // is SaveCropNewSuccess) {
                      //   print(saveCropNewState
                      //       .saveCropResponseModel
                      //       .data
                      //       ?.userProposedDetails
                      //       ?.first
                      //       .id);
                      // }

                      final incompleteLoanInfoCubit =
                          context.read<IncompleteLoanInfoCubit>().state;
                      Future<String?> getFarmerId() async {
                        AppSharedPreferenceHelper appSharedPreferenceHelper =
                            AppSharedPreferenceHelper();
                        return appSharedPreferenceHelper
                            .getCustomerData('farmerId');
                      }

                      String farmerId = await getFarmerId() ?? '';

                      final requestBody = {
                        "loanMasterRequestPayload": {
                          "farmerId": farmerId,
                          "productMasterId": 1,
                          "id": incompleteLoanId,
                          "firstAmount": 27900,
                          "secondAmount": 2800,
                          "thirdAmount": 5600,
                          "totalAmount": 36300,
                          "loanPurpose": "purposed not set",
                          "covered": "yes",
                          "bankMasterId": incompleteLoanInfoCubit.bankMasterId,
                          "entityLevelId":
                              incompleteLoanInfoCubit.entityLevelId,
                          "stateId": incompleteLoanInfoCubit.stateId,
                          "districtId": incompleteLoanInfoCubit.districtId,
                          // "pacsLevelId": packsBankName.contains("Co-Operative")
                          //     ? _selectedPacs!.id
                          //     : null
                          "pacsLevelId": ""
                        },
                        // if (saveCropNewState
                        // is SaveCropNewSuccess)
                        "userProposedDetails": [
                          for (int i = 0;
                              i < incompleteLoanInfoCubit.cropDetailDto!.length;
                              i++) // Assuming proposedCropDto contains the data
                            {
                              "id":
                                  incompleteLoanInfoCubit.cropDetailDto?[i].id,
                              "croppingSeasonId": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].croppingSeasonId,
                              "areaUnitId": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].areaUnitId,
                              "area": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].area,
                              "areaInAcre": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].areaInAcre,
                              "landType": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].landType,
                              "acreAmount": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].acreAmount,
                              // Assuming this value is constant or from somewhere else
                              "bankSofId": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].bankSofId,
                              "cropName": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].cropName,
                              "landTypeId": incompleteLoanInfoCubit
                                  .cropDetailDto?[i].landTypeId
                            }
                        ]
                        // else
                        //   "userProposedDetails": [
                        //     for (var crop in state) // Assuming proposedCropDto contains the data
                        //       {
                        //         "id": "",
                        //         "croppingSeasonId":
                        //         crop.croppingSeasonId,
                        //         "areaUnitId": crop.areaUnitId,
                        //         "area": 1,
                        //         "areaInAcre": crop.totalInAcre,
                        //         "landType": crop.landTypeName,
                        //         "acreAmount": crop.mainAmount,
                        //         // Assuming this value is constant or from somewhere else
                        //         "bankSofId": crop.cropId,
                        //         "cropName": crop.cropName,
                        //         "landTypeId": crop.landTypeId
                        //       }
                        //   ]
                      };
                      print('77777777777777777777777777777777777777777777777');
                      print('77777777777777777777777777777777777777777777777');
                      print('MapData :${requestBody}');
                      print('77777777777777777777777777777777777777777777777');
                      print('77777777777777777777777777777777777777777777777');

                      WidgetsBinding.instance.addPostFrameCallback(
                        (timeStamp) {
                          context.read<SaveCropNewBloc>().add(
                                SaveCropNew(requestBody: requestBody),
                              );
                        },
                      );
                    },
                    // onTap: (){
                    //   Navigator.pushNamed(
                    //       context,
                    //       IncompleteLoanPurpose
                    //           .routeName);
                    // },
                    child: const CommonButton(
                      buttonName: "Next",
                      buttonColor: AppColors.greenColor,
                    ),
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
