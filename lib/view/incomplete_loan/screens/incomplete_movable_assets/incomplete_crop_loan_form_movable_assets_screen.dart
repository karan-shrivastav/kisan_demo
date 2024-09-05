import 'package:ekisan_credit/bloc/loan_guarantor/loan_guarantor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/apply_laon/other_detail_cubit/other_details_cubit.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../Utils/shared_preference_helper.dart';
import '../../../../bloc/loan_guarantor/loan_guarantor_bloc.dart';
import '../../../../bloc/loan_guarantor/loan_guarantor_event.dart';
import '../../../../cubit/model/other_details_cubit_model.dart';
import '../../../../model/response/loan_guarantors_response_model.dart';
import '../../../loan_apply/screen/movable_assets/widget/add_particulars_of_movable_assets_widget.dart';
import '../../../loan_apply/widget/loan_apply_header.dart';
import '../incomplete_borrower_details/screens/imcomplete_borrower_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteCropLoanFormMovableAssetsScreen extends StatefulWidget {
  static const routeName = 'incomplete-crop-loan-form-movable-assets';

  const IncompleteCropLoanFormMovableAssetsScreen({super.key});

  @override
  State<IncompleteCropLoanFormMovableAssetsScreen> createState() =>
      _IncompleteCropLoanFormMovableAssetsScreenState();
}

class _IncompleteCropLoanFormMovableAssetsScreenState
    extends State<IncompleteCropLoanFormMovableAssetsScreen> {
  var borrowerBloc = LoanGuarantorBloc();
  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  List<UserLoanLiabilityLiabilitiesMapper> borrowerList = [];
  List<LiablitiyGuarantorMapper> liablitiyGuarantorList = [];
  List<LoanGuarantorMapper> loanGuarantorList = [];
  var uuid = const Uuid();

  @override
  void initState() {
    final otherDetailsCubit = context.read<OtherDetailsCubit>();

    otherDetailsCubit.clearBorrowerList();
    otherDetailsCubit.clearLoanLiabilityGuarantorList();
    otherDetailsCubit.clearGuarantorList();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      borrowerBloc.add(GetLoanGuarantorDetails(
        loanId: await getIncompleteLoanId() ?? '',
      ));
    });

    borrowerBloc.stream.listen((state) {
      if (state is LoanGuarantorSuccess) {
        borrowerList = state.loanGuarantorResponseModel.data
                ?.userLoanLiabilityLiabilitiesMappers ??
            [];
        liablitiyGuarantorList =
            state.loanGuarantorResponseModel.data?.liablitiyGuarantorMappers ??
                [];
        loanGuarantorList =
            state.loanGuarantorResponseModel.data?.loanGuarantorMappers ?? [];

        for (int i = 0; i < borrowerList.length; i++) {
          otherDetailsCubit.addBorrowerList(
            UserLoanLiabilitiesList(
              id: borrowerList[i].id,
              farmerId: '${borrowerList[i].farmerId ?? ''}',
              accountStatusId: '${borrowerList[i].accountStatusId}',
              securityOfferedId: '${borrowerList[i].securityOfferedId}',
              bankName: borrowerList[i].bankName,
              branchName: borrowerList[i].branchName,
              loanPurpose: borrowerList[i].loanPurpose,
              outstanding: '${borrowerList[i].outstanding}',
              bankType: borrowerList[i].bankType,
              listId: uuid.v4(),
            ),
          );
        }

        for (int i = 0; i < loanGuarantorList.length; i++) {
          otherDetailsCubit.addGuarantorList(LoanGuarantorsList(
            id: loanGuarantorList[i].id,
            occupationDataId: '${loanGuarantorList[i].occupationDataId}',
            guarantorName: loanGuarantorList[i].guarantorName,
            age: '${loanGuarantorList[i].age}',
            address: loanGuarantorList[i].address,
            mobileNumber: loanGuarantorList[i].mobileNumber,
            netWorth: '${loanGuarantorList[i].netWorth}',
            listId: uuid.v4(),
          ));
        }

        for (int i = 0; i < liablitiyGuarantorList.length; i++) {
          otherDetailsCubit.addLoanLiabilityGuarantorList(
            LoanLiabilityGuarantor(
              id: liablitiyGuarantorList[i].id,
              guarantorName: liablitiyGuarantorList[i].guarantorName,
              bankMasterId: '${liablitiyGuarantorList[i].bankMasterId}',
              bankName: liablitiyGuarantorList[i].bankName,
              accountStatusName: liablitiyGuarantorList[i].accountStateName,
              accountStatus: '${liablitiyGuarantorList[i].accountStatusId}',
              loanAmount: '${liablitiyGuarantorList[i].loanAmount}',
              outstanding: '${liablitiyGuarantorList[i].outstanding}',
              listId: uuid.v4(),
            ),
          );
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final otherDetailsCubit = context.watch<OtherDetailsCubit>();
    final movableAssets = otherDetailsCubit.state.loanAssetsList
        .where((element) => element.assetType == "Movable")
        .toList();
    Set<LoanAsset> dataSet = movableAssets.toSet();
    List<LoanAsset> filteredList = dataSet.toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             LoanApplyHeaderWidget(
               percentageFirst: 100,
              percentageSecond: 100,
              headerName: AppLocalizations.of(context)!.cropLoanForm,
            ),
             AppTextWidget(
              text:AppLocalizations.of(context)!.otherDetails,
              fontSize: AppTextSize.contentSize22,
              fontWeight: FontWeight.w400,
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Expanded(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.particularsOfMovableOwned,
                          fontSize: AppTextSize.contentSize22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: FloatingActionButton(
                          // isExtended: true,
                          backgroundColor: AppColors.greenColor,
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const AddParticularsOfMovableWidget();
                                });
                          },
                          // isExtended: true,
                          child: const Icon(
                            Icons.add,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (otherDetailsCubit.state.loanAssetsList
                      .where((element) => element.assetType == "Movable")
                      .isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final loanAsset = filteredList[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: AppTextWidget(
                                    text: loanAsset.assetName ?? '',
                                    fontSize: AppTextSize.contentSize16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  subtitle: AppTextWidget(
                                    text: loanAsset.presentMarketValue ?? '',
                                    fontSize: AppTextSize.contentSize14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  leading:
                                      const Icon(Icons.currency_rupee_outlined),
                                  trailing: InkWell(
                                    onTap: () {
                                      context
                                          .read<OtherDetailsCubit>()
                                          .deleteLoanAssetById(
                                              loanAsset.listId);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title:  AppTextWidget(
                                text: AppLocalizations.of(context)!.totalValue,
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: AppTextWidget(
                                text: context
                                    .read<OtherDetailsCubit>()
                                    .getTotalPresentMarketValueOfMovable()
                                    .toString(),
                                fontSize: AppTextSize.contentSize11,
                                fontWeight: FontWeight.w400,
                              ),
                              leading:
                                  const Icon(Icons.currency_rupee_outlined),
                            )
                          ],
                        ),
                      ),
                    )
                  else
                     Expanded(
                      child: Center(
                          child: AppTextWidget(text:  AppLocalizations.of(context)!.pleaseAddAtleast,)),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  CommonButton(
                      buttonName:  AppLocalizations.of(context)!.cancell,
                      borderColor: AppColors.greenColor,
                      buttonColor: Colors.transparent,
                      buttonTextColor: AppColors.greenColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                if (otherDetailsCubit.state.loanAssetsList
                    .where((element) => element.assetType == "Movable")
                    .isNotEmpty)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, IncompleteBorrowerDetailsScreen.routeName);
                      },
                      child:  CommonButton(
                        buttonName: AppLocalizations.of(context)!.next,
                      ),
                    ),
                  )
                else
                   Expanded(
                    child: CommonButton(
                      buttonName:  AppLocalizations.of(context)!.next,
                      buttonColor: AppColors.grayColor,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
