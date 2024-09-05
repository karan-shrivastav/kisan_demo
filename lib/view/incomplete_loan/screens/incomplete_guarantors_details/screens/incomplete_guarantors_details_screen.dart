import 'package:ekisan_credit/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../loan_apply/screen/guarantor_details/widgets/add_guarantors_bottomsheet.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_liabilities_guarantor/screens/incomplete_liabilities_guarantor_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteGuarantorsDetailsScreen extends StatefulWidget {
  static String routeName = 'incomplete-guarantors-detail-screen';

  const IncompleteGuarantorsDetailsScreen({super.key});

  @override
  State<IncompleteGuarantorsDetailsScreen> createState() =>
      _IncompleteGuarantorsDetailsScreenState();
}

class _IncompleteGuarantorsDetailsScreenState
    extends State<IncompleteGuarantorsDetailsScreen> {
  final ValueNotifier<bool> isEnable = ValueNotifier<bool>(false);

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
        builder: (BuildContext context, OtherDetailsState state) {
      if (state.loanGuarantorList.isNotEmpty) {
        isEnable.value = true;
      }
      return ValueListenableBuilder(
          valueListenable: isEnable,
          builder: (BuildContext context, bool value, child) {
            return Scaffold(
              floatingActionButton: isEnable.value
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32, bottom: 70),
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const AddGuaratorBottomSheetWidget();
                                });
                          },
                          label:  AppTextWidget(
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           LoanApplyHeaderWidget(
                            headerName: AppLocalizations.of(context)!.cropLoanForm,
                            pageNumber: 4,
                            percentageFirst: 100,
                            percentageSecond: 100,
                            percentageThird: 100,
                            percentageFourth: 50,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                           AppTextWidget(
                            text: AppLocalizations.of(context)!.otherDetails,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Expanded(
                                child: AppTextWidget(
                                  text: AppLocalizations.of(context)!.guarantorsOffered,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Switch(
                                thumbIcon: thumbIcon,
                                value: isEnable.value,
                                onChanged: (bool value) {
                                  isEnable.value = value;
                                  print(isEnable);
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          (isEnable.value && state.loanGuarantorList.isEmpty)
                              ?  Expanded(
                                  child: Center(
                                    child: AppTextWidget(
                                      text: AppLocalizations.of(context)!.pleaseAddAtleast,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          isEnable.value && state.loanGuarantorList.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: state.loanGuarantorList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        final guarantor =
                                            state.loanGuarantorList[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppTextWidget(
                                                    text: guarantor
                                                            .mobileNumber ??
                                                        '',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: guarantor
                                                            .guarantorName ??
                                                        '',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  AppTextWidget(
                                                    text: guarantor.netWorth ??
                                                        '',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  context
                                                      .read<OtherDetailsCubit>()
                                                      .deleteGuarantorById(
                                                          guarantor.listId);
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: AppColors
                                                      .deleteButtonColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:  CommonButton(
                              buttonName: AppLocalizations.of(context)!.cancell,
                              buttonColor: Colors.transparent,
                              borderColor: AppColors.secondOutLineColor,
                              buttonTextColor:
                                  AppColors.transparentButtonTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: state.loanGuarantorList.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          IncompleteLiabilitiesGuarantorScreen
                                              .routeName);
                                    },
                                    child:  CommonButton(
                                      buttonName: AppLocalizations.of(context)!.next,
                                    ),
                                  )
                                :  CommonButton(
                                    buttonName:AppLocalizations.of(context)!.next,
                                    buttonColor: AppColors.grayColor,
                                  )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
