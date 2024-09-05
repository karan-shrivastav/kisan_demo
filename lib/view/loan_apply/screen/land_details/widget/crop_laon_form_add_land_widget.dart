import 'package:ekisan_credit/bloc/add_land/add_land_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Utils/shared_preference_helper.dart';
import '../../../../../bloc/add_land/add_land_bloc.dart';
import '../../../../../bloc/add_land/add_land_event.dart';
import '../../../../../bloc/get_land_details/get_land_details_bloc.dart';
import '../../../../../bloc/get_land_details/get_land_details_event.dart';
import '../../../../../common_button.dart';
import '../../../../../common_widget/app_text_widget.dart';
import '../../../../../common_widget/common_text_field_widget.dart';
import '../../../../../cubit/add_land/add_land_cubit.dart';
import '../../../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../../../cubit/model/add_land_cubit_model.dart';
import '../../../../../cubit/model/add_land_irrigated_non_irrigated_cubit_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/form_validation.dart';
import '../../../../land/screen/add_land_area_unit_widget.dart';
import '../../../../land/widget/add_land_district_widget.dart';
import '../../../../land/widget/add_land_encumbered_widget.dart';
import '../../../../land/widget/add_land_owner_ship_widget.dart';
import '../../../../land/widget/add_land_source_of_lrrigation_widget.dart';
import '../../../../land/widget/add_land_state_widget.dart';
import '../../../../land/widget/add_land_vilage_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLandFromAddLandWidget extends StatefulWidget {
  const CropLandFromAddLandWidget({super.key});

  @override
  State<CropLandFromAddLandWidget> createState() =>
      _CropLandFromAddLandWidgetState();
}

class _CropLandFromAddLandWidgetState extends State<CropLandFromAddLandWidget> {
  final TextEditingController _landSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String?> getFarmerId() {
    return AppSharedPreferenceHelper().getCustomerData("farmerId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.secondOutLineColor,
                  borderRadius: BorderRadius.circular(100)),
            ),
            const SizedBox(
              height: 28,
            ),
             AppTextWidget(
              text: AppLocalizations.of(context)!.addLandDetails,
              fontWeight: FontWeight.w400,
              fontSize: AppTextSize.contentSize22,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        /************** State ***************/

                        const AddLandStateWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        /*************  District ***********/
                        const AddLandDistrictWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        const AddLandVillageWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonTextField(
                          labelText:  AppLocalizations.of(context)!.surveyNumber,
                          hintText: AppLocalizations.of(context)!.surveyNumber,
                          validator: AppFormValidation.surveyNumber,
                          onChange: (value) {
                            context
                                .read<AddLandCubit>()
                                .updateModel(surveyNo: value);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const AddLandAreaUnitWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocListener<AddLandIrrigatedNonIrrigatedCubit,
                            AddLandIrrigatedNonIrrigatedCubitModel>(
                          listener: (BuildContext context,
                              AddLandIrrigatedNonIrrigatedCubitModel state) {},
                          child: CommonTextField(
                            labelText: AppLocalizations.of(context)!.landSize,
                            hintText: AppLocalizations.of(context)!.landSize,
                            keyboardType: TextInputType.number,
                            validator: AppFormValidation.landSize,
                            controller: _landSizeController,
                            onChange: (value) {
                              context
                                  .read<AddLandIrrigatedNonIrrigatedCubit>()
                                  .updateModel(
                                    landSize: value,
                                  );
                              context
                                  .read<AddLandIrrigatedNonIrrigatedCubit>()
                                  .calculateLandByUnitNew();
                              // context.read<AddLandIrrigatedNonIrrigatedCubit>().calculateLandByUnitNew();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        /********** Source of Irrigation **************/
                        const AddLandSourceOfIrrigationWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        /************ Type of owner ship ****************/
                        const AddLandOwnerShipWidget(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const AddLandEncumbered(),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<AddLandIrrigatedNonIrrigatedCubit,
                            AddLandIrrigatedNonIrrigatedCubitModel>(
                          builder: (BuildContext context,
                              AddLandIrrigatedNonIrrigatedCubitModel state) {
                            return CommonTextField(
                              labelText: AppLocalizations.of(context)!.ofWhichIrrigatedInAcre,
                              hintText: AppLocalizations.of(context)!.selectAnOption,
                              controller:
                                  TextEditingController(text: state.irrigated),
                              enabled: false,
                              onChange: (value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<AddLandIrrigatedNonIrrigatedCubit,
                            AddLandIrrigatedNonIrrigatedCubitModel>(
                          builder: (BuildContext context,
                              AddLandIrrigatedNonIrrigatedCubitModel state) {
                            return CommonTextField(
                              labelText: AppLocalizations.of(context)!.ofWhichIrrigatedInAcre,
                              hintText: AppLocalizations.of(context)!.selectAnOption,
                              enabled: false,
                              controller: TextEditingController(
                                  text: state.nonIrrigated),
                              onChange: (value) {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:  CommonButton(
                        buttonName:AppLocalizations.of(context)!.cancel,
                        borderColor: AppColors.greenColor,
                        buttonColor: Colors.transparent,
                        buttonTextColor: AppColors.greenColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(child: BlocBuilder<AddLandCubit, AddLandCubitModel>(
                    builder: (BuildContext context, AddLandCubitModel landDataCubit) {

                      final addIrrigatedNonIrrigated = context
                          .read<AddLandIrrigatedNonIrrigatedCubit>()
                          .state;

                      if (landDataCubit.stateMasterId != null &&
                          landDataCubit.districtMasterId != null &&
                          landDataCubit.villageId != null &&
                          landDataCubit.surveyNo != null &&
                          landDataCubit.surveyNo!.isNotEmpty &&
                          addIrrigatedNonIrrigated.areaUnitId != null &&
                          addIrrigatedNonIrrigated.sourceOfIrrigationId !=
                              null &&
                          addIrrigatedNonIrrigated.landSize != null &&
                          addIrrigatedNonIrrigated.landSize!.isNotEmpty &&

                          landDataCubit.encumbered != null){
                        return  BlocConsumer<AddLandDataBloc, AddLandDataState>(
                          builder: (BuildContext context, state) {
                            return InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final landDataCubit =
                                      context.read<AddLandCubit>().state;
                                  final addIrrigatedNonIrrigated = context
                                      .read<AddLandIrrigatedNonIrrigatedCubit>()
                                      .state;
                                  final addLandData = {
                                    "farmerId": await getFarmerId(),
                                    "stateMasterId": landDataCubit.stateMasterId,
                                    "districtMasterId":
                                    landDataCubit.districtMasterId,
                                    "villageId": landDataCubit.villageId,
                                    "ownershipId": landDataCubit.ownershipId,
                                    "areaUnitId":
                                    addIrrigatedNonIrrigated.areaUnitId,
                                    "sourceOfIrrigationId":
                                    addIrrigatedNonIrrigated
                                        .sourceOfIrrigationId,
                                    "surveyNo": landDataCubit.surveyNo,
                                    "encumbered": landDataCubit.encumbered,
                                    "area": addIrrigatedNonIrrigated.landSize,
                                    "irrigatedLand":
                                    addIrrigatedNonIrrigated.irrigated,
                                    "unIrrigatedLand":
                                    addIrrigatedNonIrrigated.nonIrrigated,
                                  };

                                  context.read<AddLandDataBloc>().add(
                                      AddLandDetailsData(
                                          landRequest: addLandData));
                                }
                              },
                              child:  CommonButton(
                                buttonName: AppLocalizations.of(context)!.save,
                              ),
                            );
                          },
                          listener:
                              (BuildContext context, AddLandDataState state) {
                            if (state is AddLandDataLoading) {
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
                            }
                            if (state is AddLandDataSuccess) {
                              Navigator.of(context).pop();
                              final addIrrigatedNonIrrigated = context
                                  .read<AddLandIrrigatedNonIrrigatedCubit>()
                                  .state;
                              addIrrigatedNonIrrigated.irrigated = '0';
                              addIrrigatedNonIrrigated.nonIrrigated = '0';
                              context
                                  .read<GetLandDataBloc>()
                                  .add(GetLandListData(landRequest: const {}));
                              Navigator.of(context).pop();
                            }
                          },
                        );

                      }
                      return  CommonButton(
                        buttonName: AppLocalizations.of(context)!.save,
                        buttonColor: AppColors.grayColor,
                      );
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
