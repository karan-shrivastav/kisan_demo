import 'package:ekisan_credit/bloc/apply_loan_request/apply_loan_request_state.dart';
import 'package:ekisan_credit/bloc/get_joint_applicant/get_joint_applicant_state.dart';
import 'package:ekisan_credit/bloc/selected_joint_applicant/selected_joint_applicant_bloc.dart';
import 'package:ekisan_credit/bloc/selected_joint_applicant/selected_joint_applicant_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/apply_loan_request/apply_laon_request_event.dart';
import '../../../../../bloc/apply_loan_request/apply_loan_request_bloc.dart';
import '../../../../../bloc/delete_joint_applicant/delete_joint_applicant_bloc.dart';
import '../../../../../bloc/delete_joint_applicant/delete_joint_applicant_event.dart';
import '../../../../../bloc/delete_joint_applicant/delete_joint_applicant_state.dart';
import '../../../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../../../bloc/selected_joint_applicant/selected_joint_applicant_event.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/incomplete_loan/incomplete_loan_cubit.dart';
import '../../../../../cubit/loan_purpose/loan_purpose_cubit.dart';
import '../../../../../model/response/get_joint_applicant_response_model.dart';
import '../../../../../model/response/selected_joint_applicant_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../../../loan_request/loan_applicant/widgets/add_joint_applicant_bottomsheet_widget.dart';
import '../../incomplete_land/screens/incomplete_land_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteLoanApplicant extends StatefulWidget {
  static const routeName = 'incomplete-loan-applicant';

  const IncompleteLoanApplicant({super.key});

  @override
  State<IncompleteLoanApplicant> createState() =>
      _IncompleteLoanApplicantState();
}

class _IncompleteLoanApplicantState extends State<IncompleteLoanApplicant> {
  TextEditingController dateController = TextEditingController();
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isEnable = ValueNotifier<bool>(false);
  // bool isOn = false;

  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    _dateOfBirthString.value = formattedDate;

    return formattedDate;
  }

  List<int> selectedIndices = [];

  List<ApplicantDto> selectedJointApplicant = [];
  List<Content> jointApplicantListData = [];

  bool isSelected = false;

  var jointDetailsBloc = GetJointApplicantBloc();

  var selectedJointApplicantBloc = SelectedJointApplicantBloc();

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  @override
  void initState() {
    final incompleteJointApplicant = context.read<IncompleteLoanInfoCubit>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      jointDetailsBloc.add(GetJointApplicantList(body: const {"search": ""}));
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedJointApplicantBloc.add(GetSelectedApplicantDetails(
          loanId: await getIncompleteLoanId() ?? ''));
    });

    if (incompleteJointApplicant.state.jointApplicant == "Yes") {
      _isEnable.value = true;
    }
    final getJointApplicantListBloc = context.read<GetJointApplicantBloc>();
    super.initState();

    getJointApplicantListBloc
        .add(GetJointApplicantList(body: const {"search": ""}));

    jointDetailsBloc.stream.listen((state) {
      if (state is GetJointApplicantSuccess) {
        jointApplicantListData =
            state.getJointApplicantResponseModel.data?.content ?? [];
        setState(() {});
      }
    });

    selectedJointApplicantBloc.stream.listen((state) {
      if (state is SelectedJointApplicantSuccess) {
        selectedJointApplicant =
            state.selectedJointApplicantResponseModel.data?.applicantDtos ?? [];
        for (int index = 0; index < jointApplicantListData.length; index++) {
          for (int i = 0; i < selectedJointApplicant.length; i++) {
            if (selectedJointApplicant[i].id ==
                jointApplicantListData[index].id) {
              selectedIndices.add(selectedJointApplicant[i].id ?? 0);
              setState(() {});
            }
          }
        }
      }
    });
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isEnable.value
          ? Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 45, bottom: 65),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const AddJointApplicantBottomSheetWidget();
                      },
                    );
                  },
                  label: AppTextWidget(
                    text: AppLocalizations.of(context)!.add,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
              pageNumber: 2,
              percentageFirst: 100,
              percentageSecond: 50,
              percentageThird: 0,
              percentageFourth: 0,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.loanRequest,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.toAddJointApplicant,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                ValueListenableBuilder(
                  valueListenable: _isEnable,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Switch(
                      thumbIcon: thumbIcon,
                      value: _isEnable.value,
                      onChanged: (bool value) {
                        setState(() {
                          _isEnable.value = value;
                          //isOn = value;
                        });
                      },
                    );
                  },
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (_isEnable.value && jointApplicantListData.isEmpty)
                        ? SizedBox(
                            child: Center(
                              child: AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .pleaseAddAtleastApplicant,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _isEnable.value
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: jointApplicantListData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: AppColors.greenColor,
                                          value: selectedIndices.contains(
                                              jointApplicantListData[index].id),
                                          onChanged: (bool? value) {
                                            if (selectedIndices.contains(
                                                jointApplicantListData[index]
                                                        .id ??
                                                    0)) {
                                              selectedIndices.remove(
                                                  jointApplicantListData[index]
                                                          .id ??
                                                      0);
                                              setState(() {});
                                            } else {
                                              selectedIndices.add(
                                                  jointApplicantListData[index]
                                                          .id ??
                                                      0);
                                              setState(() {});
                                            }
                                          },
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppTextWidget(
                                              text:
                                                  jointApplicantListData[index]
                                                          .joinApplicantName ??
                                                      '',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              textColor:
                                                  AppColors.textBlackColor,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            AppTextWidget(
                                              text:
                                                  jointApplicantListData[index]
                                                          .relationName ??
                                                      '',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor:
                                                  AppColors.textColorPrimary,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    BlocConsumer<DeleteJointApplicantBloc,
                                        DeleteJointApplicantState>(
                                      builder: (BuildContext context,
                                          DeleteJointApplicantState state) {
                                        return InkWell(
                                          onTap: () {
                                            context
                                                .read<
                                                    DeleteJointApplicantBloc>()
                                                .add(
                                                  DeleteJointApplicant(
                                                    id: jointApplicantListData[
                                                                index]
                                                            .id ??
                                                        0,
                                                  ),
                                                );
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                      listener: (BuildContext context,
                                          DeleteJointApplicantState state) {
                                        if (state
                                            is DeleteJointApplicantSuccess) {
                                          context
                                              .read<GetJointApplicantBloc>()
                                              .add(
                                                GetJointApplicantList(
                                                  body: const {"search": ""},
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.cancell,
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
                      BlocConsumer<ApplyLoanRequestBloc, ApplyLoanRequestState>(
                    builder:
                        (BuildContext context, ApplyLoanRequestState state) {
                      return InkWell(
                        onTap: () {
                          final loanPurposeCubit =
                              context.read<LoanPurposeCubit>();
                          final bodyRequest = {
                            "costOfCultivation":
                                '${loanPurposeCubit.state.firstAmount}'
                                    .replaceAll(",", ''),
                            "postHarvest":
                                '${loanPurposeCubit.state.secondAmount}'
                                    .replaceAll(",", ''),
                            "farmMaintenance":
                                '${loanPurposeCubit.state.thirdAmount}'
                                    .replaceAll(",", ''),
                            "addJointApplicant": _isEnable.value,
                            "listOfJointApplicantId":
                                _isEnable.value ? selectedIndices : null,
                            "hypothecationOfTheCrop": "Yes",
                            "agriculturalLand": true,
                            "otherSecurity": true,
                            "otherSecuriyDescription": "fjhfy fgyy",
                            "masterId": loanPurposeCubit.state.masterId
                          };
                          context
                              .read<ApplyLoanRequestBloc>()
                              .add(ApplyLoanRequest(requestBody: bodyRequest));
                        },
                        child: CommonButton(
                          buttonName: AppLocalizations.of(context)!.next,
                        ),
                      );
                    },
                    listener: (BuildContext context,
                        ApplyLoanRequestState state) async {
                      if (state is ApplyLoanRequestSuccess) {
                        if (kDebugMode) {
                          print(selectedIndices);
                        }
                        Navigator.pushNamed(
                            context, IncompleteLandDetailScreen.routeName);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
