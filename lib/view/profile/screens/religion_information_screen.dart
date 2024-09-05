import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/cubit/model/create_farmer_userinfo_cubit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/register_farmer/register_farmer_bloc.dart';
import '../../../bloc/register_farmer/register_farmer_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/drop_down_widget.dart';
import '../../../common_widget/four_divided_headers.dart';
import '../../../common_widget/header.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../widgets/profile_progress_header.dart';
import '../widgets/religin_information_widget.dart';
import '../widgets/select_occupation_widget.dart';
import 'address_information_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReligionInformationScreen extends StatelessWidget {
  static String routeName = "religion-information-screen";

  ReligionInformationScreen({super.key});

  final ValueNotifier<bool> _isCastFill = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPhysicallyChallengedFilled =
      ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createFarmerUserInfoCubit = context.read<CreateFarmerUserInfoCubit>();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 59,
          ),
          Header(
            pageNumber: 1,
            percentageFirst: 100,
            percentageSecond: 0,
            percentageThird: 0,
            pageName: AppLocalizations.of(context)!.profile,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!
                                  .personalInformation,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const ReligionInformationWidget(),
                          const SizedBox(
                            height: 24,
                          ),
                          BlocConsumer<GetLovsTypeDataNewBloc,
                              GetLovsTypeDataNewState>(
                            builder: (BuildContext context,
                                GetLovsTypeDataNewState state) {
                              if (state is GetLovsTypeDataSuccess) {
                                List<LovTypeDataList>? castTypeListData = state
                                    .lovsTypeResponseModel.dataList
                                    ?.where((item) => item.lovType == "CASTE")
                                    .toList();

                                // Extracting the gender values from the filtered list
                                List<String> namingValue = castTypeListData
                                        ?.map((item) => item.value ?? "")
                                        .toList() ??
                                    [];
                                namingValue.sort();

                                // Assuming TwoAndThreeDividedHeaders is a widget to display headers
                                return ValueListenableBuilder(
                                  valueListenable: _isCastFill,
                                  builder: (BuildContext context, bool value,
                                      Widget? child) {
                                    return Column(
                                      children: [
                                        FourDividedHeaders(
                                          title: AppLocalizations.of(context)!
                                              .caste,
                                          contentList: namingValue,
                                          savedSelectedValue:
                                              createFarmerUserInfoCubit
                                                  .state.casteName,
                                          showError: value,
                                          onValueSelected:
                                              (String selectedCast) {
                                            // Filter naming titles list based on selected gender
                                            List<LovTypeDataList>?
                                                castTypeList = state
                                                    .lovsTypeResponseModel
                                                    .dataList
                                                    ?.where((item) =>
                                                        item.lovType ==
                                                            "CASTE" &&
                                                        item.value ==
                                                            selectedCast)
                                                    .toList();

                                            // Print the id of the first item found
                                            if (castTypeList != null &&
                                                castTypeList.isNotEmpty) {
                                              context
                                                  .read<
                                                      CreateFarmerUserInfoCubit>()
                                                  .updateModel(
                                                      casteId:
                                                          castTypeList[0].id,
                                                      casteName: selectedCast);
                                              if (createFarmerUserInfoCubit
                                                      .state.casteName ==
                                                  null) {
                                                _isCastFill.value = true;
                                              } else {
                                                _isCastFill.value = false;
                                              }
                                              if (kDebugMode) {
                                                print(
                                                    "Selected cast: $selectedCast, Corresponding ID: ${castTypeList[0].id}");
                                              }
                                            } else {
                                              if (kDebugMode) {
                                                print(
                                                    "No naming title found for selected gender: $selectedCast");
                                              }
                                            }
                                            if (kDebugMode) {
                                              print(
                                                  "Selected cast: $selectedCast");
                                            }
                                          },
                                        ),
                                        if (value)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 5),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16,
                                                  ),
                                                  child: AppTextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .pleaseSelectCaste,
                                                    fontSize: 14,
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
                          ),
                          // const FourDividedHeaders(
                          //   title: 'Caste',
                          //   contentList: ['General', 'SC', 'ST', 'OBC'],
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SelectOccupationWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _isPhysicallyChallengedFilled,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return Column(
                                children: [
                                  TwoAndThreeDividedHeaders(
                                    title: AppLocalizations.of(context)!
                                        .areYouPhysicallyChallenged,
                                    contentList: const [
                                      'Yes',
                                      'No',
                                    ],
                                    showError: value,
                                    savedSelectedValue:
                                        createFarmerUserInfoCubit
                                            .state.physicallyHandicapped,
                                    onValueSelected: (value) {
                                      context
                                          .read<CreateFarmerUserInfoCubit>()
                                          .updateModel(
                                              physicallyHandicapped: value);
                                      if (createFarmerUserInfoCubit
                                              .state.physicallyHandicapped ==
                                          null) {
                                        _isPhysicallyChallengedFilled.value =
                                            true;
                                      } else {
                                        _isPhysicallyChallengedFilled.value =
                                            false;
                                      }
                                    },
                                  ),
                                  if (value)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16,
                                            ),
                                            child: AppTextWidget(
                                              text: AppLocalizations.of(
                                                      context)!
                                                  .pleaseSelectPhysicallyChallenged,
                                              fontSize: 14,
                                              textColor: AppColors.errorColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BlocBuilder<CreateFarmerUserInfoCubit,
                        CreateFarmerUserProfileInfoCubitModel>(
                      builder: (BuildContext context,
                          CreateFarmerUserProfileInfoCubitModel state) {
                        if (state.relativeName != null &&
                            state.relativeName!.isNotEmpty &&
                            state.casteName != null &&
                            state.casteName!.isNotEmpty &&
                            state.selectedOccupationString != null &&
                            state.selectedOccupationString!.isNotEmpty &&
                            state.physicallyHandicapped != null &&
                            state.physicallyHandicapped!.isNotEmpty) {
                          return InkWell(
                            onTap: () {
                              final createFarmerUserInfoCubit =
                                  context.read<CreateFarmerUserInfoCubit>();
                              if (kDebugMode) {
                                print(createFarmerUserInfoCubit.state.toJson());
                              }
                              if (createFarmerUserInfoCubit.state.casteName ==
                                  null) {
                                _isCastFill.value = true;
                              } else {
                                _isCastFill.value = false;
                              }
                              if (createFarmerUserInfoCubit
                                      .state.physicallyHandicapped ==
                                  null) {
                                _isPhysicallyChallengedFilled.value = true;
                              } else {
                                _isPhysicallyChallengedFilled.value = false;
                              }
                              if (_formKey.currentState!.validate()) {
                                final bodyRequest = {
                                  "titleId":
                                      createFarmerUserInfoCubit.state.titleId,
                                  "genderId":
                                      createFarmerUserInfoCubit.state.genderId,
                                  "religionId": createFarmerUserInfoCubit
                                      .state.religionId,
                                  "casteId":
                                      createFarmerUserInfoCubit.state.casteId,
                                  "occupationId": createFarmerUserInfoCubit
                                      .state.occupationId,
                                  "proofOfIdentityId": createFarmerUserInfoCubit
                                      .state.proofOfIdentityId,
                                  "physicallyHandicapped":
                                      createFarmerUserInfoCubit
                                          .state.physicallyHandicapped,
                                  "fullName":
                                      createFarmerUserInfoCubit.state.fullName,
                                  "dateOfBirth": createFarmerUserInfoCubit
                                      .state.dateOfBirth,
                                  "sdwOf":  createFarmerUserInfoCubit.state.sdwOf,
                                  "relativeName": createFarmerUserInfoCubit
                                      .state.relativeName,
                                  "aadhaarNo": "",
                                  "idProofNo":
                                      createFarmerUserInfoCubit.state.idProofNo,
                                  "aadhaarAddress": "",
                                  "casteName":
                                      createFarmerUserInfoCubit.state.casteName,
                                };

                                context.read<RegisterFarmerBloc>().add(
                                    CreateFarmerUserInfo(
                                        bodyRequest: bodyRequest));
                                Navigator.pushNamed(context,
                                    AddressInformationScreen.routeName);
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
