import 'package:ekisan_credit/cubit/model/other_details_cubit_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../model/response/lovtype_type_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/text_input_formate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddGuaratorBottomSheetWidget extends StatefulWidget {
  const AddGuaratorBottomSheetWidget({super.key});

  @override
  State<AddGuaratorBottomSheetWidget> createState() =>
      _AddGuaratorBottomSheetWidgetState();
}

class _AddGuaratorBottomSheetWidgetState
    extends State<AddGuaratorBottomSheetWidget> {
  final _occupationTextEditingController = TextEditingController();

  var uuid = const Uuid();

  @override
  void initState() {
    final lovTypeData = [
      "OCCUPATION",
    ];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovTypeData,
          ),
        );
    context.read<OtherDetailsCubit>().clearLoanGuarantor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
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
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.guarantorsOffered,
              fontWeight: FontWeight.w400,
              fontSize: AppTextSize.contentSize22,
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.name,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanGuarantor:
                                LoanGuarantorsList(guarantorName: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.age,
                    keyboardType: TextInputType.number,
                    length: 2,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanGuarantor: LoanGuarantorsList(age: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.mobileNumber,
                    keyboardType: TextInputType.number,
                    length: 10,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanGuarantor:
                                LoanGuarantorsList(mobileNumber: value),
                          );
                    },
                    suffixIcon: Icons.dialpad_sharp,
                    prefix: AppTextWidget(
                      text: '+91',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
                    builder:
                        (BuildContext context, GetLovsTypeDataNewState state) {
                      if (state is GetLovsTypeDataSuccess) {
                        List<LovTypeDataList>? occupationList = state
                            .lovsTypeResponseModel.dataList
                            ?.where((item) => item.lovType == "OCCUPATION")
                            .toList();
                        List<String> occupationValue = occupationList
                                ?.map((item) => item.value ?? "")
                                .toList() ??
                            [];
                        return CommonTypeAheadField<String>(
                          suggestions: occupationValue,
                          suggestionToString: (district) => district,
                          onSelected: (selectedOccupation) {
                            _occupationTextEditingController.text =
                                selectedOccupation;
                            List<LovTypeDataList>? occupationTypeList = state
                                .lovsTypeResponseModel.dataList
                                ?.where((item) =>
                                    item.lovType == "OCCUPATION" &&
                                    item.value == selectedOccupation)
                                .toList();

                            // Print the id of the first item found
                            if (occupationTypeList != null &&
                                occupationTypeList.isNotEmpty) {
                              context.read<OtherDetailsCubit>().addDataFromUI(
                                    loanGuarantor: LoanGuarantorsList(
                                        occupationDataId: occupationTypeList[0]
                                            .id
                                            .toString()),
                                  );
                              if (kDebugMode) {
                                print(
                                    "Corresponding ID: ${occupationTypeList[0].id}");
                              }
                            }
                          },
                          controller: _occupationTextEditingController,
                          labelText: AppLocalizations.of(context)!.occupation,
                          hintText: AppLocalizations.of(context)!.occupation,
                        );
                      }
                      return  CommonTextField(
                        labelText: AppLocalizations.of(context)!.occupation,
                        enabled: false,
                      );
                    },
                  ),
                  // const GenderWidget(),

                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.netWorth,
                    prefixIcon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                    length: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    showPrefixIcon: true,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanGuarantor: LoanGuarantorsList(netWorth: value),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CommonTextField(
                    labelText: AppLocalizations.of(context)!.residentialAddress,
                    hintText: AppLocalizations.of(context)!.residentialAddress,
                    length: 100,
                    onChange: (value) {
                      context.read<OtherDetailsCubit>().addDataFromUI(
                            loanGuarantor: LoanGuarantorsList(address: value),
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
                              BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
                            builder: (BuildContext context,
                                OtherDetailsState state) {
                              if (state.loanGuarantor?.address != null &&
                                  state.loanGuarantor!.address!.isNotEmpty &&
                                  state.loanGuarantor?.guarantorName != null &&
                                  state.loanGuarantor!.guarantorName!
                                      .isNotEmpty &&
                                  state.loanGuarantor?.mobileNumber != null &&
                                  state.loanGuarantor!.mobileNumber!
                                      .isNotEmpty &&
                                  state.loanGuarantor?.occupationDataId !=
                                      null &&
                                  state.loanGuarantor!.occupationDataId!
                                      .isNotEmpty &&
                                  state.loanGuarantor?.netWorth != null &&
                                  state.loanGuarantor!.netWorth!.isNotEmpty &&
                                  state.loanGuarantor?.address != null &&
                                  state.loanGuarantor!.address!.isNotEmpty) {
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<OtherDetailsCubit>()
                                        .addGuarantorList(LoanGuarantorsList(
                                          occupationDataId: state
                                              .loanGuarantor?.occupationDataId,
                                          guarantorName: state
                                              .loanGuarantor?.guarantorName,
                                          age: state.loanGuarantor?.age,
                                          address: state.loanGuarantor?.address,
                                          mobileNumber:
                                              state.loanGuarantor?.mobileNumber,
                                          netWorth:
                                              state.loanGuarantor?.netWorth,
                                          listId: uuid.v4(),
                                        ));
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
    );
  }
}
