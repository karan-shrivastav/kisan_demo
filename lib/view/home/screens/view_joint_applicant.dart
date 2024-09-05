import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_bloc.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_event.dart';
import '../../../bloc/delete_joint_applicant/delete_joint_applicant_state.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import 'edit_joint_applicant_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewJointApplicant extends StatelessWidget {
  static String routeName = "view-joint-applicant-screen";
  final int? id;
  final String? name;
  final String? relation;
  final String? dateOfBirth;
  final String? gender;
  final String? idProofNumber;
  final String? idProofName;
  final int? genderId;
  final int? proofId;
  final int? relationId;

  const ViewJointApplicant({
    super.key,
    this.name,
    this.relation,
    this.dateOfBirth,
    this.gender,
    this.idProofNumber,
    this.idProofName,
    this.genderId,
    this.id,
    this.proofId,
    this.relationId,
  });

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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditJointApplicantScreen(
                              id: id,
                              userName: name ?? '',
                              relation: relation ?? '',
                              dateOfBirth: dateOfBirth ?? '',
                              gender: gender ?? '',
                              idProofNumber: idProofNumber ?? '',
                              idProofType: idProofName ?? '',
                              genderId: genderId ?? 0,
                              proofId: proofId,
                              relationId: relationId,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 24,
                        color: AppColors.textBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocConsumer<DeleteJointApplicantBloc,
                        DeleteJointApplicantState>(
                      builder: (BuildContext context,
                          DeleteJointApplicantState state) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<DeleteJointApplicantBloc>()
                                .add(DeleteJointApplicant(id: id ?? 0));
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
                        if (state is DeleteJointApplicantSuccess) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: AppColors.greenColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 44,
            ),
            AppTextWidget(
              text: name ?? '',
              fontSize: 28,
              fontWeight: FontWeight.w400,
              textColor: AppColors.textBlackColor,
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.dateOfBirth,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textBlackColor,
                    ),
                  ],
                ),
                AppTextWidget(
                  text: dateOfBirth ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.textColorPrimary,
                ),
                const SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.gender,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textBlackColor,
                    ),
                    AppTextWidget(
                      text: gender ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textColorPrimary,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.idProofName,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textBlackColor,
                    ),
                    AppTextWidget(
                      text: idProofNumber ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textColorPrimary,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.relationShip,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textBlackColor,
                    ),
                    AppTextWidget(
                      text: relation ?? '',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.textColorPrimary,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
