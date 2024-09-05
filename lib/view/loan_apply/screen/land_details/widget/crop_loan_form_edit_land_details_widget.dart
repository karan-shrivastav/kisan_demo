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
import '../../../../../cubit/add_land/edit_land_cubit.dart';
import '../../../../../cubit/model/edit_land_cubit_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text_size.dart';
import '../../../../../utils/form_validation.dart';
import '../../../../land/widget/edit_land_area_unit_widget.dart';
import '../../../../land/widget/edit_land_district_widget.dart';
import '../../../../land/widget/edit_land_encumbered_widget.dart';
import '../../../../land/widget/edit_land_source_of_irrigation_widget.dart';
import '../../../../land/widget/edit_land_state_widget.dart';
import '../../../../land/widget/edit_land_type_ownership_widget.dart';
import '../../../../land/widget/edit_land_village_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CropLoanFormEditLandDetails extends StatefulWidget {
  const CropLoanFormEditLandDetails({super.key});

  @override
  State<CropLoanFormEditLandDetails> createState() =>
      _CropLoanFormEditLandDetailsState();
}

class _CropLoanFormEditLandDetailsState
    extends State<CropLoanFormEditLandDetails> {
  final TextEditingController _landSizeController = TextEditingController();
  final TextEditingController _surveyNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<String?> getFarmerId() {
    return AppSharedPreferenceHelper().getCustomerData("farmerId");
  }

  @override
  void initState() {
    final landData = context.read<EditLandCubit>().state;
    _surveyNumberController.text = landData.surveyNo ?? '';
    _landSizeController.text = '${landData.area ?? 0}';
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
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child:  AppTextWidget(
                        text: AppLocalizations.of(context)!.editLandDetails,
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSize.contentSize22,
                        textAlign: TextAlign.center),
                  ),
                  Spacer(),
                  Icon(Icons.delete, color: Colors.red,),
                ],
              ),
            ),
            const SizedBox(height: 24,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        /************** State ***************/
                        const EditLandDetailState(),
                        const SizedBox(
                          height: 16,
                        ),
                        /*************  District ***********/
                        const EditLandDistrictWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        const EditLandVillageWidget(),
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
                          labelText: AppLocalizations.of(context)!.surveyNumber,
                          hintText: AppLocalizations.of(context)!.surveyNumber,
                          controller: _surveyNumberController,
                          validator: AppFormValidation.surveyNumber,
                          onChange: (value) {
                            context
                                .read<EditLandCubit>()
                                .updateModel(surveyNo: value);
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const EditLandAreaUnitWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocListener<EditLandCubit, EditLandCubitModel>(
                          listener: (BuildContext context,
                              EditLandCubitModel state) {},
                          child: CommonTextField(
                            labelText: AppLocalizations.of(context)!.landSize,
                            hintText: AppLocalizations.of(context)!.landSize,
                            validator: AppFormValidation.landSize,
                            controller: _landSizeController,
                            onChange: (value) {
                              context.read<EditLandCubit>().updateModel(
                                    area: value,
                                  );
                              context
                                  .read<EditLandCubit>()
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
                        const EditLandSourceOfIrrigation(),
                        const SizedBox(
                          height: 16,
                        ),
                        /************ Type of owner ship ****************/
                        const EditLandTypeOfOwnerShipWidget(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const EditLandEncumberedWidget(),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<EditLandCubit, EditLandCubitModel>(
                          builder:
                              (BuildContext context, EditLandCubitModel state) {
                            return CommonTextField(
                              labelText: AppLocalizations.of(context)!.ofWhichIrrigatedInAcre,
                              hintText: AppLocalizations.of(context)!.selectAnOption,
                              controller: TextEditingController(
                                  text: state.irrigatedLand),
                              enabled: false,
                              onChange: (value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<EditLandCubit, EditLandCubitModel>(
                          builder:
                              (BuildContext context, EditLandCubitModel state) {
                            return CommonTextField(
                              labelText: AppLocalizations.of(context)!.ofWhichIrrigatedInAcre,
                              hintText: AppLocalizations.of(context)!.selectAnOption,
                              enabled: false,
                              controller: TextEditingController(
                                text: '${state.unIrrigatedLand}',
                              ),
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
                      child: CommonButton(
                        buttonName: AppLocalizations.of(context)!.cancel,
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
                    child: BlocConsumer<AddLandDataBloc, AddLandDataState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final landDataCubit =
                                  context.read<EditLandCubit>().state;
                              final addLandData = {
                                "id": landDataCubit.id,
                                "farmerId": await getFarmerId(),
                                "stateMasterId": landDataCubit.stateMasterId,
                                "districtMasterId":
                                    landDataCubit.districtMasterId,
                                "villageId": landDataCubit.villageId,
                                "ownershipId": landDataCubit.ownershipId,
                                "areaUnitId": landDataCubit.areaUnitId,
                                "sourceOfIrrigationId":
                                    landDataCubit.sourceOfIrrigationId,
                                "surveyNo": landDataCubit.surveyNo,
                                "encumbered": landDataCubit.encumbered,
                                "area": landDataCubit.area,
                                "irrigatedLand": landDataCubit.irrigatedLand,
                                "unIrrigatedLand":
                                    landDataCubit.unIrrigatedLand,
                              };
                              context.read<AddLandDataBloc>().add(
                                  AddLandDetailsData(landRequest: addLandData));
                            }
                          },
                          child:  CommonButton(
                            buttonName: AppLocalizations.of(context)!.save,
                          ),
                        );
                      },
                      listener: (BuildContext context, AddLandDataState state) {
                        if (state is AddLandDataSuccess) {
                          context
                              .read<GetLandDataBloc>()
                              .add(GetLandListData(landRequest: const {}));
                          Navigator.of(context).pop();
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
