import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/view/edit_profile/widgets/select_occupation_edit_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/update_personal_info/update_personal_info_bloc.dart';
import '../../../bloc/update_personal_info/update_personal_info_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/four_divided_headers.dart';
import '../../../common_widget/header.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../cubit/model/create_farmer_userinfo_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../widgets/religion_information_edit_widget.dart';
import 'edit_contact_information_first_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPersonalInformationThirdScreen extends StatefulWidget {
  static String routeName = "edit-personal-information-third-screen";

  const EditPersonalInformationThirdScreen({super.key});

  @override
  State<EditPersonalInformationThirdScreen> createState() =>
      _EditPersonalInformationThirdScreenState();
}

class _EditPersonalInformationThirdScreenState
    extends State<EditPersonalInformationThirdScreen> {
  final ValueNotifier<bool> _isCastFill = ValueNotifier<bool>(false);
  String? _selectedCasteName = '';
  String? _selectedPhysicallyChallangede = '';
  int? farmerId;
  GetFarmerByIdResponseModel getFarmerResponseModel =
      GetFarmerByIdResponseModel();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    _selectedCasteName = getFarmerResponseModel.data?.cast?.value ?? '';
    _selectedPhysicallyChallangede =
        getFarmerResponseModel.data?.physicallyChallenged ?? '';
    farmerId = getFarmerResponseModel.data?.farmerId ?? 0;

    if (_selectedCasteName != null) {
      _isCastFill.value = false;
    }

    final createFarmerCubit = context.read<CreateFarmerUserInfoCubit>();
    createFarmerCubit.updateModel(
        casteName: getFarmerResponseModel.data?.cast?.value ?? '',
        physicallyHandicapped:
            getFarmerResponseModel.data?.physicallyChallenged ?? '',
        casteId: getFarmerResponseModel.data?.cast?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerUserInfoCubit =
        context.read<CreateFarmerUserInfoCubit>().state;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 59,
          ),
          Header(
            pageNumber: 1,
            percentageFirst: 100.0,
            percentageSecond: 0.0,
            percentageThird: 0.0,
            pageName: AppLocalizations.of(context)!.editProfile,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                    const ReligionInformationEditWidget(),
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
                              return FourDividedHeaders(
                                title: AppLocalizations.of(context)!.caste,
                                contentList: namingValue,
                                savedSelectedValue: _selectedCasteName,
                                showError: _selectedCasteName!.isNotEmpty
                                    ? false
                                    : value,
                                onValueSelected: (String selectedCast) {
                                  // Filter naming titles list based on selected gender
                                  List<LovTypeDataList>? castTypeList = state
                                      .lovsTypeResponseModel.dataList
                                      ?.where((item) =>
                                          item.lovType == "CASTE" &&
                                          item.value == selectedCast)
                                      .toList();

                                  // Print the id of the first item found
                                  if (castTypeList != null &&
                                      castTypeList.isNotEmpty) {
                                    context
                                        .read<CreateFarmerUserInfoCubit>()
                                        .updateModel(
                                            casteId: castTypeList[0].id,
                                            casteName: selectedCast);
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
                                    print("Selected cast: $selectedCast");
                                  }
                                },
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
                    const SelectOccupationEditWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    TwoAndThreeDividedHeaders(
                      title: AppLocalizations.of(context)!
                          .areYouPhysicallyChallenged,
                      savedSelectedValue: _selectedPhysicallyChallangede,
                      contentList: const [
                        'Yes',
                        'No',
                      ],
                      onValueSelected: (value) {
                        context
                            .read<CreateFarmerUserInfoCubit>()
                            .updateModel(physicallyHandicapped: value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<CreateFarmerUserInfoCubit,
                CreateFarmerUserProfileInfoCubitModel>(
              builder: (BuildContext context,
                  CreateFarmerUserProfileInfoCubitModel state) {
                if (state.selectedRegionString != "" &&
                    state.selectedOccupationString != "" &&
                    state.physicallyHandicapped != null &&
                    state.physicallyHandicapped != "" &&
                    state.selectedOccupationString != null &&
                    state.selectedOccupationString != "") {
                  return InkWell(
                    onTap: () {
                      final createFarmerUserInfoCubit =
                          context.read<CreateFarmerUserInfoCubit>();
                      if (kDebugMode) {
                        print(createFarmerUserInfoCubit.state.toJson());
                      }

                      if (createFarmerUserInfoCubit.state.casteName == null) {
                        _isCastFill.value = true;
                      } else {
                        _isCastFill.value = false;
                      }
                      if (_formKey.currentState!.validate()) {
                        final bodyRequest = {
                          "titleId": createFarmerUserInfoCubit.state.titleId ??
                              getFarmerResponseModel.data?.title?.id ??
                              0,
                          "genderId":
                              createFarmerUserInfoCubit.state.genderId ??
                                  getFarmerResponseModel.data?.gender?.id ??
                                  0,
                          "religionId":
                              createFarmerUserInfoCubit.state.religionId ??
                                  getFarmerResponseModel.data?.religion?.id ??
                                  0,
                          "casteId": createFarmerUserInfoCubit.state.casteId ??
                              getFarmerResponseModel.data?.cast?.id ??
                              0,
                          "occupationId":
                              createFarmerUserInfoCubit.state.occupationId ??
                                  getFarmerResponseModel.data?.occupation?.id ??
                                  0,
                          "proofOfIdentityId": createFarmerUserInfoCubit
                                  .state.proofOfIdentityId ??
                              getFarmerResponseModel
                                  .data?.proofOfIdentity?.id ??
                              0,
                          "physicallyHandicapped": createFarmerUserInfoCubit
                                  .state.physicallyHandicapped ??
                              getFarmerResponseModel.data?.physicallyChallenged,
                          "fullName":
                              createFarmerUserInfoCubit.state.fullName ??
                                  getFarmerResponseModel.data?.fullName,
                          "dateOfBirth": "1999-12-31",
                          "sdwOf": createFarmerUserInfoCubit.state.sdwOf,
                          "relativeName":
                              createFarmerUserInfoCubit.state.relativeName ??
                                  getFarmerResponseModel.data?.relativeName,
                          "aadhaarNo": "",
                          "idProofNo":
                              createFarmerUserInfoCubit.state.idProofNo ??
                                  getFarmerResponseModel.data?.idProofNumber ??
                                  '',
                          "aadhaarAddress": "",
                          "casteName":
                              createFarmerUserInfoCubit.state.casteName ??
                                  getFarmerResponseModel.data?.cast?.value ??
                                  '',
                        };
                        context.read<UpdatePersonalInfoBloc>().add(
                            UpdatePersonalInfoDetails(
                                body: bodyRequest, farmerId: farmerId ?? 0));

                        Navigator.pushNamed(context,
                            EditContactInformationFirstScreen.routeName);
                      }
                    },
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.save,
                    ),
                  );
                }
                return CommonButton(
                  buttonName: AppLocalizations.of(context)!.save,
                  buttonColor: AppColors.grayColor,
                );
              },
              listener: (BuildContext context,
                  CreateFarmerUserProfileInfoCubitModel state) {},
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
