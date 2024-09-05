import 'package:ekisan_credit/bloc/save_land_details/save_land_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/add_land/add_land_cubit.dart';
import 'package:ekisan_credit/cubit/loan_purpose/loan_purpose_cubit.dart';
import 'package:ekisan_credit/view/loan_apply/screen/other_details/screen/other_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/delete_land/delete_land_bloc.dart';
import '../../../../../bloc/delete_land/delete_land_data_event.dart';
import '../../../../../bloc/delete_land/delete_land_data_state.dart';
import '../../../../../bloc/get_land_details/get_land_details_bloc.dart';
import '../../../../../bloc/get_land_details/get_land_details_event.dart';
import '../../../../../bloc/get_land_details/get_land_details_state.dart';
import '../../../../../bloc/save_land_details/save_land_details_bloc.dart';
import '../../../../../bloc/save_land_details/save_land_details_event.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../../../cubit/add_land/edit_land_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/text_input_formate.dart';
import '../../../widget/loan_apply_header.dart';
import '../../add_crop_screen.dart';
import '../widget/crop_laon_form_add_land_widget.dart';
import '../widget/crop_loan_form_edit_land_details_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandDetailScreen extends StatefulWidget {
  static const routeName = "land-details";

  const LandDetailScreen({super.key});

  @override
  State<LandDetailScreen> createState() => _LandDetailScreenState();
}

class _LandDetailScreenState extends State<LandDetailScreen> {
  @override
  void didChangeDependencies() {
    context.read<GetLandDataBloc>().add(GetLandListData(landRequest: const {}));
    super.didChangeDependencies();
  }

  List selectedLand = [];

  final TextEditingController _totalMarketValue = TextEditingController();

  final ValueNotifier<bool> _isFilledMarketValue = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
              percentageFirst: 50,
              pageNumber: 2,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.landDetails,
              fontSize: AppTextSize.contentSize24,
              fontWeight: FontWeight.w400,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       AppTextWidget(
                        text: AppLocalizations.of(context)!.landDetails,
                        fontSize: AppTextSize.contentSize22,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: FloatingActionButton(
                          // isExtended: true,
                          child: Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                          backgroundColor: AppColors.greenColor,
                          onPressed: () {
                            context.read<AddLandCubit>().clearData();
                            context
                                .read<AddLandIrrigatedNonIrrigatedCubit>()
                                .clearAllData();

                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const CropLandFromAddLandWidget();
                                });
                          },
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title:  AppTextWidget(
                            text: AppLocalizations.of(context)!.selectAll,
                          ),
                          leading: Checkbox(
                            checkColor: Colors.white,
                            value: true,
                            onChanged: (bool? value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Column(
                        children: [
                          BlocConsumer<GetLandDataBloc, GetLandDataState>(
                            builder: (BuildContext context, state) {
                              if (state is GetLandDataSuccess) {
                                return ListView.builder(
                                  itemCount: state.getLandResponseModel.data
                                      ?.content?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: InkWell(
                                        onTap: () {
                                          context.read<EditLandCubit>().updateModel(
                                              id: state.getLandResponseModel
                                                  .data?.content?[index].id,
                                              stateName: state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .stateName ??
                                                  '',
                                              stateMasterId: state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .stateMasterId ??
                                                  0,
                                              districtName: state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .districtName ??
                                                  '',
                                              districtMasterId: state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .districtMasterId ??
                                                  0,
                                              villageId: state.getLandResponseModel.data?.content?[index].districtMasterId ?? 0,
                                              villageName: state.getLandResponseModel.data?.content?[index].villageName ?? '',
                                              surveyNo: state.getLandResponseModel.data?.content?[index].surveyNo ?? '',
                                              areaUnitId: state.getLandResponseModel.data?.content?[index].areaUnit?.id ?? 0,
                                              areaUnitName: state.getLandResponseModel.data?.content?[index].areaUnitName,
                                              area: '${state.getLandResponseModel.data?.content?[index].area}',
                                              sourceOfIrrigationId: state.getLandResponseModel.data?.content?[index].sourceOfIrrigation?.id ?? 0,
                                              sourceOfIrrigationNAme: state.getLandResponseModel.data?.content?[index].sourceOfIrrigationName ?? '',
                                              ownershipId: state.getLandResponseModel.data?.content?[index].ownershipId ?? 0,
                                              ownerShipName: state.getLandResponseModel.data?.content?[index].ownershipName ?? '',
                                              encumbered: state.getLandResponseModel.data?.content?[index].encumbered,
                                              irrigatedLand: state.getLandResponseModel.data?.content?[index].irrigatedLand ?? 0,
                                              unIrrigatedLand: state.getLandResponseModel.data?.content?[index].unIrrigatedLand ?? 0.0);

                                          showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return const CropLoanFormEditLandDetails();
                                              });
                                        },
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: AppTextWidget(
                                            text: state
                                                    .getLandResponseModel
                                                    .data
                                                    ?.content?[index]
                                                    .surveyNo ??
                                                '',
                                          ),
                                          subtitle: AppTextWidget(
                                            text: state
                                                    .getLandResponseModel
                                                    .data
                                                    ?.content?[index]
                                                    .villageName ??
                                                '',
                                          ),
                                          leading: Checkbox(
                                            checkColor: Colors.white,
                                            value: selectedLand.contains(state
                                                .getLandResponseModel
                                                .data
                                                ?.content?[index]
                                                .id),
                                            onChanged: (bool? value) {
                                              if (value != null) {
                                                if (kDebugMode) {
                                                  print(value);
                                                }
                                                if (value) {
                                                  selectedLand.add(state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .id);
                                                } else {
                                                  selectedLand.remove(state
                                                      .getLandResponseModel
                                                      .data
                                                      ?.content?[index]
                                                      .id);
                                                }
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          trailing: BlocConsumer<
                                              DeleteLandDataBloc,
                                              DeleteLandDataState>(
                                            builder: (BuildContext context,
                                                DeleteLandDataState
                                                    deleteState) {
                                              return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<
                                                          DeleteLandDataBloc>()
                                                      .add(DeleteLandData(
                                                          id: state
                                                                  .getLandResponseModel
                                                                  .data
                                                                  ?.content?[
                                                                      index]
                                                                  .id ??
                                                              0));
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 24,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                            listener: (BuildContext context,
                                                DeleteLandDataState state) {
                                              if (state
                                                  is DeleteLandDataLoading) {
                                                showDialog<String>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) =>
                                                           AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
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
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                          ),
                                                        ),
                                                        AppTextWidget(
                                                          text: AppLocalizations.of(context)!.deleting,
                                                          fontSize: AppTextSize
                                                              .contentSize20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else if (state
                                                  is DeleteLandDataSuccess) {
                                                context
                                                    .read<GetLandDataBloc>()
                                                    .add(GetLandListData(
                                                        landRequest: const {}));
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                          // trailing:const Icon(
                                          //   Icons.delete,
                                          //   color: Colors.red,
                                          // ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            listener: (BuildContext context,
                                GetLandDataState state) {},
                          ),
                           Row(
                            children: [
                              AppTextWidget(
                                text: AppLocalizations.of(context)!.totalLandHolding,
                                fontSize: AppTextSize.contentSize22,
                                fontWeight: FontWeight.w400,
                                textColor: Color(0xFF43483F),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 17),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: AppTextWidget(
                                text: AppLocalizations.of(context)!.totalLandAreaInAcre,
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xFF191D17),
                              ),
                              subtitle: BlocBuilder<GetLandDataBloc,
                                  GetLandDataState>(
                                builder: (BuildContext context,
                                    GetLandDataState state) {
                                  if (state is GetLandDataSuccess) {
                                    double totalIrrigatedLand = 0.0;
                                    if (state.getLandResponseModel.data
                                                ?.content !=
                                            null &&
                                        state.getLandResponseModel.data
                                                ?.content !=
                                            []) {
                                      // Iterate through each item in the content list
                                      for (var contentItem in state
                                              .getLandResponseModel
                                              .data
                                              ?.content ??
                                          []) {
                                        totalIrrigatedLand += double.tryParse(
                                                contentItem.irrigatedLand
                                                    .toString()) ??
                                            0.0;
                                        // Create a Text widget for each content ite
                                      }
                                      context
                                          .read<LoanPurposeCubit>()
                                          .updateModel(
                                              totalLandArea: totalIrrigatedLand
                                                  .toStringAsFixed(2));
                                      // Return a Column containing all the Text widgets
                                      return AppTextWidget(
                                        text: totalIrrigatedLand
                                            .toStringAsFixed(2),
                                        fontSize: AppTextSize.contentSize14,
                                        fontWeight: FontWeight.w400,
                                        textColor: const Color(0xFF191D17),
                                      );
                                    } else {
                                      // Return a message or widget indicating that the content is empty
                                      return Text(AppLocalizations.of(context)!.noDataAvailable);
                                    }
                                  }
                                  // Return an empty SizedBox if the state is not GetLandDataSuccess
                                  return const SizedBox();
                                },
                              ),
                              leading: const Icon(Icons.landscape_outlined),
                            ),
                          ),
                           Row(
                            children: [
                              AppTextWidget(
                                text: AppLocalizations.of(context)!.totalMarketValue,
                                fontSize: AppTextSize.contentSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CommonTextField(
                            labelText: AppLocalizations.of(context)!.amount,
                            prefixIcon: Icons.currency_rupee,
                            showPrefixIcon: true,
                            length: 20,
                            keyboardType: TextInputType.number,
                            controller: _totalMarketValue,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            onChange: (value) {
                              if (value.isNotEmpty) {
                                _isFilledMarketValue.value = true;
                              } else {
                                _isFilledMarketValue.value = false;
                              }
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
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
                  Expanded(
                    child: BlocConsumer<SaveLandDetailsNewBloc,
                        SaveLandDetailsNewState>(
                      builder: (BuildContext context,
                          SaveLandDetailsNewState state) {
                        return ValueListenableBuilder(
                          valueListenable: _isFilledMarketValue,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return value && selectedLand.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      final loanPurposeInfoCubit =
                                          context.read<LoanPurposeCubit>();

                                      final requestBody = {
                                        "id": loanPurposeInfoCubit
                                                .state.masterId ??
                                            0,
                                        "listofLandDetailsId":
                                            selectedLand ?? [],
                                        // Ensure this is a list
                                        "detailsRequestPayload": {
                                          "totalLandAreaUnitId":
                                              loanPurposeInfoCubit.state
                                                      .totalLandAreaUnitId ??
                                                  0,
                                          "totalLandArea": loanPurposeInfoCubit
                                                  .state.totalLandArea ??
                                              0,
                                          // Ensure this is a number
                                          "totalLandAreaAcre":
                                              loanPurposeInfoCubit
                                                      .state.totalLandArea ??
                                                  0,
                                          // Ensure this is a number
                                          "presentMarketValue":
                                              _totalMarketValue.text.isNotEmpty
                                                  ? double.parse(
                                                      _totalMarketValue.text
                                                          .replaceAll(',', ''))
                                                  : "0",
                                          // Ensure this is a string
                                        },
                                        "masterId": loanPurposeInfoCubit
                                                .state.masterId ??
                                            0
                                      };

                                      if (kDebugMode) {
                                        print(requestBody);
                                      }
                                      context
                                          .read<SaveLandDetailsNewBloc>()
                                          .add(SaveLandDetailsNew(
                                              requestBody: requestBody));
                                    },
                                    child:  CommonButton(
                                      buttonName: AppLocalizations.of(context)!.cancel,
                                    ),
                                  )
                                :  CommonButton(
                                    buttonName: AppLocalizations.of(context)!.next,
                                    buttonColor: AppColors.grayColor,
                                  );
                          },
                        );
                      },
                      listener: (BuildContext context,
                          SaveLandDetailsNewState state) {
                        if (state is SaveLandDetailsNewStateLoading) {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                 AlertDialog(
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
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.saving,
                                    fontSize: AppTextSize.contentSize20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                        if (state is SaveLandDetailsNewStateSuccess) {
                          Navigator.pushNamed(context,
                              CropLoanFormOtherDetailsScreen.routeName);
                        }
                      },
                    ),
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
