import 'package:ekisan_credit/bloc/selected_land_details/selected_land_details_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/loan_purpose/loan_purpose_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/delete_land/delete_land_bloc.dart';
import '../../../../../bloc/delete_land/delete_land_data_event.dart';
import '../../../../../bloc/delete_land/delete_land_data_state.dart';
import '../../../../../bloc/get_land_details/get_land_details_bloc.dart';
import '../../../../../bloc/get_land_details/get_land_details_event.dart';
import '../../../../../bloc/get_land_details/get_land_details_state.dart';
import '../../../../../bloc/save_land_details/save_land_details_bloc.dart';
import '../../../../../bloc/save_land_details/save_land_details_event.dart';
import '../../../../../bloc/save_land_details/save_land_state.dart';
import '../../../../../bloc/selected_land_details/selected_land_details_bloc.dart';
import '../../../../../bloc/selected_land_details/selected_land_details_event.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../cubit/incomplete_loan/incomplete_loan_cubit.dart';
import '../../../../../model/response/land_details_response_model.dart';
import '../../../../../model/response/selected_land_details_response_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../loan_apply/screen/land_details/widget/crop_laon_form_add_land_widget.dart';
import '../../../../loan_apply/widget/loan_apply_header.dart';
import '../../incomplete_other_details/screens/incomplete_crop_loan_form_other_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncompleteLandDetailScreen extends StatefulWidget {
  static const routeName = "incomplete-land-details";

  const IncompleteLandDetailScreen({super.key});

  @override
  State<IncompleteLandDetailScreen> createState() =>
      _IncompleteLandDetailScreenState();
}

class _IncompleteLandDetailScreenState
    extends State<IncompleteLandDetailScreen> {
  @override
  void didChangeDependencies() {
    context.read<GetLandDataBloc>().add(GetLandListData(landRequest: const {}));
    super.didChangeDependencies();
  }

  List selectedLandId = [];
  List<LandDataContent> landListData = [];
  List<DetailDto> selectedLandList = [];
  var getLandDataBloc = GetLandDataBloc();
  var selectedLandDataBloc = SelectedLandBloc();

  final TextEditingController _totalMarketValue = TextEditingController();

  final ValueNotifier<bool> _isFilledMarketValue = ValueNotifier<bool>(false);

  Future<String?> getIncompleteLoanId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('incompleteLoanId');
  }

  @override
  void initState() {
    final incompleteCubit = context.read<IncompleteLoanInfoCubit>();
    _totalMarketValue.text =
        "${incompleteCubit.state.presentMarketValue ?? ''}";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLandDataBloc.add(GetLandListData(
        landRequest: const {"search": ""},
      ));
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      selectedLandDataBloc.add(
          GetSelectedLandDetails(loanId: await getIncompleteLoanId() ?? ''));
    });

    getLandDataBloc.stream.listen((state) {
      if (state is GetLandDataSuccess) {
        landListData = state.getLandResponseModel.data?.content ?? [];
        if (mounted) {
          setState(() {});
        }
      }
    });

    selectedLandDataBloc.stream.listen((state) {
      if (state is SelectedLandDetailsSuccess) {
        selectedLandList =
            state.selectedLandDetailsResponseModel.data?.detailDtos ?? [];
        for (int index = 0; index < landListData.length; index++) {
          for (int i = 0; i < selectedLandList.length; i++) {
            if (selectedLandList[i].id == landListData[index].id) {
              selectedLandId.add(landListData[i].id ?? 0);
            }
          }
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            LoanApplyHeaderWidget(
              headerName: AppLocalizations.of(context)!.cropLoanForm,
              percentageFirst: 50,
              pageNumber: 2,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.landDetails,
              fontSize: AppTextSize.contentSize24,
              fontWeight: FontWeight.w400,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: AppLocalizations.of(context)!.landDetails,
                        fontSize: AppTextSize.contentSize22,
                        fontWeight: FontWeight.w400,
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
                                  return const CropLandFromAddLandWidget();
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: AppTextWidget(
                            text: AppLocalizations.of(context)!.selectAll,
                          ),
                          leading: Checkbox(
                            checkColor: Colors.white,
                            value: true,
                            onChanged: (bool? value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            itemCount: landListData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: AppTextWidget(
                                    text: landListData[index].surveyNo ?? '',
                                  ),
                                  subtitle: AppTextWidget(
                                    text: landListData[index].villageName ?? '',
                                  ),
                                  leading: Checkbox(
                                    checkColor: Colors.white,
                                    value: selectedLandId
                                        .contains(landListData[index].id),
                                    onChanged: (bool? value) {
                                      if (selectedLandId
                                          .contains(landListData[index].id)) {
                                        selectedLandId
                                            .remove(landListData[index].id);
                                        setState(() {});
                                      } else {
                                        selectedLandId
                                            .add(landListData[index].id);
                                        setState(() {});
                                      }
                                    },
                                  ),
                                  trailing: BlocConsumer<DeleteLandDataBloc,
                                      DeleteLandDataState>(
                                    builder: (BuildContext context,
                                        DeleteLandDataState deleteState) {
                                      return InkWell(
                                        onTap: () {
                                          context
                                              .read<DeleteLandDataBloc>()
                                              .add(DeleteLandData(
                                                  id: landListData[index].id ??
                                                      0));
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          size: 24,
                                          color: Colors.red,
                                        ),
                                      );
                                    },
                                    listener: (BuildContext context,
                                        DeleteLandDataState state) {
                                      if (state is DeleteLandDataLoading) {
                                        showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            scrollable: true,
                                            content: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                ),
                                                AppTextWidget(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .deleting,
                                                  fontSize:
                                                      AppTextSize.contentSize20,
                                                  fontWeight: FontWeight.w500,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (state
                                          is DeleteLandDataSuccess) {
                                        context.read<GetLandDataBloc>().add(
                                            GetLandListData(
                                                landRequest: const {}));
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  // trailing:const Icon(
                                  //   Icons.delete,
                                  //   color: Colors.red,
                                  // ),
                                ),
                              );
                            },
                          ),
                          //     }
                          //     return const SizedBox.shrink();
                          //   },
                          //   listener: (BuildContext context,
                          //       GetLandDataState state) {},
                          // ),
                          Row(
                            children: [
                              AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .totalLandHolding,
                                fontSize: AppTextSize.contentSize22,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xFF43483F),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .totalLandAreaInAcre,
                                fontSize: AppTextSize.contentSize16,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xFF191D17),
                              ),
                              subtitle: BlocBuilder<GetLandDataBloc,
                                  GetLandDataState>(
                                builder: (BuildContext context,
                                    GetLandDataState state) {
                                  if (state is GetLandDataSuccess) {
                                    double totalIrrigatedLand = 0.0;
                                    if (state.getLandResponseModel.data
                                                ?.content !=
                                            null &&
                                        state.getLandResponseModel.data
                                                ?.content !=
                                            []) {
                                      // Iterate through each item in the content list
                                      for (var contentItem in state
                                              .getLandResponseModel
                                              .data
                                              ?.content ??
                                          []) {
                                        totalIrrigatedLand += double.tryParse(
                                                contentItem.irrigatedLand
                                                    .toString()) ??
                                            0.0;
                                        // Create a Text widget for each content ite
                                      }
                                      context
                                          .read<LoanPurposeCubit>()
                                          .updateModel(
                                              totalLandArea: totalIrrigatedLand
                                                  .toStringAsFixed(2));
                                      // Return a Column containing all the Text widgets
                                      return AppTextWidget(
                                        text: totalIrrigatedLand
                                            .toStringAsFixed(2),
                                        fontSize: AppTextSize.contentSize14,
                                        fontWeight: FontWeight.w400,
                                        textColor: const Color(0xFF191D17),
                                      );
                                    } else {
                                      // Return a message or widget indicating that the content is empty
                                      return Text(AppLocalizations.of(context)!
                                          .noDataAvailable);
                                    }
                                  }
                                  // Return an empty SizedBox if the state is not GetLandDataSuccess
                                  return const SizedBox();
                                },
                              ),
                              leading: const Icon(Icons.landscape_outlined),
                            ),
                          ),
                          Row(
                            children: [
                              AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .totalMarketValue,
                                fontSize: AppTextSize.contentSize14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CommonTextField(
                            labelText: AppLocalizations.of(context)!.amount,
                            prefixIcon: Icons.currency_rupee,
                            showPrefixIcon: true,
                            length: 10,
                            keyboardType: TextInputType.number,
                            controller: _totalMarketValue,
                            onChange: (value) {
                              if (value.isNotEmpty) {
                                _isFilledMarketValue.value = true;
                              } else {
                                _isFilledMarketValue.value = false;
                              }
                            },
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.cancell,
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
                    child: BlocConsumer<SaveLandDetailsNewBloc,
                        SaveLandDetailsNewState>(
                      builder: (BuildContext context,
                          SaveLandDetailsNewState state) {
                        return ValueListenableBuilder(
                          valueListenable: _isFilledMarketValue,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return value ||
                                    selectedLandId.isNotEmpty ||
                                    _totalMarketValue.text.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      final loanPurposeInfoCubit =
                                          context.read<LoanPurposeCubit>();

                                      final requestBody = {
                                        "id":
                                            loanPurposeInfoCubit.state.masterId,
                                        "listofLandDetailsId": selectedLandId,
                                        "detailsRequestPayload": {
                                          "totalLandAreaUnitId": 410,
                                          "totalLandArea": loanPurposeInfoCubit
                                              .state.totalLandArea,
                                          "totalLandAreaAcre":
                                              loanPurposeInfoCubit
                                                  .state.totalLandArea,
                                          "presentMarketValue":
                                              _totalMarketValue.text,
                                        },
                                        "masterId":
                                            loanPurposeInfoCubit.state.masterId
                                      };

                                      if (kDebugMode) {
                                        print(requestBody);
                                      }
                                      context
                                          .read<SaveLandDetailsNewBloc>()
                                          .add(SaveLandDetailsNew(
                                              requestBody: requestBody));
                                    },
                                    child: CommonButton(
                                      buttonName:
                                          AppLocalizations.of(context)!.next,
                                    ),
                                  )
                                : CommonButton(
                                    buttonName:
                                        AppLocalizations.of(context)!.next,
                                    buttonColor: AppColors.grayColor,
                                  );
                          },
                        );
                      },
                      listener: (BuildContext context,
                          SaveLandDetailsNewState state) {
                        if (state is SaveLandDetailsNewStateLoading) {
                          showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              scrollable: true,
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  AppTextWidget(
                                    text: AppLocalizations.of(context)!.saving,
                                    fontSize: AppTextSize.contentSize20,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                        }
                        if (state is SaveLandDetailsNewStateSuccess) {
                          Navigator.pushNamed(
                              context,
                              IncompleteCropLoanFormOtherDetailsScreen
                                  .routeName);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
