import 'package:ekisan_credit/bloc/loan_preview/land_details_preview/land_details_preview_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/loan_preview/land_details_preview/land_details_preview_bloc.dart';
import '../../../../bloc/loan_preview/land_details_preview/land_details_preview_event.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandDetailsPreviewScreen extends StatefulWidget {
  const LandDetailsPreviewScreen({super.key});

  @override
  State<LandDetailsPreviewScreen> createState() =>
      _LandDetailsPreviewScreenState();
}

class _LandDetailsPreviewScreenState extends State<LandDetailsPreviewScreen> {
  late List<bool> _isExpandedLand;

  @override
  void initState() {
    _isExpandedLand = List<bool>.filled(10, false);
    final bodyRequest = {"masterId": "2308"};
    final landPreviewBloc = context.read<LandDetailsNewPreviewBloc>();
    landPreviewBloc.add(GetLandNewDetailsForPreview(bodyRequest: bodyRequest));

    landPreviewBloc.stream.listen((state) {
      if (state is LandDetailsNewPreviewSuccess) {
        if (state
            .landDetailsNewPreviewResponseModel.data!.detailDtos!.isNotEmpty) {
          _isExpandedLand = List<bool>.filled(
              state.landDetailsNewPreviewResponseModel.data!.detailDtos!.length,
              false);
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandDetailsNewPreviewBloc, LandDetailsNewPreviewState>(
      builder: (BuildContext context, LandDetailsNewPreviewState state) {
        if (state is LandDetailsNewPreviewSuccess) {
          final landDetails = state.landDetailsNewPreviewResponseModel.data;
          return Column(
            children: [
              AppTextWidget(
                text: AppLocalizations.of(context)!.landDetails,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  text: AppLocalizations.of(context)!.totalLandHolding,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.areaUnit,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: landDetails?.areaUnit ?? '',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.totalLandArea,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: landDetails?.totalLandArea.toString() ?? '',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.totalLandInAcre,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: landDetails?.totalLandAreaInAcres.toString() ?? '',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                    text: AppLocalizations.of(context)!.presentMarketValue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  AppTextWidget(
                    text: landDetails?.presentMarketValue.toString() ?? '',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  text: AppLocalizations.of(context)!
                      .landDetailsForWhichKccIsRequired,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                itemCount: landDetails!.detailDtos!.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final landDetailsDataList = landDetails.detailDtos?[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _isExpandedLand[index] = !_isExpandedLand[index];
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: landDetailsDataList?.surveyNo ?? '',
                                    fontSize: AppTextSize.contentSize16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  if (landDetailsDataList?.irrigatedLand
                                          .toString() !=
                                      '0.0')
                                    AppTextWidget(
                                      text: landDetailsDataList?.irrigatedLand
                                              .toString() ??
                                          '',
                                      fontSize: AppTextSize.contentSize14,
                                      fontWeight: FontWeight.w400,
                                    )
                                  else
                                    AppTextWidget(
                                      text: landDetailsDataList?.unIrrigatedLand
                                              .toString() ??
                                          '',
                                      fontSize: AppTextSize.contentSize14,
                                      fontWeight: FontWeight.w400,
                                    )
                                ],
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: _isExpandedLand[index],
                          child: Container(
                            color: AppColors.backGroundColor,
                            child: Column(
                              children: [
                                const Divider(
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.state,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: landDetailsDataList?.stateName ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                /******* District ********/
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .district,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            landDetailsDataList?.districtName ??
                                                '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                /******* Relationship  ********/
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .village,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            landDetailsDataList?.villageName ??
                                                '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .ownerShip,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: landDetailsDataList
                                                ?.ownershipName ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .encumbered,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: landDetailsDataList?.encumbered ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .areaUnit,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text:
                                            landDetailsDataList?.areaUnitName ??
                                                '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text:
                                            AppLocalizations.of(context)!.area,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: landDetailsDataList?.area
                                                .toString() ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 40, top: 32),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        text: AppLocalizations.of(context)!
                                            .sourceOfIrrigation,
                                        fontSize: AppTextSize.contentSize16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      AppTextWidget(
                                        text: landDetailsDataList
                                                ?.sourceOfIrrigationName ??
                                            '',
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppTextSize.contentSize12,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                },
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
