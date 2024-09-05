import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/common_widget/two_and_three_diveded_headers.dart';
import 'package:ekisan_credit/cubit/model/create_farmer_userinfo_cubit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/profile/screens/personal_information_screen.dart';
import 'package:ekisan_credit/view/profile/widgets/profile_progress_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../common_widget/header.dart';
import '../../../cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/form_validation.dart';
import '../../edit_profile/screens/edit_personal_information_first_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "profile-screen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    super.initState();
  }

  List arrayGenderList = List.empty(growable: true);
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isTitleFilled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isGenderFilled = ValueNotifier<bool>(false);
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
              percentageFirst: 33.3,
              percentageSecond: 0,
              percentageThird: 0,
              pageName: AppLocalizations.of(context)!.profile,
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
                        labelText: AppLocalizations.of(context)!.fullName,
                        hintText: AppLocalizations.of(context)!.asPerAadhaar,
                        onChange: (value) {
                          createFarmerUserInfoCubit.updateModel(
                              fullName: value);
                        },
                        validator: (value) =>
                            AppFormValidation.validateName(context, value),
                        length: 30,
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
                          contentList: [
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
                        labelText: AppLocalizations.of(context)!
                            .fullNameOfFatherOrHusband,
                        hintText: AppLocalizations.of(context)!
                            .fullNameOfFatherOrHusband,
                        validator: (value) =>
                            AppFormValidation.validateNameRelationName(
                                context, value),
                        length: 30,
                        onChange: (value) {
                          createFarmerUserInfoCubit.updateModel(
                              relativeName: value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    /*********** Gender ***************/
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

                    const SizedBox(
                      height: 16,
                    ),

                    /*********** Select Relation **********************/
                    // const SelectRelationWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<CreateFarmerUserInfoCubit,
                  CreateFarmerUserProfileInfoCubitModel>(
                builder: (BuildContext context,
                    CreateFarmerUserProfileInfoCubitModel
                        createFarmerUserProfileInfoCubitModel) {
                  if (createFarmerUserProfileInfoCubitModel.titleId != null &&
                      createFarmerUserProfileInfoCubitModel.fullName != null &&
                      createFarmerUserProfileInfoCubitModel
                          .fullName!.isNotEmpty &&
                      createFarmerUserProfileInfoCubitModel.relativeName !=
                          null &&
                      createFarmerUserProfileInfoCubitModel
                          .relativeName!.isNotEmpty &&
                      createFarmerUserProfileInfoCubitModel.genderId != null &&
                      createFarmerUserProfileInfoCubitModel.sdwOf != null) {
                    return InkWell(
                      onTap: () {
                        if (createFarmerUserInfoCubit.state.titleId == null) {
                          _isTitleFilled.value = true;
                        } else {
                          _isTitleFilled.value = false;
                        }
                        if (createFarmerUserInfoCubit.state.sdwOf == null) {
                          _isApplicantFilled.value = true;
                        } else {
                          _isApplicantFilled.value = false;
                        }
                        if (createFarmerUserInfoCubit.state.genderId == null) {
                          _isGenderFilled.value = true;
                        } else {
                          _isGenderFilled.value = false;
                        }
                        if (_formKey.currentState!.validate() &&
                            !_isGenderFilled.value &&
                            !_isTitleFilled.value) {
                          if (createFarmerUserInfoCubit.state.titleId == 380) {
                            createFarmerUserInfoCubit.updateModel(
                                sdwOf: "Son Of");
                          }
                          Navigator.pushNamed(
                              context, PersonalInformationScreen.routeName);
                        }
                        // Navigator.pushNamed(context, FamilyScreen.routeName);
                      },
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                      ),
                    );
                  }

                  return CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                      buttonColor: AppColors.grayColor);
                },
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

enum MrOF { sonOf }

enum Miss { daughter, wife }

class Applicant {
  MrOF? relation;

  Applicant({this.relation});
}
