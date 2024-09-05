import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import '../../profile/screens/profile_bottom_sheet.dart';
import '../screens/view_joint_applicant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JointApplicantWidget extends StatefulWidget {
  const JointApplicantWidget({super.key});

  @override
  State<JointApplicantWidget> createState() => _JointApplicantWidgetState();
}

class _JointApplicantWidgetState extends State<JointApplicantWidget> {
  bool first = false;
  bool isEnable = false;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    final getJointApplicantListBloc = context
        .watch<GetJointApplicantBloc>()
        .getJointApplicantResponseModel
        .data;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 52,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               AppTextWidget(
                text: AppLocalizations.of(context)!.jointApplicant,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                textColor: AppColors.textBlackColor,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 24,
                    color: AppColors.textBlackColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isEnable = !isEnable;
                        first = !first;
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      size: 24,
                      color: isEnable ? Colors.red : AppColors.textBlackColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const ProfileBottomSheet();
                        },
                      );
                    },
                    child: const Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: AppColors.greenColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          if(getJointApplicantListBloc?.content != null)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: getJointApplicantListBloc?.content?.length,
              // itemCount: 50,
              itemBuilder: (context, index) {
                final String dateOfBirth = DateFormat('dd/MM/yyyy').format(
                    getJointApplicantListBloc?.content![index].dateOfBirth ??
                        DateTime(0));
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewJointApplicant(
                            id: getJointApplicantListBloc
                                ?.content?[index].id,
                            name: getJointApplicantListBloc
                                    ?.content?[index].joinApplicantName ??
                                '',
                            relation: getJointApplicantListBloc
                                    ?.content?[index].relationName ??
                                '',
                            dateOfBirth: dateOfBirth ?? '',
                            gender: getJointApplicantListBloc
                                    ?.content?[index].genderName ??
                                '',
                            idProofNumber: getJointApplicantListBloc
                                    ?.content?[index].idNumber ??
                                '',
                            idProofName: getJointApplicantListBloc
                                    ?.content?[index].idProofName ??
                                '',
                            genderId: getJointApplicantListBloc
                                ?.content?[index].genderId,
                            proofId: getJointApplicantListBloc
                                ?.content?[index].idProodId,
                            relationId: getJointApplicantListBloc
                                ?.content?[index].relationId,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            isEnable
                                ? Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: AppColors.greenColor,
                                    value: first,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        first = value!;
                                      });
                                    },
                                  )
                                : const SizedBox.shrink(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                  text: getJointApplicantListBloc
                                          ?.content?[index].joinApplicantName ??
                                      '',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.textBlackColor,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AppTextWidget(
                                  text: getJointApplicantListBloc
                                          ?.content?[index].relationName ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.textColorPrimary,
                                )
                              ],
                            )
                          ],
                        ),
                        AppTextWidget(
                          text: dateOfBirth,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
