import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_bloc.dart';
import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_state.dart';
import 'package:ekisan_credit/view/loan_request/loan_applicant/widgets/gender_widget.dart';
import 'package:ekisan_credit/view/loan_request/loan_applicant/widgets/relation_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../../../../Utils/shared_preference_helper.dart';
import '../../../../bloc/add_joint_applicant/add_joint_applicant_event.dart';
import '../../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../common_button.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../common_widget/common_text_field_widget.dart';
import '../../../../cubit/joint_applicant/loan_applicant_cubit.dart';
import '../../../../model/response/lovtype_type_response_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddJointApplicantBottomSheetWidget extends StatefulWidget {
  const AddJointApplicantBottomSheetWidget({super.key});

  @override
  State<AddJointApplicantBottomSheetWidget> createState() =>
      _AddJointApplicantBottomSheetWidgetState();
}

class _AddJointApplicantBottomSheetWidgetState
    extends State<AddJointApplicantBottomSheetWidget> {
  final TextEditingController _idProofController = TextEditingController();
  final TextEditingController _idProofIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

  AppFormValidation validation = AppFormValidation();

  List<String> genderValue = [];
  List<String> idProofValues = [];
  List<String> relationValues = [];
  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");

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

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                text: AppLocalizations.of(context)!.addJointApplicant,
                fontWeight: FontWeight.w400,
                fontSize: AppTextSize.contentSize22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          controller: _userNameController,
                          labelText: AppLocalizations.of(context)!.userName,
                          validator: (value)=> AppFormValidation.validateName(context,value),
                        ),
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

                                context
                                    .read<LoanJointApplicantInfoCubit>()
                                    .updateModel(dateOfBirth: formattedDate);
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
                                    labelText: AppLocalizations.of(context)!.dateOfBirth,
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
                                                      text:
                                                          AppLocalizations.of(context)!.pleaseSelectDate,
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
                              List<LovTypeDataList>? idProofList = state
                                  .lovsTypeResponseModel.dataList
                                  ?.where((item) => item.lovType == "IDPROOF")
                                  .toList();
                              // Extracting the gender values from the filtered list
                              List<String> genderValue = idProofList
                                      ?.map((item) => item.value ?? "")
                                      .toList() ??
                                  [];
                              return TypeAheadField<String>(
                                controller: _idProofController,
                                suggestionsCallback: (pattern) {
                                  return getSuggestions(pattern, genderValue);
                                },
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    validator: (value)=> AppFormValidation.validateName(context,value),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration:  InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.outLineColor),
                                      ),
                                      labelText: AppLocalizations.of(context)!.idProofType,
                                      labelStyle: TextStyle(
                                          color: AppColors.outLineColor),
                                    ),
                                  );
                                },
                                itemBuilder: (context, gender) {
                                  return ListTile(
                                    title: Text(gender),
                                  );
                                },
                                onSelected: (selectedGender) {
                                  _idProofController.text = selectedGender;
                                  _selectedValue.value = selectedGender;
                                  List<LovTypeDataList>? idProofList = state
                                      .lovsTypeResponseModel.dataList
                                      ?.where((item) =>
                                          item.lovType == "IDPROOF" &&
                                          item.value == selectedGender)
                                      .toList();
                                  context
                                      .read<LoanJointApplicantInfoCubit>()
                                      .updateModel(
                                          idProofId: idProofList?[0].id);
                                  final loanJointInfoCubit = context
                                      .read<LoanJointApplicantInfoCubit>();
                                  print(
                                      'This is Id : ${loanJointInfoCubit.state.idProofId ?? ''}');
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ValueListenableBuilder(
                          valueListenable: _selectedValue,
                          builder: (BuildContext context, String value, Widget? child) {
                            return CommonTextField(
                              labelText: AppLocalizations.of(context)!.enterIdProofNumber,
                              controller: _idProofIdController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (_selectedValue.value == "Pan Card") {
                                  return AppFormValidation.validatePanCard(value);
                                } else if (_selectedValue.value == "Passport") {
                                  return AppFormValidation.validatePassport(value);
                                } else if (_selectedValue.value == "Driving License") {
                                  return AppFormValidation.validateDrivingLicense(value);
                                } else if (_selectedValue.value == "Voter ID") {
                                  return AppFormValidation.validateVoterId(value);
                                }
                                // If no specific validation is needed based on the selected value,
                                // you can return null to indicate that the field is valid.
                                return null;
                              },

                            );
                          },
                        ),
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
                                child: BlocConsumer<AddJointApplicantBloc,
                                    AddJointApplicantState>(
                                  builder: (BuildContext context,
                                      AddJointApplicantState state) {
                                    return InkWell(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final loanJointInfoCubit =
                                              context.read<
                                                  LoanJointApplicantInfoCubit>();
                                          final int genderId =
                                              loanJointInfoCubit
                                                      .state.genderId ??
                                                  0;
                                          final int idProofId =
                                              loanJointInfoCubit
                                                      .state.idProofId ??
                                                  0;
                                          final int relationId =
                                              loanJointInfoCubit
                                                      .state.relationId ??
                                                  0;
                                          final String dateOfBirth =
                                              loanJointInfoCubit
                                                      .state.dateOfBirth ??
                                                  '';
                                          Map<String, dynamic> jointApplicant =
                                              {
                                            "farmerId": await getFarmerId(),
                                            "joinApplicantName":
                                                _userNameController.text,
                                            "dateOfBirth": dateOfBirth,
                                            "genderId": genderId,
                                            "idNumber":
                                                _idProofIdController.text,
                                            "relationId": relationId,
                                            "idProodId": idProofId,
                                          };
                                          if (kDebugMode) {
                                            print(
                                              "jointApplicant :$jointApplicant");
                                          }
                                          context
                                              .read<AddJointApplicantBloc>()
                                              .add(AddJointApplicantDetails(
                                                  body: jointApplicant));
                                        }
                                      },
                                      child:  CommonButton(
                                        buttonName: AppLocalizations.of(context)!.save,
                                      ),
                                    );
                                  },
                                  listener: (BuildContext context,
                                      AddJointApplicantState state) {
                                    if (state is AddJointApplicantSuccess) {
                                      context.read<GetJointApplicantBloc>().add(
                                          GetJointApplicantList(
                                              body: const {"search": ""}));
                                      Navigator.of(context).pop();
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
