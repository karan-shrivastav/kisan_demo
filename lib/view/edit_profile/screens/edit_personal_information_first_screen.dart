import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/common_widget/header.dart';
import 'package:ekisan_credit/common_widget/two_and_three_diveded_headers.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import '../../../cubit/model/create_farmer_userinfo_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/form_validation.dart';
import '../../profile/screens/profile_screen.dart';
import 'edit_personal_information_second_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPersonalInformationFirstScreen extends StatefulWidget {
  static String routeName = "edit-personal-information-first-screen";

  const EditPersonalInformationFirstScreen({super.key});

  @override
  State<EditPersonalInformationFirstScreen> createState() =>
      _EditPersonalInformationFirstScreenState();
}

class _EditPersonalInformationFirstScreenState
    extends State<EditPersonalInformationFirstScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _relativeNameController = TextEditingController();
  final ValueNotifier<bool> _isTitleFilled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);
  String? _selectedTitleValue = '';
  String? _selectedGenderValue = '';

  @override
  void initState() {
    context.read<CreateFarmerUserInfoCubit>().clear();
    // TODO: implement initState

    final lovsTypeData = [
      "AREAUNIT",
      "OWNERSHIP",
      "SOURCEIRRIGATIONNAME",
      "GENDER",
      "NAMINGTITLE",
      "IDPROOF",
      "RELIGIONNAME",
      "CASTE",
      "OCCUPATION"
    ];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    // context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    var dataCubit = context.read<CreateFarmerUserInfoCubit>();
    _fullNameController.text = getFarmerResponseModel.data?.fullName ?? '';
    _relativeNameController.text =
        getFarmerResponseModel.data?.relativeName ?? '';
    _selectedTitleValue = getFarmerResponseModel.data?.title?.value ?? '';
    if (_selectedTitleValue != null) {
      _isTitleFilled.value = false;
    }
    _selectedGenderValue = getFarmerResponseModel.data?.gender?.value ?? '';
    if (_selectedGenderValue != null) {
      _isGenderFilled.value = false;
    }
    dataCubit.updateModel(
        fullName: getFarmerResponseModel.data?.fullName ?? '',
        relativeName: getFarmerResponseModel.data?.relativeName ?? '',
        titleId: getFarmerResponseModel.data?.title?.id ?? 0,
        genderId: getFarmerResponseModel.data?.gender?.id ?? 0);

    super.didChangeDependencies();
  }

  List arrayGenderList = List.empty(growable: true);
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isApplicantFilled = ValueNotifier<bool>(false);
  Applicant applicant = Applicant(relation: MrOF.sonOf);

  @override
  Widget build(BuildContext context) {
    final createFarmerUserInfoCubit = context.read<CreateFarmerUserInfoCubit>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 59,
            ),
            Header(
              pageNumber: 1,
              percentageFirst: 33.33,
              percentageSecond: 0,
              percentageThird: 0,
              pageName: AppLocalizations.of(context)!.editProfile,
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: AppTextWidget(
                        text: AppLocalizations.of(context)!.personalInformation,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocConsumer<GetLovsTypeDataNewBloc,
                        GetLovsTypeDataNewState>(
                      builder: (BuildContext context,
                          GetLovsTypeDataNewState state) {
                        if (state is GetLovsTypeDataSuccess) {
                          List<LovTypeDataList>? namingTitle = state
                              .lovsTypeResponseModel.dataList
                              ?.where((item) => item.lovType == "NAMINGTITLE")
                              .toList();

                          // Extracting the gender values from the filtered list
                          List<String> namingValue = namingTitle
                                  ?.map((item) => item.value ?? "")
                                  .toList() ??
                              [];

                          // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                          return ValueListenableBuilder(
                            valueListenable: _isTitleFilled,
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Column(
                                children: [
                                  TwoAndThreeDividedHeaders(
                                    savedSelectedValue: _selectedTitleValue,
                                    title: AppLocalizations.of(context)!.title,
                                    contentList: namingValue,
                                    showError: value,
                                    onValueSelected: (String selectedGender) {
                                      // Filter naming titles list based on selected gender
                                      List<LovTypeDataList>? namingTitle = state
                                          .lovsTypeResponseModel.dataList
                                          ?.where((item) =>
                                              item.lovType == "NAMINGTITLE" &&
                                              item.value == selectedGender)
                                          .toList();

                                      // Print the id of the first item found
                                      if (namingTitle != null &&
                                          namingTitle.isNotEmpty) {
                                        createFarmerUserInfoCubit.updateModel(
                                            titleId: namingTitle[0].id);
                                        if (createFarmerUserInfoCubit
                                                .state.titleId ==
                                            null) {
                                          _isTitleFilled.value = true;
                                        } else {
                                          _isTitleFilled.value = false;
                                        }
                                        if (kDebugMode) {
                                          print(
                                              "Selected Name: $selectedGender, Corresponding ID: ${namingTitle[0].id}");
                                        }
                                      } else {
                                        if (kDebugMode) {
                                          print(
                                              "No naming title found for selected name: $selectedGender");
                                        }
                                      }
                                      if (kDebugMode) {
                                        print("Selected name: $selectedGender");
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
                                                      .pleaSelectTitle,
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonTextField(
                        controller: _fullNameController,
                        labelText: AppLocalizations.of(context)!.fullName,
                        hintText: AppLocalizations.of(context)!.asPerAadhaar,
                        vertical: 16,
                        onChange: (value) {
                          createFarmerUserInfoCubit.updateModel(
                              fullName: value);
                          print('VAL :$value');
                        },
                        validator: (value) =>
                            AppFormValidation.validateName(context, value),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<CreateFarmerUserInfoCubit,
                        CreateFarmerUserProfileInfoCubitModel>(
                      builder: (BuildContext context,
                          CreateFarmerUserProfileInfoCubitModel state) {
                        if (state.titleId != null && state.titleId == 380) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .applicantRelatesAs,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 48,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SegmentedButton<MrOF>(
                                          style: SegmentedButton.styleFrom(
                                            backgroundColor: Colors.grey[200],
                                            foregroundColor: Colors.red,
                                            selectedForegroundColor:
                                                AppColors.textBlackColor,
                                            selectedBackgroundColor:
                                                Color(0xFFD7E8CD),
                                          ),
                                          segments: const <ButtonSegment<MrOF>>[
                                            ButtonSegment<MrOF>(
                                                value: MrOF.sonOf,
                                                label: Text('Son Of'),
                                                icon: null),
                                          ],
                                          selected: {applicant.relation!},
                                          onSelectionChanged:
                                              (Set<MrOF> newSelection) {
                                            print(newSelection);
                                            // setState(() {
                                            //
                                            //
                                            //   // By default there is only a single segment that can be
                                            //   // selected at one time, so its value is always the first
                                            //   // item in the selected set.
                                            //
                                            // });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (state.titleId != null && state.titleId != 380) {
                          return ValueListenableBuilder(
                            valueListenable: _isApplicantFilled,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return TwoAndThreeDividedHeaders(
                                title: AppLocalizations.of(context)!
                                    .applicantRelatesAs,
                                contentList: const [
                                  'Daughter of',
                                  'Wife of',
                                ],
                                onValueSelected: (value) {
                                  createFarmerUserInfoCubit.updateModel(
                                      sdwOf: value);
                                },
                                showError: value,
                              );
                            },
                          );
                        }

                        return TwoAndThreeDividedHeaders(
                          title:
                              AppLocalizations.of(context)!.applicantRelatesAs,
                          contentList: const [
                            'Daughter of',
                            "Son Of",
                            'Wife of',
                          ],
                          isSelect: false,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonTextField(
                        controller: _relativeNameController,
                        labelText:
                            AppLocalizations.of(context)!.fullNameOfFather,
                        hintText: AppLocalizations.of(context)!
                            .fullNameOfFatherOrHusband,
                        vertical: 16,
                        validator: (value) =>
                            AppFormValidation.validateName(context, value),
                        onChange: (value) {
                          createFarmerUserInfoCubit.updateModel(
                              relativeName: value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<CreateFarmerUserInfoCubit,
                        CreateFarmerUserProfileInfoCubitModel>(
                      builder: (BuildContext context,
                          CreateFarmerUserProfileInfoCubitModel farmerState) {
                        return BlocConsumer<GetLovsTypeDataNewBloc,
                            GetLovsTypeDataNewState>(
                          builder: (BuildContext context,
                              GetLovsTypeDataNewState state) {
                            if (state is GetLovsTypeDataSuccess) {
                              List<LovTypeDataList>? genderList = state
                                  .lovsTypeResponseModel.dataList
                                  ?.where((item) => item.lovType == "GENDER")
                                  .toList();

                              // Extracting the gender values from the filtered list
                              List<String> namingValue = genderList
                                      ?.map((item) => item.value ?? "")
                                      .toList() ??
                                  [];
                              // Assuming the id value is set somewhere in your code

                              List<String> conditionalNamingValue;
                              if (farmerState.titleId == 380) {
                                conditionalNamingValue = namingValue
                                    .where((value) => value != "Female")
                                    .toList();
                                conditionalNamingValue.sort();
                              } else {
                                conditionalNamingValue = namingValue
                                    .where((value) => value != "Male")
                                    .toList();
                                conditionalNamingValue.sort();
                              }

                              // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                              return ValueListenableBuilder(
                                valueListenable: _isGenderFilled,
                                builder: (BuildContext context, value,
                                    Widget? child) {
                                  return Column(
                                    children: [
                                      TwoAndThreeDividedHeaders(
                                        savedSelectedValue:
                                            _selectedGenderValue,
                                        title: AppLocalizations.of(context)!
                                            .gender,
                                        contentList: conditionalNamingValue,
                                        showError: value,
                                        onValueSelected:
                                            (String selectedGender) {
                                          // Filter naming titles list based on selected gender
                                          List<LovTypeDataList>? genderList =
                                              state.lovsTypeResponseModel
                                                  .dataList
                                                  ?.where((item) =>
                                                      item.lovType ==
                                                          "GENDER" &&
                                                      item.value ==
                                                          selectedGender)
                                                  .toList();

                                          // Print the id of the first item found
                                          if (genderList != null &&
                                              genderList.isNotEmpty) {
                                            createFarmerUserInfoCubit
                                                .updateModel(
                                                    genderId: genderList[0].id);
                                            if (createFarmerUserInfoCubit
                                                    .state.genderId ==
                                                null) {
                                              _isGenderFilled.value = true;
                                            } else {
                                              _isGenderFilled.value = false;
                                            }
                                            context
                                                .read<RelationshipDataBloc>()
                                                .add(GetRelationshipList(
                                                    bodyRequest: [
                                                      genderList[0]
                                                          .id
                                                          .toString()
                                                    ]));

                                            if (kDebugMode) {
                                              print(
                                                  "Selected gender: $selectedGender, Corresponding ID: ${genderList[0].id}");
                                            }
                                          } else {
                                            if (kDebugMode) {
                                              print(
                                                  "No naming title found for selected gender: $selectedGender");
                                            }
                                          }
                                          if (kDebugMode) {
                                            print(
                                                "Selected gender: $selectedGender");
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
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .selectGender,
                                                  fontSize: 12,
                                                  textColor:
                                                      AppColors.errorColor,
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
                        );
                      },
                    ),
                    /*********** Select Relation **********************/
                    // const SelectRelationWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<CreateFarmerUserInfoCubit,
                  CreateFarmerUserProfileInfoCubitModel>(
                builder: (BuildContext context,
                    CreateFarmerUserProfileInfoCubitModel state) {
                  if (state.titleId != null &&
                      state.fullName != null &&
                      state.fullName != "" &&
                      state.relativeName != null &&
                      state.relativeName != "" &&
                      state.genderId != null) {
                    print(state.fullName);
                    print('Inside true');
                    return InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            !_isGenderFilled.value &&
                            !_isTitleFilled.value) {
                          Navigator.pushNamed(context,
                              EditPersonalInformationSecondScreen.routeName);
                        }
                      },
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                      ),
                    );
                  }
                  return CommonButton(
                    buttonName: AppLocalizations.of(context)!.next,
                    buttonColor: AppColors.grayColor,
                  );
                },
                listener: (BuildContext context,
                    CreateFarmerUserProfileInfoCubitModel state) {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
