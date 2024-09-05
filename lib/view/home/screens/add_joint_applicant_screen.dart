import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_bloc.dart';
import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_event.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../../../bloc/add_joint_applicant/add_joint_applicant_state.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../bloc/relationships/relationship_data_state.dart';
import '../../../common_button.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/joint_applicant/joint_applicant_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../model/response/relationship_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import '../../../utils/shared_preference_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddJointApplicantScreen extends StatefulWidget {
  static String routeName = "add-joint-applicant-screen";
  const AddJointApplicantScreen({super.key});

  @override
  State<AddJointApplicantScreen> createState() =>
      _AddJointApplicantScreenState();
}

class _AddJointApplicantScreenState extends State<AddJointApplicantScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController idProofNumberController = TextEditingController();
  final TextEditingController _proofIdNumberTextEditingController =
      TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();
  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year.toString().substring(2)}";
    setState(() {
      dateController = TextEditingController(text: formattedDate.toString());
      _formKey.currentState?.validate();
      dateController.selection = TextSelection(
          baseOffset: formattedDate.length, extentOffset: formattedDate.length);
    });
    return formattedDate;
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime now = DateTime.now();
    final DateTime maxBirthDate = DateTime(now.year - 18, now.month, now.day);
    final DateTime minBirthDate = DateTime(now.year - 80, now.month, now.day);
    final _formKey = GlobalKey<FormState>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxBirthDate,
      firstDate: minBirthDate,
      lastDate: maxBirthDate,
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );

    return picked;
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

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  @override
  void initState() {
    final lovsTypeData = [
      "GENDER",
      "IDPROOF",
    ];

    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.textBlackColor,
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.delete,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: AppColors.greenColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.add,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.userName,
                      onChange: (value) {
                        context
                            .read<JointApplicantInfoCubit>()
                            .updateModel(name: value);
                      },
                      validator: AppFormValidation.validateUserName,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<GetLovsTypeDataNewBloc,
                        GetLovsTypeDataNewState>(
                      builder: (BuildContext context,
                          GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? genderList = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) => item.lovType == "GENDER")
                              .toList();
                          // Extracting the gender values from the filtered list
                          List<String> genderValue = genderList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                          return TypeAheadField<String>(
                            controller: _genderController,
                            suggestionsCallback: (pattern) {
                              return getSuggestions(pattern, genderValue);
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                validator: AppFormValidation.validateGender,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.outLineColor),
                                  ),
                                  labelText:
                                      AppLocalizations.of(context)!.gender,
                                  labelStyle: const TextStyle(
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
                              _genderController.text = selectedGender;
                              _selectedValue.value = selectedGender;
                              List<LovTypeDataList>? genderList = state
                                  .lovsTypeResponseModel.dataList
                                  ?.where((item) =>
                                      item.lovType == "GENDER" &&
                                      item.value == selectedGender)
                                  .toList();

                              context
                                  .read<JointApplicantInfoCubit>()
                                  .updateModel(genderId: genderList?[0].id);

                              context.read<RelationshipDataBloc>().add(
                                      GetRelationshipList(bodyRequest: [
                                    genderList?[0].id.toString() ?? ''
                                  ]));
                            },
                          );
                        }

                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 24,
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
                            String dateOfBirth =
                                DateFormat('yyyy-MM-dd').format(value);
                            context
                                .read<JointApplicantInfoCubit>()
                                .updateModel(dateOfBirth: dateOfBirth);

                            // Output: 2006-04-29
                          }
                        });
                      },
                      child: ValueListenableBuilder(
                        valueListenable: _dateOfBirthString,
                        builder: (BuildContext context, value, Widget? child) {
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
                                        print(
                                            convertToDDMMYY(value.toString()));
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
                                                padding: EdgeInsets.only(
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

                    // CommonTextField(
                    //   labelText: "Date of Birth",
                    //   controller: dateController,
                    //   keyboardType: TextInputType.datetime,
                    //   validator: AppFormValidation.validateDate,
                    //   onChange: (value) {
                    //     _formKey.currentState?.validate();
                    //   },
                    //   onTap: () {
                    //     _selectDate(context).then((value) {
                    //       if (value != null) {
                    //         convertToDDMMYY(value.toString());
                    //         String dateOfBirth =
                    //             DateFormat('yyyy-MM-dd').format(value);
                    //         context
                    //             .read<JointApplicantInfoCubit>()
                    //             .updateModel(dateOfBirth: dateOfBirth);
                    //       }
                    //     });
                    //   },
                    //   vertical: 16,
                    //   suffix: const Icon(Icons.event),
                    // ),
                    const SizedBox(
                      height: 24,
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
                          List<String> idProofValues = identityTypeList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];

                          return TypeAheadField<String>(
                            controller: idProofNumberController,
                            suggestionsCallback: (pattern) {
                              return getSuggestions(pattern, idProofValues);
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                validator: (value) =>
                                    AppFormValidation.validateName(
                                        context, value),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.outLineColor),
                                  ),
                                  labelText:
                                      AppLocalizations.of(context)!.idProofType,
                                  labelStyle:
                                      TextStyle(color: AppColors.outLineColor),
                                ),
                              );
                            },
                            itemBuilder: (context, idProof) {
                              return ListTile(
                                title: Text(idProof),
                              );
                            },
                            onSelected: (selectedIdProof) {
                              idProofNumberController.text = selectedIdProof;
                              _selectedValue.value = selectedIdProof;
                              List<LovTypeDataList>? identityTypeList = state
                                  .lovsTypeResponseModel.dataList
                                  ?.where((item) =>
                                      item.lovType == "IDPROOF" &&
                                      item.value == selectedIdProof)
                                  .toList();
                              if (identityTypeList != null &&
                                  identityTypeList.isNotEmpty) {
                                context
                                    .read<JointApplicantInfoCubit>()
                                    .updateModel(
                                        idProofId: identityTypeList[0].id);

                                if (kDebugMode) {
                                  print(
                                      "Corresponding ID: ${identityTypeList[0].id}");
                                }
                              }
                            },
                          );
                        }

                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _selectedValue,
                      builder:
                          (BuildContext context, String value, Widget? child) {
                        return CommonTextField(
                          labelText:
                              AppLocalizations.of(context)!.idProofNumber,
                          controller: _proofIdNumberTextEditingController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (_selectedValue.value == "Pan Card") {
                              return AppFormValidation.validatePanCard(value);
                            } else if (_selectedValue.value == "Passport") {
                              return AppFormValidation.validatePassport(value);
                            } else if (_selectedValue.value ==
                                "Driving License") {
                              return AppFormValidation.validateDrivingLicense(
                                  value);
                            } else if (_selectedValue.value == "Voter ID") {
                              return AppFormValidation.validateVoterId(value);
                            }
                            return null;
                          },
                          vertical: 16,
                          onChange: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                            context
                                .read<JointApplicantInfoCubit>()
                                .updateModel(idProofNumber: value);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<RelationshipDataBloc, RelationshipDataState>(
                      builder:
                          (BuildContext context, RelationshipDataState state) {
                        if (state is GetRealationshipSuccess) {
                          List<RelationShipDataList>? relationshipList =
                              state.getRealtionshipResponseModel.dataList;
                          List<String> relationValues = relationshipList
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];
                          return TypeAheadField<String>(
                            controller: _relationshipController,
                            suggestionsCallback: (pattern) {
                              return getSuggestionsRelationship(
                                  pattern, relationValues);
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                validator: AppFormValidation.validateRelation,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.outLineColor),
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .relationWithApplicant,
                                  labelStyle: const TextStyle(
                                      color: AppColors.outLineColor),
                                ),
                                onChanged: (value) {},
                              );
                            },
                            itemBuilder: (context, relationship) {
                              return ListTile(
                                title: Text(relationship),
                              );
                            },
                            onSelected: (selectedRelationship) {
                              _relationshipController.text =
                                  selectedRelationship;

                              List<RelationShipDataList>? identityTypeList =
                                  state.getRealtionshipResponseModel.dataList
                                      ?.where((item) =>
                                          item.value == selectedRelationship)
                                      .toList();

                              context
                                  .read<JointApplicantInfoCubit>()
                                  .updateModel(
                                      relationId: identityTypeList?[0].id);
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocConsumer<AddJointApplicantBloc,
                      AddJointApplicantState>(
                    builder:
                        (BuildContext context, AddJointApplicantState state) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final jointInfoCubit =
                                context.read<JointApplicantInfoCubit>();
                            Map<String, dynamic> jointApplicant = {
                              "farmerId": await getFarmerId(),
                              "joinApplicantName": jointInfoCubit.state.name,
                              "dateOfBirth": jointInfoCubit.state.dateOfBirth,
                              "genderId": jointInfoCubit.state.genderId,
                              "idNumber": jointInfoCubit.state.idProofNumber,
                              "relationId": jointInfoCubit.state.relationId,
                              "idProodId": jointInfoCubit.state.idProofId,
                            };
                            if (kDebugMode) {
                              print("jointApplicant :$jointApplicant");
                            }
                            context.read<AddJointApplicantBloc>().add(
                                AddJointApplicantDetails(body: jointApplicant));
                          }
                        },
                        child: CommonButton(
                          buttonName: AppLocalizations.of(context)!.addCaps,
                        ),
                      );
                    },
                    listener:
                        (BuildContext context, AddJointApplicantState state) {
                      if (state is AddJointApplicantSuccess) {
                        context.read<GetJointApplicantBloc>().add(
                            GetJointApplicantList(body: const {"search": ""}));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
