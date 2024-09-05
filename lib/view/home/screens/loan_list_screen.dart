import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/profile/screens/profile_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../Utils/shared_preference_helper.dart';
import '../../../bloc/laon_list/laon_list_bloc.dart';
import '../../../bloc/laon_list/loan_list_event.dart';
import '../../../bloc/loan_basic/get_loan_basic_bloc.dart';
import '../../../bloc/loan_basic/get_loan_basic_event.dart';
import '../../incomplete_loan/screens/incomplete_bank_details/screens/incomplete_crop_loan_form_bank_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoanListScreen extends StatefulWidget {
  static const routeName = "loan-list";
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<LoanListBloc>().add(GetLoanList(loanListRequest: {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getLoanListBloc =
        context.watch<LoanListBloc>().getLoanListResponseModel.data;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              children: [
                 Expanded(
                  child: AppTextWidget(
                    text: AppLocalizations.of(context)!.loanList,
                    fontSize: AppTextSize.contentSize22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.greenColor,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    GestureDetector(
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
                        color: AppColors.greenColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (getLoanListBloc?.content != null)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: getLoanListBloc?.content?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      // Specify the directionality of the slide actions
                      startActionPane: ActionPane(
                        // Choose a motion for the action pane
                        motion: const DrawerMotion(),
                        // Add children that are slide actions
                        children: [
                          getLoanListBloc?.content?[index].status ==
                                  'Incomplete'
                              ? SlidableAction(
                                  onPressed: (BuildContext context) {},
                                  backgroundColor: AppColors.redBackgroundColor,
                                  icon: Icons.delete,
                                )
                              : SlidableAction(
                                  onPressed: (BuildContext context) {},
                                  backgroundColor:
                                      AppColors.backGroundGreenColor,
                                  icon: Icons.file_download_outlined,
                                ),
                        ],
                      ),
                      // The child of the Slidable is your ListTile
                      child: InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print(
                              'ID :${getLoanListBloc?.content?[index].loanMasterId ?? ''}');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: getLoanListBloc?.content?[index].status ==
                                      'Incomplete'
                                  ? AppColors.yellowBackGroundColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.ac_unit),
                            title: AppTextWidget(
                              text: getLoanListBloc
                                      ?.content?[index].applicationId ??
                                  '',
                              fontSize: AppTextSize.contentSize16,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: AppTextWidget(
                              text:
                                  getLoanListBloc?.content?[index].status ?? '',
                              fontSize: AppTextSize.contentSize14,
                              fontWeight: FontWeight.w400,
                            ),
                            trailing: getLoanListBloc?.content?[index].status ==
                                    'Incomplete'
                                ? Column(
                                    children: [
                                      AppTextWidget(
                                        text:
                                            " ₹ ${getLoanListBloc?.content?[index].amount ?? ''}",
                                        fontSize: AppTextSize.contentSize14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.read<GetLoanBasicBloc>().add(
                                              GetBasicLoanResponse(
                                                  loanId:
                                                      '${getLoanListBloc?.content?[index].loanMasterId ?? 0}'));
                                          AppSharedPreferenceHelper()
                                              .saveCustomerData(
                                                  "incompleteLoanId",
                                                  '${getLoanListBloc?.content?[index].loanMasterId ?? 0}');
                                          Navigator.pushNamed(
                                              context,
                                              IncompleteCropLoanFormBankDetail
                                                  .routeName);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      AppColors.outLineColor),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child:  AppTextWidget(
                                            text: AppLocalizations.of(context)!.continueText,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : AppTextWidget(
                                    text:
                                        " ₹ ${getLoanListBloc?.content?[index].amount ?? ''}",
                                    fontSize: AppTextSize.contentSize14,
                                    fontWeight: FontWeight.w400,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
