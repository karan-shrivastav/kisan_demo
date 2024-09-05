import 'package:ekisan_credit/bloc/apply_loan_request/apply_loan_request_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/apply_loan_request/apply_laon_request_event.dart';
import '../../../bloc/apply_loan_request/apply_loan_request_bloc.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_bloc.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_event.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_state.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../cubit/loan_purpose/loan_purpose_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../loan_apply/screen/land_details/screen/land_detail_screen.dart';
import '../../loan_apply/widget/loan_apply_header.dart';
import 'widgets/add_joint_applicant_bottomsheet_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanApplicant extends StatefulWidget {
  static const routeName = 'loan-applicant';

  const LoanApplicant({super.key});

  @override
  State<LoanApplicant> createState() => _LoanApplicantState();
}

class _LoanApplicantState extends State<LoanApplicant> {
  TextEditingController dateController = TextEditingController();
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isEnable = ValueNotifier<bool>(false);
  bool isOn = false;

  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    _dateOfBirthString.value = formattedDate;

    return formattedDate;
  }

  List<int> selectedIndices = [];

  @override
  void initState() {
    final getJointApplicantListBloc = context.read<GetJointApplicantBloc>();
    super.initState();

    getJointApplicantListBloc
        .add(GetJointApplicantList(body: const {"search": ""}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemCount = getJointApplicantListBloc
              .getJointApplicantResponseModel.data?.content?.length ??
          0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final getJointApplicantListBloc = context.watch<GetJointApplicantBloc>();

    return Scaffold(
      floatingActionButton: isOn
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
                      value: _isEnable.value,
                      onChanged: (bool value) {
                        setState(() {
                          _isEnable.value = value;
                          isOn = value;
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
                    (_isEnable.value &&
                            getJointApplicantListBloc
                                    .getJointApplicantResponseModel.data !=
                                null)
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
                    (_isEnable.value &&
                            getJointApplicantListBloc
                                    .getJointApplicantResponseModel.data !=
                                null)
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: getJointApplicantListBloc
                                .getJointApplicantResponseModel
                                .data!
                                .content!
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // Toggle the enable state of the clicked item
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          // Use the enable state from the list for the current item
                                          Checkbox(
                                            checkColor: Colors.white,
                                            activeColor: AppColors.greenColor,
                                            value: selectedIndices.contains(
                                                getJointApplicantListBloc
                                                    .getJointApplicantResponseModel
                                                    .data
                                                    ?.content?[index]
                                                    .id),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value != null) {
                                                  if (value) {
                                                    selectedIndices.add(
                                                        getJointApplicantListBloc
                                                                .getJointApplicantResponseModel
                                                                .data
                                                                ?.content?[
                                                                    index]
                                                                .id ??
                                                            0);
                                                  } else {
                                                    selectedIndices.remove(
                                                        getJointApplicantListBloc
                                                                .getJointApplicantResponseModel
                                                                .data
                                                                ?.content?[
                                                                    index]
                                                                .id ??
                                                            0);
                                                  }
                                                }
                                              });
                                            },
                                          ),

                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextWidget(
                                                text: getJointApplicantListBloc
                                                        .getJointApplicantResponseModel
                                                        .data
                                                        ?.content?[index]
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
                                                text: getJointApplicantListBloc
                                                        .getJointApplicantResponseModel
                                                        .data
                                                        ?.content?[index]
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
                                                      id: getJointApplicantListBloc
                                                              .getJointApplicantResponseModel
                                                              .data
                                                              ?.content?[index]
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
                      BlocConsumer<ApplyLoanRequestBloc, ApplyLoanRequestState>(
                    builder:
                        (BuildContext context, ApplyLoanRequestState state) {
                      return InkWell(
                        onTap: () {
                          final loanPurposeCubit =
                              context.read<LoanPurposeCubit>();
                          final bodyRequest = {
                            "costOfCultivation":
                                loanPurposeCubit.state.firstAmount ?? "0",
                            // Default to "0" if null
                            "postHarvest":
                                loanPurposeCubit.state.secondAmount ?? "0",
                            // Default to "0" if null
                            "farmMaintenance":
                                loanPurposeCubit.state.thirdAmount ?? "0",
                            // Default to "0" if null
                            "addJointApplicant": isOn,
                            "listOfJointApplicantId":
                                isOn ? selectedIndices ?? [] : null,
                            // Default to an empty list if null
                            "hypothecationOfTheCrop": "Yes",
                            "agriculturalLand":
                                loanPurposeCubit.state.agriculture ?? false,
                            "otherSecurity":
                                loanPurposeCubit.state.other ?? false,
                            "otherSecuriyDescription":
                                loanPurposeCubit.state.other == true
                                    ? loanPurposeCubit.state.otherDescription
                                    : "",
                            "masterId": loanPurposeCubit.state.masterId ?? "",
                            // Default to an empty string if null
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
                    listener:
                        (BuildContext context, ApplyLoanRequestState state) {
                      if (state is ApplyLoanRequestSuccess) {
                        if (kDebugMode) {
                          print(selectedIndices);
                        }
                        Navigator.pushNamed(
                            context, LandDetailScreen.routeName);
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

class JointApplicantModel {
  String? name;
  String? relation;

  JointApplicantModel({this.name, this.relation});
}
