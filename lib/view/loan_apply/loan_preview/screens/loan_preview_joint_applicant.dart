import 'package:ekisan_credit/bloc/loan_preview/loan_preview_joint_applicant/loan_preview_joint_applicant_bloc.dart';
import 'package:ekisan_credit/bloc/loan_preview/loan_preview_joint_applicant/loan_preview_joint_applicant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/loan_preview/loan_details_basic/loan_details_preview_bloc.dart';
import '../../../../common_button.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import '../../../../utils/date_formater.dart';
import '../../widget/loan_apply_header.dart';
import 'accept_and_save_first_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanPreviewJointApplicant extends StatefulWidget {
  static const routeName = 'loan-preview-joint-applicant';

  const LoanPreviewJointApplicant({super.key});

  @override
  State<LoanPreviewJointApplicant> createState() =>
      _LoanPreviewJointApplicantState();
}

class _LoanPreviewJointApplicantState extends State<LoanPreviewJointApplicant> {
  late List<bool> _isExpandedJointApplicant;

  @override
  void initState() {
    // TODO: implement initState
    _isExpandedJointApplicant = List<bool>.filled(100, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basicsDetails = context.watch<LoanDetailsNewPreviewBloc>().loanDetailsNewPreviewResponseModel;
    return BlocBuilder<PreviewBasicsDetailsBloc,
        PreviewBasicsDetailsState>(
      builder:
          (BuildContext context, PreviewBasicsDetailsState state) {
        if (state is PreviewBasicsDetailSuccess) {
          return Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.jointApplicant,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: state.basicDetailsNewResponseModel.data!.applicantDtos!.isNotEmpty ? "Yes":"No",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: state.basicDetailsNewResponseModel.data?.applicantDtos?.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {

                  final jointApplicant = state.basicDetailsNewResponseModel.data?.applicantDtos?[index];
                  return Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _isExpandedJointApplicant[index] =
                            !_isExpandedJointApplicant[index];
                          });
                        },
                        child:  Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                              text: jointApplicant?.joinApplicantName ?? '',
                              fontSize: AppTextSize.contentSize16,
                              fontWeight: FontWeight.w400,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                      Visibility(
                          visible: _isExpandedJointApplicant[index],
                          child: Container(
                            color: AppColors.backGroundColor,
                            child:  Column(
                              children: [
                                Divider(
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 32, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.dateOfBirth,
                                        fontSize: AppTextSize
                                            .contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: DateFormatter.formatTimestamp(jointApplicant!.dateOfBirth.toString()),
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize
                                            .contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                /******* Gender ********/
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.gender,
                                        fontSize: AppTextSize
                                            .contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: jointApplicant.genderName ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize
                                            .contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                /******* Relationship  ********/
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.relationShip,
                                        fontSize: AppTextSize
                                            .contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: jointApplicant.relationName ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize
                                            .contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.idProofType,
                                        fontSize: AppTextSize
                                            .contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: jointApplicant.idProodName ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize
                                            .contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!.idProofNumber,
                                        fontSize: AppTextSize
                                            .contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: jointApplicant.idNumber ?? '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize
                                            .contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  text: AppLocalizations.of(context)!.securityOffered,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                            text: AppLocalizations.of(context)!.hypoThecationOfCrop),
                        Spacer(),
                        AppTextWidget(text: state.basicDetailsNewResponseModel.data?.hypothecationOfCrop == 1 ? "Yes" :"No"),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.collateralSecurity,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.agricultural,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.yes,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.collateralSecurity,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            AppTextWidget(
                              text: AppLocalizations.of(context)!.other,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            if(basicsDetails.data != null)
                              AppTextWidget(
                                text:
                                basicsDetails.data?.loanDetailMapper?.otherSecurityDesc ?? '',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                          ],
                        ),
                        AppTextWidget(
                          text: AppLocalizations.of(context)!.yes,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
