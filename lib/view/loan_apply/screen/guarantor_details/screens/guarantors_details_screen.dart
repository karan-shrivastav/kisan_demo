import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/view/loan_apply/screen/liabilities_guarantor/screens/liabilities_guarantor_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../widget/loan_apply_header.dart';
import '../widgets/add_guarantors_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuarantorsDetailsScreen extends StatefulWidget {
  static String routeName = 'guarantors-detail-screen';

  const GuarantorsDetailsScreen({super.key});

  @override
  State<GuarantorsDetailsScreen> createState() =>
      _GuarantorsDetailsScreenState();
}

class _GuarantorsDetailsScreenState extends State<GuarantorsDetailsScreen> {
  bool isEnable = false;

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
    return Scaffold(
      floatingActionButton: isEnable
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
        child: BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
          builder: (BuildContext context, OtherDetailsState state) {
            return Column(
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
                              text: AppLocalizations.of(context)!
                                  .guarantorsOffered,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            thumbIcon: thumbIcon,
                            value: isEnable,
                            onChanged: (bool value) {
                              setState(() {
                                isEnable = value;
                                if (kDebugMode) {
                                  print(isEnable);
                                }
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      (isEnable && state.loanGuarantorList.isEmpty)
                          ? Expanded(
                              child: Center(
                                child: AppTextWidget(
                                  text: AppLocalizations.of(context)!
                                      .pleaseAddAtleast,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      isEnable && state.loanGuarantorList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: state.loanGuarantorList.length,
                                  itemBuilder: (BuildContext context, index) {
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
                                                text: guarantor.mobileNumber ??
                                                    '',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              AppTextWidget(
                                                text: guarantor.guarantorName ??
                                                    '',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              AppTextWidget(
                                                text: guarantor.netWorth ?? '',
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
                                              color:
                                                  AppColors.deleteButtonColor,
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
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.cancel,
                        buttonColor: Colors.transparent,
                        borderColor: AppColors.secondOutLineColor,
                        buttonTextColor: AppColors.transparentButtonTextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: state.loanGuarantorList.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      LiabilitiesGuarantorScreen.routeName);
                                },
                                child: CommonButton(
                                  buttonName:
                                      AppLocalizations.of(context)!.next,
                                ),
                              )
                            : CommonButton(
                                buttonName: AppLocalizations.of(context)!.next,
                                buttonColor: AppColors.grayColor,
                              )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
