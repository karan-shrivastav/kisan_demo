import 'package:ekisan_credit/bloc/bank_type/bank_type_bloc.dart';
import 'package:ekisan_credit/bloc/bank_type/bank_type_state.dart';
import 'package:ekisan_credit/bloc/district/district_state.dart';
import 'package:ekisan_credit/bloc/loan_basic/get_loan_basic_bloc.dart';
import 'package:ekisan_credit/bloc/state/state_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/bank_list/bank_list_bloc.dart';
import '../../../../../bloc/bank_list/bank_list_new.dart';
import '../../../../../bloc/bank_list/bank_list_state.dart';
import '../../../../../bloc/bank_type/bank_type_event.dart';
import '../../../../../bloc/banks_bank_by_type/banks_bank_by_type_bloc.dart';
import '../../../../../bloc/banks_bank_by_type/banks_bank_by_type_event.dart';
import '../../../../../bloc/branch/branch_list_bloc.dart';
import '../../../../../bloc/branch/branch_list_event.dart';
import '../../../../../bloc/branch/branch_list_state.dart';
import '../../../../../bloc/district/district_bloc.dart';
import '../../../../../bloc/district/district_event.dart';
import '../../../../../bloc/loan_assets/loan_assets_bloc.dart';
import '../../../../../bloc/loan_basic/get_loan_basic_state.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../bloc/state/state_bloc.dart';
import '../../../../../bloc/state/state_event.dart';
import '../../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../../cubit/apply_laon/add_crop_list_cubit.dart';
import '../../../../../cubit/apply_laon/kcc_limit_cubit.dart';
import '../../../../../cubit/asset_id/asset_id_cubit.dart';
import '../../../../../cubit/incomplete_loan/incomplete_loan_cubit.dart';
import '../../../../../cubit/model/add_crop_cubit_model.dart';
import '../../../../../model/response/loan_basic_response_model.dart';
import '../../../../../utils/form_validation.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_crop_loan_form_crop_details/screens/incomplete_crop_loan_form_crop_details_screen2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteCropLoanFormBankDetail extends StatefulWidget {
  static const routeName = "incomplete-crop-loan-form-bank-details";

  const IncompleteCropLoanFormBankDetail({super.key});

  @override
  State<IncompleteCropLoanFormBankDetail> createState() =>
      _IncompleteCropLoanFormBankDetailState();
}

class _IncompleteCropLoanFormBankDetailState
    extends State<IncompleteCropLoanFormBankDetail> {
  final TextEditingController districtController = TextEditingController();
  final TextEditingController _bankTypeController = TextEditingController();
  final TextEditingController _stateTypeController = TextEditingController();
  final ValueNotifier<bool> _isShowPacs = ValueNotifier<bool>(false);
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  String bankName = '';

  List<AddNewCropCubitModel> cropListData = [];
  List<CropDetailDto>? cropDetailDtos = [];

  final List<String> districtList = [
    "District 1",
    "District 2",
    "District 3",
    "District 4",
  ];

  int stateId = 0;
  String bankType = '';
  int districtId = 0;
  int bankId = 0;
  int branchId = 0;

  var loanAssetBloc = LoanAssetsBloc();
  var lovTypeBloc = GetLovsTypeDataNewBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final assetIdCubit = context.read<AssetIdCubit>();
    final lovsTypeData = ["ASSESTTYPE"];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      lovTypeBloc.add(GetLovsTypeDataNewList(
        bodyRequest: lovsTypeData,
      ));
    });

    lovTypeBloc.stream.listen((state) {
      if (state is GetLovsTypeDataLoading) {}
      if (state is GetLovsTypeDataSuccess) {
        state.lovsTypeResponseModel.dataList?.forEach((element) {
          if (element.value == "Movable Assest") {
            assetIdCubit.updateModel(
              movableId: element.id,
            );
          }
          if (element.value == "Immovable Assest") {
            assetIdCubit.updateModel(
              immovableId: element.id,
            );
          }
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    context.read<BankTypeNewBloc>().add(GetALlBankTypeData());
    context.read<StateBloc>().add(GetAllState());
    context.read<GetLoanBasicBloc>().stream.listen((state) {
      if (state is GetBasicLoanSuccess) {
        final districtRequest = {
          "stateId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.stateMasterId ??
              ''
        }; // Set the selected value to _selectedState
        context
            .read<DistrictBlocNew>()
            .add(GetAllDistrictByState(districtRequest: districtRequest));

        final bankRequest = {
          "type":
              state.loanBasicResponseModel.data?.loanDetailMapper?.bankType ??
                  '',
          "stateId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.stateMasterId ??
              '',
          "districtId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.stateMasterId ??
              '',
        };
        context
            .read<GetBankListNewBloc>()
            .add(GetBanNewBankList(bankRequest: bankRequest));
        final branchListRequest = {
          "stateId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.stateMasterId ??
              '',
          "districtId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.districtMasterId ??
              '',
          "bankMasterId": state.loanBasicResponseModel.data?.loanDetailMapper
                  ?.bankMasterId ??
              '',
        };
        context
            .read<BranchListNewBloc>()
            .add(GetNewBranchList(branchListRequest: branchListRequest));
        stateId = state
                .loanBasicResponseModel.data?.loanDetailMapper?.stateMasterId ??
            0;
        districtId = state.loanBasicResponseModel.data?.loanDetailMapper
                ?.districtMasterId ??
            0;
        bankId =
            state.loanBasicResponseModel.data?.loanDetailMapper?.bankMasterId ??
                0;
        branchId = state
                .loanBasicResponseModel.data?.loanDetailMapper?.entityLevelId ??
            0;
        _stateTypeController.text =
            state.loanBasicResponseModel.data?.loanDetailMapper?.stateName ??
                '';
        bankName =
            state.loanBasicResponseModel.data?.loanDetailMapper?.bankType ?? '';
        districtController.text =
            state.loanBasicResponseModel.data?.loanDetailMapper?.districtName ??
                '';
        _bankController.text =
            state.loanBasicResponseModel.data?.loanDetailMapper?.bankName ?? '';
        _branchController.text = state.loanBasicResponseModel.data
                ?.loanDetailMapper?.entityLevelName ??
            '';

        context.read<IncompleteLoanInfoCubit>().updateModel(
              stateId: stateId,
              districtId: districtId,
              entityLevelId: branchId,
              bankMasterId: bankId,
              jointApplicant: state.loanBasicResponseModel.data
                      ?.loanDetailMapper?.jointApplicant ??
                  '',
              cropDetailDto:
                  state.loanBasicResponseModel.data?.cropDetailDtos ?? [],
              agricultureIncome: state.loanBasicResponseModel.data
                  ?.loanDetailMapper?.agricultureIncome,
              otherIncome: state
                  .loanBasicResponseModel.data?.loanDetailMapper?.otherIncome,
              alliedIncome: state
                  .loanBasicResponseModel.data?.loanDetailMapper?.alliedIncome,
              presentMarketValue: state.loanBasicResponseModel.data
                  ?.loanDetailMapper?.presentMarketValue,
              covered:
                  state.loanBasicResponseModel.data?.loanDetailMapper?.covered,
            );

        final incompleteLoanInfoCubit = context.read<IncompleteLoanInfoCubit>();
        if (incompleteLoanInfoCubit.state.covered == "Yes") {
          _isCovered.value = true;
        }
        final addCropList = context.read<AddNewCropCubit>();
        addCropList.clearCrops();
        final kccLimitCubit = context.read<KccLimitCubit>();
        kccLimitCubit.clearAllData();
        // cropDetailData =
        //     incompleteLoanInfoCubit.state.cropDetailDto ?? [];

        for (int i = 0;
            i < state.loanBasicResponseModel.data!.cropDetailDtos!.length;
            i++) {
          if (addCropList.state.isEmpty) {
            addCropList.state.add(AddNewCropCubitModel(
              landTypeId: state
                  .loanBasicResponseModel.data?.cropDetailDtos?[i].landTypeId,
              landTypeName: state
                  .loanBasicResponseModel.data?.cropDetailDtos?[i].landType,
              croppingSeasonId:
                  '${state.loanBasicResponseModel.data?.cropDetailDtos?[i].croppingSeasonId}',
              croppingSeasonName: state.loanBasicResponseModel.data
                  ?.cropDetailDtos?[i].croppingSeasonName,
              cropId:
                  '${state.loanBasicResponseModel.data?.cropDetailDtos?[i].id}',
              areaUnitName: state.loanBasicResponseModel.data
                  ?.cropDetailDtos?[i].areaUnitValue,
              areaUnitId:
                  '${state.loanBasicResponseModel.data?.cropDetailDtos?[i].areaUnitId}',
              cropName: state
                  .loanBasicResponseModel.data?.cropDetailDtos?[i].cropName,
              mainAmount: double.parse(state.loanBasicResponseModel.data
                      ?.cropDetailDtos?[i].acreAmount ??
                  ''),
              totalInAcre:
                  '${state.loanBasicResponseModel.data?.cropDetailDtos?[i].areaInAcre}',
            ));
          }
        }
      }
    });
    super.didChangeDependencies();
  }

  List<AddNewCropCubitModel> cropsDataList = [];
  List<CropDetailDto> cropDetailData = [];
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final ValueNotifier<bool> _isCovered = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final incompleteLoanInfoCubit = context.read<IncompleteLoanInfoCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LoanApplyHeaderWidget(
                headerName: AppLocalizations.of(context)!.cropLoanForm,
                percentageFirst: 50,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.basicDetails,
                      fontSize: AppTextSize.contentSize24,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context)!
                              .wetherCoveredUnderPMJJBY,
                          fontWeight: FontWeight.w500,
                          fontSize: AppTextSize.contentSize14,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _isCovered,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return Switch(
                              thumbIcon: thumbIcon,
                              value: _isCovered.value,
                              onChanged: (bool value) {
                                _isCovered.value = !_isCovered.value;
                                if (_isCovered.value) {
                                  incompleteLoanInfoCubit.updateModel(
                                      covered:
                                         "Yes");
                                } else {
                                  incompleteLoanInfoCubit.updateModel(
                                      covered:
                                         "No");
                                }
                              },
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    /*******   Bank Type ***********/
                    BlocBuilder<BankTypeNewBloc, BankTypeNewState>(
                      builder: (BuildContext context, BankTypeNewState state) {
                        if (state is GetBankTypeSuccess) {
                          List<String> bankTypeList = state
                                  .getAllBankTypeResponseModel.dataList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                          state.getAllBankTypeResponseModel.dataList
                              ?.forEach((element) {
                            if (element.name == bankName) {
                              _bankTypeController.text = element.value ?? '';
                              incompleteLoanInfoCubit.updateModel(
                                  bankType: bankName);
                            }
                          });

                          return CommonTypeAheadField<String>(
                              suggestions: bankTypeList,
                              suggestionToString: (district) => district,
                              onSelected: (selectedBank) {
                                if (selectedBank
                                    .contains('Co-Operative Banks')) {
                                  _isShowPacs.value = true;
                                } else {
                                  _isShowPacs.value = false;
                                }
                                if (kDebugMode) {
                                  print(selectedBank);
                                }
                                _bankTypeController.text = selectedBank;
                                // Handle the selected district logic here
                                final selectedBankObject = state
                                    .getAllBankTypeResponseModel.dataList
                                    ?.firstWhere(
                                        (item) => item.value == selectedBank);
                                final bankRequest = {
                                  "type": selectedBankObject?.name
                                };
                                incompleteLoanInfoCubit.updateModel(
                                    bankType: selectedBankObject?.name);
                                context.read<BanksNewBankByTypeBloc>().add(
                                    GetNewBanksBankByType(
                                        bankRequest: bankRequest));
                              },
                              controller: _bankTypeController,
                              labelText: AppLocalizations.of(context)!.bankType,
                              hintText:
                                  AppLocalizations.of(context)!.someBankType,
                              validator: AppFormValidation.bankType);
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.bankType,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    /************** State *****************/
                    BlocBuilder<StateBloc, StateState>(
                        builder: (BuildContext context, StateState state) {
                      if (kDebugMode) {
                        print(state);
                      }
                      if (state is GetStateSuccess) {
                        List<String> stateList = state
                                .getAllStateResponseModel.dataList
                                ?.map((item) => item.stateName ?? "")
                                .toList() ??
                            [];

                        return CommonTypeAheadField<String>(
                            suggestions: stateList,
                            suggestionToString: (state) => state,
                            onSelected: (selectedState) {
                              if (kDebugMode) {
                                print(selectedState);
                              }
                              _stateTypeController.text = selectedState;

                              final selectedStateObject = state
                                  .getAllStateResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.stateName == selectedState);
                              incompleteLoanInfoCubit.updateModel(
                                  stateId: selectedStateObject?.id);

                              final districtRequest = {
                                "stateId": selectedStateObject?.id ?? ''
                              }; // Set the selected value to _selectedState
                              context.read<DistrictBlocNew>().add(
                                  GetAllDistrictByState(
                                      districtRequest: districtRequest));
                              // Handle the selected district logic here
                            },
                            controller: _stateTypeController,
                            labelText: AppLocalizations.of(context)!.state,
                            hintText: AppLocalizations.of(context)!.selectState,
                            validator: AppFormValidation.validateState);
                      }
                      return CommonTextField(
                        labelText: AppLocalizations.of(context)!.state,
                        enabled: false,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    /************** District *****************/
                    BlocBuilder<DistrictBlocNew, DistrictStateNew>(
                      builder: (BuildContext context, DistrictStateNew state) {
                        if (state is GetDistrictSuccess) {
                          List<String> districtList = state
                                  .getDistrictResponseModel.dataList
                                  ?.map((item) => item.districtName ?? "")
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: districtList,
                            suggestionToString: (district) => district,
                            onSelected: (selectedDistrict) {
                              if (kDebugMode) {
                                print(selectedDistrict);
                              }
                              districtController.text = selectedDistrict;
                              final selectedDistrictObject = state
                                  .getDistrictResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.districtName == selectedDistrict);
                              incompleteLoanInfoCubit.updateModel(
                                  districtId: selectedDistrictObject?.id);
                              // Handle the selected district logic here
                              final bankRequest = {
                                "type": incompleteLoanInfoCubit.state.bankType,
                                "stateId":
                                    incompleteLoanInfoCubit.state.stateId,
                                "districtId":
                                    incompleteLoanInfoCubit.state.districtId,
                              };
                              context.read<GetBankListNewBloc>().add(
                                  GetBanNewBankList(bankRequest: bankRequest));
                            },
                            controller: districtController,
                            labelText: 'District',
                            hintText: 'Select District',
                            validator: AppFormValidation.validateDistrict,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.district,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<GetBankListNewBloc, BankListNewState>(
                      builder: (BuildContext context, BankListNewState state) {
                        if (state is GetBankListNewSuccess) {
                          List<String> bankTypeTypeList = state
                                  .bankListResponseModel.dataList
                                  ?.map((item) =>
                                      item.bankName ??
                                      "") // Specifying that the map returns String
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                              suggestions: bankTypeTypeList,
                              suggestionToString: (bankTypeType) =>
                                  bankTypeType,
                              onSelected: (selectedBankType) {
                                print(selectedBankType);
                                _bankController.text = selectedBankType;
                                final selectedBankObject = state
                                    .bankListResponseModel.dataList
                                    ?.firstWhere((item) =>
                                        item.bankName == selectedBankType);
                                incompleteLoanInfoCubit.updateModel(
                                    bankMasterId: selectedBankObject?.id);
                                final branchListRequest = {
                                  "stateId":
                                      incompleteLoanInfoCubit.state.stateId,
                                  "districtId":
                                      incompleteLoanInfoCubit.state.districtId,
                                  "bankMasterId": selectedBankObject?.id
                                };
                                context.read<BranchListNewBloc>().add(
                                    GetNewBranchList(
                                        branchListRequest: branchListRequest));
                              },
                              controller: _bankController,
                              labelText: AppLocalizations.of(context)!.bank,
                              hintText:
                                  AppLocalizations.of(context)!.selectBank,
                              validator: AppFormValidation.bank);
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.bank,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<BranchListNewBloc, BranchListNewState>(
                      builder:
                          (BuildContext context, BranchListNewState state) {
                        if (state is GetNewBranchListSuccess) {
                          List<String> bankTypeTypeList = state
                                  .branchListResponseModel.dataList
                                  ?.map((item) =>
                                      item.entityLevelName ??
                                      "") // Specifying that the map returns String
                                  .toList() ??
                              [];
                          return CommonTypeAheadField<String>(
                            suggestions: bankTypeTypeList,
                            suggestionToString: (bankTypeType) => bankTypeType,
                            onSelected: (selectedBranchType) {
                              if (kDebugMode) {
                                print(selectedBranchType);
                              }
                              _branchController.text = selectedBranchType;
                              final selectedBranchObject = state
                                  .branchListResponseModel.dataList
                                  ?.firstWhere((item) =>
                                      item.entityLevelName ==
                                      selectedBranchType);
                              incompleteLoanInfoCubit.updateModel(
                                  entityLevelId: selectedBranchObject?.id);
                            },
                            controller: _branchController,
                            labelText: AppLocalizations.of(context)!.branch,
                            hintText:
                                AppLocalizations.of(context)!.selectBranch,
                            validator: AppFormValidation.validateBranch,
                          );
                        }
                        return CommonTextField(
                          labelText: AppLocalizations.of(context)!.branch,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isShowPacs,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return value
                            ? CommonTypeAheadField<String>(
                                suggestions: districtList,
                                suggestionToString: (district) => district,
                                onSelected: (selectedDistrict) {
                                  print(selectedDistrict);
                                  districtController.text = selectedDistrict;

                                  // Handle the selected district logic here
                                },
                                controller: districtController,
                                labelText: AppLocalizations.of(context)!.pacs,
                                hintText:
                                    AppLocalizations.of(context)!.selectPacs,
                                validator: AppFormValidation.validatePacs)
                            : Container();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_isShowPacs.value) {
                      Navigator.pushNamed(
                        context,
                        CropLoanFromCropDetailsScreen2.routeName,
                      );
                    }
                  }
                },
                child: CommonButton(
                  buttonName: AppLocalizations.of(context)!.next,
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
