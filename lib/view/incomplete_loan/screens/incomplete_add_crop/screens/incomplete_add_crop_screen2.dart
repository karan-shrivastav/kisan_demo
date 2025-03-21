import 'package:ekisan_credit/bloc/crop_name/crop_name_state.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/crop_name/crop_name_bloc.dart';
import '../../../../../bloc/crop_name/crop_name_event.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../../../cubit/apply_laon/add_crop_cubit.dart';
import '../../../../../cubit/apply_laon/add_crop_list_cubit.dart';
import '../../../../../cubit/apply_laon/kcc_limit_cubit.dart';
import '../../../../../cubit/incomplete_loan/incomplete_loan_cubit.dart';
import '../../../../../cubit/model/add_crop_cubit_model.dart';
import '../../../../../cubit/model/add_crop_model.dart';
import '../../../../../cubit/model/add_land_irrigated_non_irrigated_cubit_model.dart';
import '../../../../../cubit/model/kcc_limit_model.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCropScreen2 extends StatefulWidget {
  const AddCropScreen2({super.key});

  @override
  State<AddCropScreen2> createState() => _AddCropScreen2State();
}

class _AddCropScreen2State extends State<AddCropScreen2> {
  final TextEditingController _croppingSeasonTextEditingController =
      TextEditingController();
  final TextEditingController _cropNameTextEditingController =
      TextEditingController();
  final TextEditingController _areaUnitTextEditingController =
      TextEditingController();
  final TextEditingController _landSizeController = TextEditingController();

  final ValueNotifier<bool> _isSelectedLandType = ValueNotifier<bool>(false);
  List<String> limitRate = [
    "1",
    "1.1",
    "1.21",
    "1.331",
    "1.46410",
  ];

  @override
  void initState() {
    final incompleteLoanInfoCubit = context.read<IncompleteLoanInfoCubit>();
    final addCropInObject = context.read<AddCropCubit>();

    final cropRequest = {
      "stateId": incompleteLoanInfoCubit.state.stateId,
      "districtId": incompleteLoanInfoCubit.state.districtId,
      "bankId": incompleteLoanInfoCubit.state.bankMasterId,
      "landTypeId": incompleteLoanInfoCubit.state.landTypeId,
      "croppingSeasonId": addCropInObject.state.croppingSeasonId,
    };

    context
        .read<CropNameNewBloc>()
        .add(GetCropNameList(cropRequest: cropRequest));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final applyLoanInfoCubit = context.read<ApplyLoanInfoCubit>();
    final addCropList = context.read<AddNewCropCubit>();
    final addCropInObject = context.read<AddCropCubit>();
    final incompleteLoanInfoCubit = context.read<IncompleteLoanInfoCubit>();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.secondOutLineColor,
                    borderRadius: BorderRadius.circular(100)),
              ),
              const SizedBox(
                height: 28,
              ),
              AppTextWidget(
                text: AppLocalizations.of(context)!.addNewCrop,
                fontWeight: FontWeight.w400,
                fontSize: AppTextSize.contentSize22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    BlocConsumer<GetLovsTypeDataNewBloc,
                        GetLovsTypeDataNewState>(
                      builder: (BuildContext context,
                          GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? namingTitle = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) => item.lovType == "LANDTYPE")
                              .toList();

                          // Extracting the gender values from the filtered list
                          List<String> namingValue = namingTitle
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];

                          // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                          return ValueListenableBuilder(
                            valueListenable: _isSelectedLandType,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Column(
                                children: [
                                  TwoAndThreeDividedHeaders(
                                    title: AppLocalizations.of(context)!
                                        .selectLandType,
                                    contentList: namingValue,
                                    showError: value,
                                    horizontalPadding: 0,
                                    heightBetweenContentAndTitle: 12,
                                    onValueSelected: (String selectedLandType) {
                                      // Filter naming titles list based on selected gender
                                      List<LovTypeDataList>? namingTitle = state
                                          .lovsTypeResponseModel.dataList
                                          ?.where((item) =>
                                              item.lovType == "LANDTYPE" &&
                                              item.value == selectedLandType)
                                          .toList();

                                      // Print the id of the first item found
                                      if (namingTitle != null &&
                                          namingTitle.isNotEmpty) {
                                        incompleteLoanInfoCubit.updateModel(
                                            landTypeId: namingTitle[0].id);
                                        addCropInObject.updateModel(
                                            landTypeId: "${namingTitle[0].id}",
                                            landTypeName: selectedLandType);

                                        if (kDebugMode) {
                                          print(
                                              "Selected Name: $selectedLandType, Corresponding ID: ${namingTitle[0].id}");
                                        }
                                      } else {
                                        if (kDebugMode) {
                                          print(
                                              "No naming title found for selected name: $selectedLandType");
                                        }
                                      }
                                      if (kDebugMode) {
                                        print(
                                            "Selected name: $selectedLandType");
                                      }
                                    },
                                  ),
                                  if (value)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 16),
                                            child: AppTextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .pleaseSelectLandType,
                                              fontSize: 12,
                                              textColor: AppColors.errorColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              );
                            },
                          );
                        }
                        return Container();
                      },
                      listener: (BuildContext context,
                          GetLovsTypeDataNewState state) {},
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    /********* Cropping Season **************/
                    BlocBuilder<GetLovsTypeDataNewBloc,
                        GetLovsTypeDataNewState>(
                      builder: (BuildContext context,
                          GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? croppingSeason = state
                              .lovsTypeResponseModel.dataList
                              ?.where(
                                  (item) => item.lovType == "CROPPINGDETAIL")
                              .toList();

                          // Extracting the gender values from the filtered list
                          List<String> croppingSeasonList = croppingSeason
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: croppingSeasonList,
                            suggestionToString: (district) => district,
                            onSelected: (selectedCroppingSeason) {
                              print(selectedCroppingSeason);
                              _croppingSeasonTextEditingController.text =
                                  selectedCroppingSeason;
                              // Handle the selected district logic here

                              List<LovTypeDataList>? croppingSeason = state
                                  .lovsTypeResponseModel.dataList
                                  ?.where((item) =>
                                      item.lovType == "CROPPINGDETAIL" &&
                                      item.value == selectedCroppingSeason)
                                  .toList();
                              addCropInObject.updateModel(
                                  croppingSeasonId: '${croppingSeason?[0].id}',
                                  croppingSeasonName: selectedCroppingSeason);
                              final cropRequest = {
                                "stateId":
                                    incompleteLoanInfoCubit.state.stateId,
                                "districtId":
                                    incompleteLoanInfoCubit.state.districtId,
                                "bankId":
                                    incompleteLoanInfoCubit.state.bankMasterId,
                                "landTypeId":
                                    incompleteLoanInfoCubit.state.landTypeId,
                                "croppingSeasonId": croppingSeason?[0].id
                              };
                              context.read<CropNameNewBloc>().add(
                                  GetCropNameList(cropRequest: cropRequest));
                              if (kDebugMode) {
                                print(
                                    "Selected Name: $selectedCroppingSeason, Corresponding ID: ${croppingSeason?[0].id}");
                              }
                            },
                            controller: _croppingSeasonTextEditingController,
                            labelText: AppLocalizations.of(context)!.crop,
                            hintText: AppLocalizations.of(context)!
                                .someSeasonNameWithRange,
                          );
                        }
                        return CommonTextField(
                          labelText:
                              AppLocalizations.of(context)!.croppingSeason,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<CropNameNewBloc, CropNameNewState>(
                      builder: (BuildContext context, CropNameNewState state) {
                        if (state is GetCropNameNewSuccess) {
                          List<String> cropNameList = state
                                  .getCropNameListResponseModel.dataList
                                  ?.map((item) => item.cropName ?? "")
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: cropNameList,
                            suggestionToString: (cropData) => cropData,
                            onSelected: (selectedCrop) {
                              print(selectedCrop);
                              _cropNameTextEditingController.text =
                                  selectedCrop;
                              // Handle the selected district logic here
                              final selectedCropObject = state
                                  .getCropNameListResponseModel.dataList
                                  ?.firstWhere(
                                      (item) => item.cropName == selectedCrop);

                              addCropInObject.updateModel(
                                  cropId: '${selectedCropObject?.id}',
                                  cropName: selectedCrop,
                                  mainAmount: selectedCropObject?.sofCropPrice);
                            },
                            controller: _cropNameTextEditingController,
                            labelText: AppLocalizations.of(context)!.crop,
                            hintText:
                                AppLocalizations.of(context)!.someLongCropName,
                          );
                        }
                        return CommonTextField(
                            labelText: AppLocalizations.of(context)!.crop);
                      },
                    ),
                    /********* Area Unit **********/
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 60,
                      child: BlocBuilder<GetLovsTypeDataNewBloc,
                          GetLovsTypeDataNewState>(
                        builder: (BuildContext context,
                            GetLovsTypeDataNewState state) {
                          if (state is GetLovsTypeDataSuccess) {
                            List<LovTypeDataList>? areaUnitTypeList = state
                                .lovsTypeResponseModel.dataList
                                ?.where((item) => item.lovType == "AREAUNIT")
                                .toList();

                            // Extracting the identity type values from the filtered list
                            List<String> unitList = areaUnitTypeList
                                    ?.map((item) => item.value ?? "")
                                    .toList() ??
                                [];
                            return CommonTypeAheadField<String>(
                              suggestions: unitList,
                              showIcon: false,
                              length: 15,
                              suggestionToString: (district) => district,
                              onSelected: (selectedAreaUnitIt) {
                                print(selectedAreaUnitIt);
                                _areaUnitTextEditingController.text =
                                    selectedAreaUnitIt;

                                List<LovTypeDataList>? identityTypeList = state
                                    .lovsTypeResponseModel.dataList
                                    ?.where((item) =>
                                        item.lovType == "AREAUNIT" &&
                                        item.value == selectedAreaUnitIt)
                                    .toList();

                                // Print the id of the first item found
                                if (identityTypeList != null &&
                                    identityTypeList.isNotEmpty) {
                                  addCropInObject.updateModel(
                                      areaUnitId: '${identityTypeList[0].id}');
                                  context
                                      .read<AddLandIrrigatedNonIrrigatedCubit>()
                                      .updateModel(
                                          areaUnitId: identityTypeList[0].id,
                                          irrigated: "0",
                                          nonIrrigated: "0",
                                          landSize: "0",
                                          sourceOfIrrigationId: 0);

                                  if (kDebugMode) {
                                    print(
                                        "Corresponding  ${selectedAreaUnitIt}ID: ${identityTypeList[0].id}");
                                  }
                                }
                                // Handle the selected district logic here
                              },
                              controller: _areaUnitTextEditingController,
                              labelText: AppLocalizations.of(context)!.areaUnit,
                              hintText: AppLocalizations.of(context)!.someAreaUnit,
                            );
                          }
                          return  CommonTextField(
                            labelText: AppLocalizations.of(context)!.areaUnit,
                            enabled: false,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocListener<AddLandIrrigatedNonIrrigatedCubit,
                        AddLandIrrigatedNonIrrigatedCubitModel>(
                      listener: (BuildContext context,
                          AddLandIrrigatedNonIrrigatedCubitModel state) {},
                      child: CommonTextField(
                        labelText: AppLocalizations.of(context)!.landSize,
                        hintText: AppLocalizations.of(context)!.landSize,
                        validator: AppFormValidation.landSize,
                        keyboardType: TextInputType.number,
                        controller: _landSizeController,
                        onChange: (value) {
                          addCropInObject.updateModel(landSize: value);
                          context
                              .read<AddLandIrrigatedNonIrrigatedCubit>()
                              .updateModel(
                                landSize: value,
                              );
                          Future.delayed(const Duration(seconds: 1), () {
                            context
                                .read<AddLandIrrigatedNonIrrigatedCubit>()
                                .calculateLandByUnitNew();
                          });
                          // context.read<AddLandIrrigatedNonIrrigatedCubit>().calculateLandByUnitNew();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<AddLandIrrigatedNonIrrigatedCubit,
                        AddLandIrrigatedNonIrrigatedCubitModel>(
                      builder: (BuildContext context,
                          AddLandIrrigatedNonIrrigatedCubitModel state) {
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.inAcre,
                          hintText:AppLocalizations.of(context)!.selectAnOption,
                          controller:
                              TextEditingController(text: state.irrigated),
                          enabled: false,
                          onChange: (value) {},
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                            child:
                                BlocConsumer<AddCropCubit, AddCropCubitModel>(
                              builder: (BuildContext context,
                                  AddCropCubitModel state) {
                                if (state.landTypeId != null &&
                                    state.croppingSeasonId != null &&
                                    state.areaUnitId != null &&
                                    state.landSize != null &&
                                    state.landSize!.isNotEmpty) {
                                  return InkWell(
                                    onTap: () {
                                      final kccLimitCubit =
                                          context.read<KccLimitCubit>();
                                      kccLimitCubit.clearAllData();
                                      final landInAcre = context.read<
                                          AddLandIrrigatedNonIrrigatedCubit>();
                                      addCropList.addCrop(
                                        AddNewCropCubitModel(
                                            landTypeId: addCropInObject
                                                .state.landTypeId,
                                            landTypeName: addCropInObject
                                                .state.landTypeName,
                                            croppingSeasonId: addCropInObject
                                                .state.croppingSeasonId,
                                            croppingSeasonName: addCropInObject
                                                .state.croppingSeasonName,
                                            cropId:
                                                addCropInObject.state.cropId,
                                            areaUnitName: addCropInObject
                                                .state.areaUnitName,
                                            areaUnitId: addCropInObject
                                                .state.areaUnitId,
                                            cropName:
                                                addCropInObject.state.cropName,
                                            mainAmount: addCropInObject
                                                .state.mainAmount,
                                            totalInAcre:
                                                landInAcre.state.irrigated),
                                      );

                                      for (int i = 0; i < 5; i++) {
                                        double amt1 = 0;
                                        double amt2 = 0;
                                        double amt3 = 0;
                                        double amt4 = 0;
                                        for (int index = 0;
                                            index < addCropList.state.length;
                                            index++) {
                                          double? mainAmount = addCropList
                                              .state[index].mainAmount;

                                          amt1 = amt1 +
                                              (((addCropList.state[index]
                                                                  .mainAmount! *
                                                              double.parse(addCropList
                                                                      .state[
                                                                          index]
                                                                      .totalInAcre ??
                                                                  '0') *
                                                              double.parse(
                                                                  limitRate[
                                                                      i])) /
                                                          100)
                                                      .round() *
                                                  100);
                                          amt2 = amt2 +
                                              (((0.1 *
                                                              mainAmount! *
                                                              double.parse(addCropList
                                                                      .state[
                                                                          index]
                                                                      .totalInAcre ??
                                                                  '0') *
                                                              double.parse(
                                                                  limitRate[
                                                                      i])) /
                                                          100)
                                                      .round() *
                                                  100);
                                          amt3 = amt3 +
                                              (((0.2 *
                                                              mainAmount *
                                                              double.parse(addCropList
                                                                      .state[
                                                                          index]
                                                                      .totalInAcre ??
                                                                  '0') *
                                                              double.parse(
                                                                  limitRate[
                                                                      i])) /
                                                          100)
                                                      .round() *
                                                  100);
                                          amt4 = amt4 +
                                              (((1.3 *
                                                              mainAmount *
                                                              double.parse(addCropList
                                                                      .state[
                                                                          index]
                                                                      .totalInAcre ??
                                                                  '0') *
                                                              double.parse(
                                                                  limitRate[
                                                                      i])) /
                                                          100)
                                                      .round() *
                                                  100);
                                        }
                                        TextEditingController prLimit =
                                            TextEditingController(
                                                text: amt1.toStringAsFixed(2));
                                        TextEditingController fmCom =
                                            TextEditingController(
                                                text: amt2.toStringAsFixed(2));
                                        TextEditingController farmMan =
                                            TextEditingController(
                                                text: amt3.toStringAsFixed(2));
                                        TextEditingController total =
                                            TextEditingController(
                                                text: amt4.toStringAsFixed(2));

                                        String fAmt =
                                            '${double.parse(prLimit.text.replaceAll(',', ''))}';
                                        prLimit.value = TextEditingValue(
                                            text: fAmt,
                                            selection: TextSelection.collapsed(
                                              offset: fAmt.length,
                                            ));

                                        String sAmt =
                                            '${double.parse(fmCom.text.replaceAll(',', ''))}';

                                        fmCom.value = TextEditingValue(
                                            text: sAmt,
                                            selection: TextSelection.collapsed(
                                              offset: sAmt.length,
                                            ));

                                        String tAmt =
                                            '${double.parse(farmMan.text.replaceAll(',', ''))}';
                                        farmMan.value = TextEditingValue(
                                            text: tAmt,
                                            selection: TextSelection.collapsed(
                                              offset: tAmt.length,
                                            ));

                                        String fourthAmt =
                                            '${double.parse(total.text.replaceAll(',', ''))}';
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

                                      Navigator.pop(context);
                                    },
                                    child:  CommonButton(
                                      buttonName: AppLocalizations.of(context)!.save,
                                    ),
                                  );
                                }
                                return  CommonButton(
                                  buttonName: AppLocalizations.of(context)!.save,
                                  buttonColor: AppColors.grayColor,
                                );
                              },
                              listener: (BuildContext context,
                                  AddCropCubitModel state) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
