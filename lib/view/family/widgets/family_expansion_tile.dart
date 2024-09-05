import 'package:ekisan_credit/bloc/delete_family/delete_family_event.dart';
import 'package:ekisan_credit/common_widget/confirmation_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/delete_family/delete_family_bloc.dart';
import '../../../bloc/delete_family/delete_family_state.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyExpensionTile extends StatefulWidget {
  final int? id;
  final String? name;
  final bool isView;
  final String? age;
  final String? gender;
  final String? relation;
  final String? occupation;
  final String? annualIncome;
  final Function? editButtonFunction;

  const FamilyExpensionTile({
    super.key,
    this.id,
    this.name,
    this.isView = true,
    this.annualIncome,
    this.age,
    this.gender,
    this.occupation,
    this.relation,
    this.editButtonFunction,
  });

  @override
  State<FamilyExpensionTile> createState() => _FamilyExpensionTileState();
}

class _FamilyExpensionTileState extends State<FamilyExpensionTile> {
  bool _isTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.expansionTileColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.transparent),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, splashColor: Colors.transparent),
        child: ExpansionTile(
          title: AppTextWidget(
            text: widget.name ?? '',
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          trailing: Icon(
            _isTileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          ),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.isView) ...[
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                widget.editButtonFunction!();
                              },
                              child: CommonButton(
                                buttonWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 3.5,
                                    ),
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!.edit,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    )
                                  ],
                                ),
                                buttonColor: AppColors.whiteColor,
                                borderColor: AppColors.secondOutLineColor,
                                buttonTextColor: AppColors.secondOutLineColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: BlocConsumer<DeleteFamilyBloc,
                                DeleteFamilyState>(
                              builder: (BuildContext context,
                                  DeleteFamilyState state) {
                                return InkWell(
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ConfirmationPopup(
                                          function: () {
                                            context
                                                .read<DeleteFamilyBloc>()
                                                .add(DeleteFamilyInfoDetails(
                                                    id: widget.id ?? 0));
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: CommonButton(
                                    buttonWidget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.delete,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 3.5,
                                        ),
                                        AppTextWidget(
                                          text: AppLocalizations.of(context)!
                                              .delete,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        )
                                      ],
                                    ),
                                    buttonColor: AppColors.redBackgroundColor,
                                    // buttonName: 'Save',
                                  ),
                                );
                              },
                              listener: (BuildContext context, state) {
                                if (state is DeleteFamilySuccess) {
                                  context
                                      .read<GetFarmerFamilyDetailBloc>()
                                      .add(GetFarmerFamilyDetails());
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text: AppLocalizations.of(context)!.name,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.name ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text: AppLocalizations.of(context)!.ageProfile,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.age ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text:
                                    AppLocalizations.of(context)!.genderProfile,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.gender ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .relationWithApplicantProfile,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.relation ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text: AppLocalizations.of(context)!.occupation,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.occupation ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .annualIncomeProfile,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                              )),
                              const Spacer(),
                              Expanded(
                                child: AppTextWidget(
                                  text: widget.annualIncome ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          onExpansionChanged: (bool val) {
            setState(() {
              _isTileExpanded = val;
            });
          },
        ),
      ),
    );
  }
}
