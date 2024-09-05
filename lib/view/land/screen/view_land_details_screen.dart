import 'package:ekisan_credit/bloc/delete_land/delete_land_data_state.dart';
import 'package:ekisan_credit/cubit/add_land/edit_land_cubit.dart';
import 'package:ekisan_credit/view/land/screen/edit_land_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/delete_land/delete_land_bloc.dart';
import '../../../bloc/delete_land/delete_land_data_event.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../home/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewLandDetailsScreen extends StatelessWidget {
  static const routeName = 'view-land-details';

  const ViewLandDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditLandCubit>().state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                          final districtRequest = {
                            "stateId": editCubit.stateMasterId ?? ''
                          }; // Set the selected value to _selectedState
                          context.read<DistrictBlocNew>().add(
                              GetAllDistrictByState(
                                  districtRequest: districtRequest));
                          context
                              .read<AddLandIrrigatedNonIrrigatedCubit>()
                              .updateModel(
                                  irrigated: editCubit.irrigatedLand,
                                  nonIrrigated:
                                      editCubit.unIrrigatedLand.toString());
                          context
                              .read<AddLandIrrigatedNonIrrigatedCubit>()
                              .updateModel(
                                  landSize: editCubit.area,
                                  irrigated: editCubit.irrigatedLand,
                                  nonIrrigated:
                                      editCubit.unIrrigatedLand.toString(),
                                  areaUnitId: editCubit.areaUnitId,
                                  sourceOfIrrigationId:
                                      editCubit.sourceOfIrrigationId);
                          Navigator.pushNamed(
                              context, EditLandDetailScreen.routeName);
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
                      BlocConsumer<DeleteLandDataBloc, DeleteLandDataState>(
                        builder:
                            (BuildContext context, DeleteLandDataState state) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<DeleteLandDataBloc>()
                                  .add(DeleteLandData(id: editCubit.id ?? 0));
                            },
                            child: const Icon(
                              Icons.delete,
                              size: 24,
                              color: Colors.red,
                            ),
                          );
                        },
                        listener:
                            (BuildContext context, DeleteLandDataState state) {
                          if (state is DeleteLandDataLoading) {
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
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .deleting,
                                      fontSize: AppTextSize.contentSize20,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (state is DeleteLandDataSuccess) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeScreen.routeName,
                              (Route<dynamic> route) => false,
                              arguments: {
                                'currentPageIndex': 4, // Example value to pass
                                // Add other key-value pairs as needed
                              },
                            );
                          } else {
                            Navigator.pop(context);
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
              Row(
                children: [
                  AppTextWidget(
                    text: editCubit.surveyNo ?? '',
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.textBlackColor,
                    textAlign: TextAlign.center,
                  ),
                ],
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
                        text: AppLocalizations.of(context)!.state,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.textBlackColor,
                      ),
                    ],
                  ),
                  AppTextWidget(
                    text: editCubit.stateName ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.textColorPrimary,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.district,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.districtName ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text:AppLocalizations.of(context)!.village,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.villageName ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text:AppLocalizations.of(context)!.ownerShip,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.ownerShipName ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.encumbered,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.encumbered ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.area,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.area ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.sourceOfIrrigation,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.sourceOfIrrigationNAme ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.onWhichIrrigatedInAcre,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.irrigatedLand ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             AppTextWidget(
                              text: AppLocalizations.of(context)!.onWhichIrrigatedInAcre,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textBlackColor,
                            ),
                            AppTextWidget(
                              text: editCubit.unIrrigatedLand.toString() ?? '',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.textColorPrimary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
