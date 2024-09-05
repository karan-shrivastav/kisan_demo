import 'package:ekisan_credit/view/loan_request/loan_applicant/widgets/gender_widget.dart';
import 'package:ekisan_credit/view/loan_request/loan_applicant/widgets/relation_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../common_button.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../common_widget/common_text_field_widget.dart';
import '../../../../common_widget/common_type_ahed_widget.dart';
import '../../../../model/response/lovtype_type_response_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditJointApplicantBottomSheetWidget extends StatefulWidget {
  const EditJointApplicantBottomSheetWidget({super.key});

  @override
  State<EditJointApplicantBottomSheetWidget> createState() =>
      _EditJointApplicantBottomSheetWidgetState();
}

class _EditJointApplicantBottomSheetWidgetState
    extends State<EditJointApplicantBottomSheetWidget> {
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _idProofController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();

  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

  List<String> genderValue = [];
  List<String> idProofValues = [];
  List<String> relationValues = [];

  Future<DateTime?> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime now = DateTime.now();

    // Calculate the maximum birth date (18 years ago from now)
    final DateTime maxBirthDate = DateTime(now.year - 18, now.month, now.day);

    // Calculate the minimum birth date (80 years ago from now)
    final DateTime minBirthDate = DateTime(now.year - 80, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxBirthDate,
      // Set the initial date to the maximum birth date
      firstDate: minBirthDate,
      // Set the first selectable date to the minimum birth date
      lastDate: maxBirthDate,
      // Set the last selectable date to the maximum birth date
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );

    return picked;
  }

  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    _dateOfBirthString.value = formattedDate;

    return formattedDate;
  }

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  List<String> getSuggestionsRelationship(
      String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.zero,
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
                text: AppLocalizations.of(context)!.addJointApplicant,
                fontWeight: FontWeight.w400,
                fontSize: AppTextSize.contentSize22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CommonTextField(
                          labelText: AppLocalizations.of(context)!.userName),
                      const SizedBox(
                        height: 16,
                      ),
                      const GenderWidget(),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context).then((value) {
                            if (value != null) {
                              DateTime dateTime =
                                  DateTime.parse(value.toString());
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              convertToDDMMYY(formattedDate);
                              // Output: 2006-04-29
                            }
                          });
                        },
                        child: ValueListenableBuilder(
                          valueListenable: _dateOfBirthString,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (_dateOfBirthString.value.isNotEmpty) {
                              dateController = TextEditingController(
                                  text: _dateOfBirthString.value);
                              // Future.delayed(const Duration(seconds: 1),(){
                              //   _formKey.currentState?.validate();
                              // });
                            }

                            return Column(
                              children: [
                                CommonTextField(
                                  enabled: false,
                                  labelText:
                                      AppLocalizations.of(context)!.dateOfBirth,
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    if (kDebugMode) {
                                      print("000");
                                    }
                                    _selectDate(context).then((value) {
                                      if (kDebugMode) {}
                                      if (value != null) {
                                        convertToDDMMYY(value.toString());
                                        if (kDebugMode) {
                                          print("9890989");
                                        }
                                        if (kDebugMode) {
                                          print(convertToDDMMYY(
                                              value.toString()));
                                        }
                                      }
                                    });
                                  },
                                  vertical: 16,
                                  suffix: const Icon(Icons.event),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: _isShow,
                                    builder: (BuildContext context, value,
                                        Widget? child) {
                                      return _isShow.value &&
                                              _dateOfBirthString.value.isEmpty
                                          ? Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5, left: 13),
                                                  child: AppTextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .pleaseSelectDate,
                                                    textColor:
                                                        AppColors.errorColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox();
                                    })
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<GetLovsTypeDataNewBloc,
                              GetLovsTypeDataNewState>(
                          builder: (BuildContext context,
                              GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? identityTypeList = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) => item.lovType == "IDPROOF")
                              .toList();
                          idProofValues = identityTypeList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                        }
                        return CommonTypeAheadField<String>(
                          suggestions: idProofValues,
                          suggestionToString: (district) => district,
                          onSelected: (selectedDistrict) {
                            if (kDebugMode) {
                              print(selectedDistrict);
                            }
                            _idProofController.text = selectedDistrict;
                            // Handle the selected district logic here
                          },
                          controller: _idProofController,
                          labelText: AppLocalizations.of(context)!.idProofType,
                          hintText:
                              AppLocalizations.of(context)!.selectAnOption,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      CommonTextField(
                          labelText:
                              AppLocalizations.of(context)!.idProofNumber),
                      const SizedBox(
                        height: 16,
                      ),
                      const RelationWidget(),
                      const SizedBox(
                        height: 70,
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
                                child: CommonButton(
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
                              child: CommonButton(
                                buttonName: AppLocalizations.of(context)!.save,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
