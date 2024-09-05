import 'package:ekisan_credit/bloc/get_land_details/get_land_details_bloc.dart';
import 'package:ekisan_credit/cubit/add_land/edit_land_cubit.dart';
import 'package:ekisan_credit/view/land/screen/view_land_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_land_details/get_land_details_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../profile/screens/profile_bottom_sheet.dart';

class LandListScreen extends StatefulWidget {
  const LandListScreen({super.key});

  @override
  State<LandListScreen> createState() => _LandListScreenState();
}

class _LandListScreenState extends State<LandListScreen> {
  bool first = false;
  bool isEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    context.read<GetLandDataBloc>().add(GetLandListData(landRequest: const {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final landData = context.watch<GetLandDataBloc>();
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
                text: AppLocalizations.of(context)!.land,
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
                    onTap: () {
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
                      color: AppColors.textBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          if (landData.getLandResponseModel.data != null)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: landData.getLandResponseModel.data?.content?.length,
                itemBuilder: (context, index) {
                  final landResponseData =
                      landData.getLandResponseModel.data?.content?[index];
                  return InkWell(
                    onTap: () {
                      context.read<EditLandCubit>().updateModel(
                          id: landResponseData?.id,
                          stateName: landResponseData?.stateName ?? '',
                          districtName: landResponseData?.districtName ?? '',
                          villageName: landResponseData?.villageName ?? '',
                          ownerShipName: landResponseData?.ownershipName ?? '',
                          encumbered: landResponseData?.encumbered ?? '',
                          area: landResponseData?.area.toString() ?? '',
                          sourceOfIrrigationNAme:
                              landResponseData?.sourceOfIrrigationName ?? '',
                          surveyNo: landResponseData?.surveyNo ?? '',
                          farmerId: landResponseData?.farmerId ?? 0,
                          stateMasterId: landResponseData?.stateMasterId ?? 0,
                          districtMasterId:
                              landResponseData?.districtMasterId ?? 0,
                          villageId: landResponseData?.villageId ?? 0,
                          ownershipId: landResponseData?.ownershipId ?? 0,
                          areaUnitId: landResponseData?.areaUnit?.id,
                          areaUnitName: landResponseData?.areaUnitName,
                          sourceOfIrrigationId:
                              landResponseData?.sourceOfIrrigation?.id,
                          irrigatedLand:
                              landResponseData?.irrigatedLand.toString(),
                          unIrrigatedLand:
                              landResponseData?.unIrrigatedLand?.toInt());
                      Navigator.pushNamed(
                        context,
                        ViewLandDetailsScreen.routeName,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              isEnable
                                  ? Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.greenColor,
                                      value:
                                          landResponseData?.isChecked ?? false,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          landResponseData?.isChecked = value!;
                                        });
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: landResponseData?.surveyNo ?? '',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.textBlackColor,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AppTextWidget(
                                    text: landResponseData?.villageName ?? '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: AppColors.textColorPrimary,
                                  )
                                ],
                              )
                            ],
                          ),
                          AppTextWidget(
                            text:
                                '${landResponseData?.area} ${landResponseData?.areaUnitName}',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
