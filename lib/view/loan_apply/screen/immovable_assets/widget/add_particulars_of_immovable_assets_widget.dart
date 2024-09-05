import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/common_widget/common_type_ahed_widget.dart';
import 'package:ekisan_credit/cubit/model/other_details_cubit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/text_input_formate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddParticularsOfImmovableWidget extends StatefulWidget {
  const AddParticularsOfImmovableWidget({super.key});

  @override
  State<AddParticularsOfImmovableWidget> createState() =>
      _AddParticularsOfImmovableWidgetState();
}

class _AddParticularsOfImmovableWidgetState
    extends State<AddParticularsOfImmovableWidget> {
  final TextEditingController typeofAssetTextEditingController =
      TextEditingController();
  final TextEditingController _particularsTextEditingController =
      TextEditingController();
  var uuid = const Uuid();

  @override
  void initState() {
    final lovsTypeData = ["ASSESTNAME", "ASSESTTYPE"];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final otherDetailsCubit = context.read<OtherDetailsCubit>();

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppTextWidget(
                        text: AppLocalizations.of(context)!.particularsOfImmovableOwned,
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSize.contentSize22,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BlocBuilder<GetLovsTypeDataNewBloc,
                        GetLovsTypeDataNewState>(
                      builder: (BuildContext context,
                          GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? assetTypeList = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) =>
                                  item.lovType == "ASSESTTYPE" &&
                                  item.value == "Immovable Assest")
                              .toList();
                          List<LovTypeDataList>? assetType = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) =>
                                  item.lovType == "ASSESTNAME" &&
                                  item.comment == "Immovable Assest")
                              .toList();

                          return CommonTypeAheadField<LovTypeDataList>(
                            suggestions: assetType ?? [],
                            suggestionToString: (LovTypeDataList item) =>
                                item.value ?? "",
                            onSelected: (LovTypeDataList selectedAsset) {
                              typeofAssetTextEditingController.text =
                                  selectedAsset.value ?? "";
                              _particularsTextEditingController.text =
                                  selectedAsset.value ?? "";
                              // Assuming OtherDetailsCubit has a method to handle asset ID

                              context.read<OtherDetailsCubit>().addDataFromUI(
                                    loanAsset: LoanAsset(
                                      assetDataId: selectedAsset.id.toString(),
                                      particulars: selectedAsset.value,
                                      assestTypeId:
                                          assetTypeList?[0].id.toString(),
                                      assetName: selectedAsset.value,
                                      loanMasterId: "",
                                    ),
                                  );
                            },
                            hintText: AppLocalizations.of(context)!.selectAnOption,
                            controller: typeofAssetTextEditingController,
                            labelText: AppLocalizations.of(context)!.typeOfAsset,
                          );
                        }
                        return  CommonTextField(
                          labelText: AppLocalizations.of(context)!.typeOfAsset,
                          enabled: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.particulars,
                      hintText:  AppLocalizations.of(context)!.pleaseEnterText,
                      controller: _particularsTextEditingController,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                              loanAsset: LoanAsset(
                                particulars: value,
                              ),
                            );
                      },
                    ),
                   const SizedBox(
                      height: 16,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.marketValue,
                      hintText:  AppLocalizations.of(context)!.pleaseEnterAmount,
                      keyboardType: TextInputType.number,
                      length: 10,
                      prefixIcon: Icons.currency_rupee_outlined,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      showPrefixIcon: true,
                      onChange: (value) {
                        context.read<OtherDetailsCubit>().addDataFromUI(
                              loanAsset: LoanAsset(presentMarketValue: value),
                            );
                      },
                    ),
                  ],
                ),
              )),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:  CommonButton(
                        buttonName:  AppLocalizations.of(context)!.cancell,
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
                    child: BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                      builder: (BuildContext context, OtherDetailsState state) {
                        if (state.loanAsset?.assetDataId != null &&
                            state.loanAsset!.assetDataId!.isNotEmpty &&
                            state.loanAsset?.particulars != null &&
                            state.loanAsset!.particulars!.isNotEmpty &&
                            state.loanAsset?.presentMarketValue != null &&
                            state.loanAsset!.presentMarketValue!.isNotEmpty) {
                          return InkWell(
                            onTap: () {
                              otherDetailsCubit.addLoanAsset(LoanAsset(
                                  id: otherDetailsCubit.state.loanAsset?.id,
                                  loanMasterId: otherDetailsCubit.state.loanAsset?.loanMasterId,
                                  assestTypeId: otherDetailsCubit.state.loanAsset?.assestTypeId,
                                  assetDataId: otherDetailsCubit.state.loanAsset?.assetDataId,
                                  particulars: otherDetailsCubit.state.loanAsset?.particulars,
                                  presentMarketValue: otherDetailsCubit
                                      .state.loanAsset?.presentMarketValue,
                                  assetName: otherDetailsCubit
                                      .state.loanAsset?.assetName,
                                  listId: uuid.v4(),
                                  assetType: "Immovable"));

                              Navigator.pop(context);
                            },
                            child:  CommonButton(
                              buttonName:AppLocalizations.of(context)!.add
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {},
                          child:  CommonButton(
                            buttonName:AppLocalizations.of(context)!.add,
                            buttonColor: AppColors.grayColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
