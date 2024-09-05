import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/model/other_details_cubit_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../loan_apply/screen/borrower_details/widgets/add_borrower_bottomsheet_widget.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_guarantors_details/screens/incomplete_guarantors_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteBorrowerDetailsScreen extends StatefulWidget {
  static String routeName = 'incomplete-borrower-detail-screen';

  const IncompleteBorrowerDetailsScreen({super.key});

  @override
  State<IncompleteBorrowerDetailsScreen> createState() =>
      _IncompleteBorrowerDetailsScreenState();
}

class _IncompleteBorrowerDetailsScreenState
    extends State<IncompleteBorrowerDetailsScreen> {
  final ValueNotifier<bool> isEnable = ValueNotifier<bool>(false);
  var otherDetailsCubit = OtherDetailsCubit();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  List<UserLoanLiabilitiesList> borrowerList = [];

  @override
  void initState() {
    final lovsTypeData = ['ACCOUNTSTATUS', 'SECURITYOFFERED'];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherDetailsCubit, OtherDetailsState>(
      builder: (BuildContext context, OtherDetailsState state) {
        borrowerList = state.userLoanLiabilityList;
        Set<UserLoanLiabilitiesList> borrowerSet = borrowerList.toSet();
        List<UserLoanLiabilitiesList> userLoanLiabilityList =
            borrowerSet.toList();

        if (userLoanLiabilityList.isNotEmpty) {
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
                                  return const AddBorrowerBottomSheetWidget();
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
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LoanApplyHeaderWidget(
                            headerName:
                                AppLocalizations.of(context)!.cropLoanForm,
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
                                  text:
                                      AppLocalizations.of(context)!.doYouWantToAddDetailsOfExistingLoanAccountAsBorrower,
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
                          (isEnable.value && userLoanLiabilityList.isEmpty)
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
                          isEnable.value && userLoanLiabilityList.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: userLoanLiabilityList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        final borrower =
                                            userLoanLiabilityList[index];
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
                                                    text:
                                                        borrower.bankName ?? '',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  AppTextWidget(
                                                    text: borrower.branchName ??
                                                        '',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  AppTextWidget(
                                                    text:
                                                        borrower.loanPurpose ??
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
                                                      .deleteBorrowerById(
                                                          borrower.listId);
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
                            child: userLoanLiabilityList.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        IncompleteGuarantorsDetailsScreen
                                            .routeName,
                                      );
                                    },
                                    child:  CommonButton(
                                      buttonName: AppLocalizations.of(context)!.next,
                                    ),
                                  )
                                :  CommonButton(
                                    buttonName: AppLocalizations.of(context)!.next,
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
          },
        );
      },
    );
  }
}
