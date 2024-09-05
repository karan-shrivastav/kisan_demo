import 'package:ekisan_credit/view/home/screens/home_screen.dart';
import 'package:ekisan_credit/view/land/widget/edit_land_village_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Utils/shared_preference_helper.dart';
import '../../../bloc/add_land/add_land_bloc.dart';
import '../../../bloc/add_land/add_land_event.dart';
import '../../../bloc/add_land/add_land_state.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../cubit/add_land/edit_land_cubit.dart';
import '../../../cubit/model/add_land_irrigated_non_irrigated_cubit_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../../utils/form_validation.dart';
import '../widget/edit_land_area_unit_widget.dart';
import '../widget/edit_land_district_widget.dart';
import '../widget/edit_land_encumbered_widget.dart';
import '../widget/edit_land_source_of_irrigation_widget.dart';
import '../widget/edit_land_state_widget.dart';
import '../widget/edit_land_type_ownership_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLandDetailScreen extends StatefulWidget {
  static const routeName = 'edit-land-details';
  const EditLandDetailScreen({super.key});

  @override
  State<EditLandDetailScreen> createState() => _EditLandDetailScreenState();
}

class _EditLandDetailScreenState extends State<EditLandDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _landSizeController = TextEditingController();
  final TextEditingController _surveyNumberController = TextEditingController();
  @override
  void didChangeDependencies() {
    final lovsTypeData = [
      "AREAUNIT",
      "OWNERSHIP",
      "SOURCEIRRIGATIONNAME",
      "OCCUPATION",
    ];
    context.read<GetLovsTypeDataNewBloc>().add(
      GetLovsTypeDataNewList(
        bodyRequest: lovsTypeData,
      ),
    );
    final editLandCubit = context.read<EditLandCubit>().state;
    _surveyNumberController.text = editLandCubit.surveyNo!;
    _landSizeController.text = editLandCubit.area!;
    super.didChangeDependencies();
  }



  Future<String?> getFarmerId() {
    return AppSharedPreferenceHelper().getCustomerData("farmerId");
  }
  void addLand(addLandData) {
    context
        .read<AddLandDataBloc>()
        .add(AddLandDetailsData(landRequest: addLandData));
  }


  @override
  Widget build(BuildContext context) {
    final editLandCubit = context.read<EditLandCubit>();
    return Scaffold(
      body: Padding(
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
                const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.delete,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         AppTextWidget(
                          text: AppLocalizations.of(context)!.edit,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 28,
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
                        BlocListener<AddLandIrrigatedNonIrrigatedCubit,
                            AddLandIrrigatedNonIrrigatedCubitModel>(
                          listener: (BuildContext context,
                              AddLandIrrigatedNonIrrigatedCubitModel state) {},
                          child: CommonTextField(
                            labelText: AppLocalizations.of(context)!.landSize,
                            hintText: AppLocalizations.of(context)!.landSize,
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
                        const EditLandSourceOfIrrigation(),
                        const SizedBox(
                          height: 16,
                        ),
                        /************ Type of owner ship ****************/
                        const EditLandTypeOfOwnerShipWidget(),
                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const EditLandEncumberedWidget(),
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
                              labelText:AppLocalizations.of(context)!.ofWhichNonIrrigatedInAcre,
                              hintText: AppLocalizations.of(context)!.selectAnOption,
                              enabled: false,
                              controller:
                              TextEditingController(text: state.nonIrrigated),
                              onChange: (value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                )),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child:  CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: AppLocalizations.of(context)!.cancell,
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocConsumer<AddLandDataBloc, AddLandDataState>(
                    listener: (BuildContext context, AddLandDataState state) {
                      if (state is AddLandDataLoading) {
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) =>  AlertDialog(
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
                      } else if (state is AddLandDataSuccess) {
                        Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false,
                          arguments: {
                            'currentPageIndex': 4, // Example value to pass
                            // Add other key-value pairs as needed
                          },
                        );

                      } else {
                        Navigator.pop(context);
                      }
                    },
                    builder: (BuildContext context, AddLandDataState state) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          final addLandIrrigatedCubit = context
                              .read<AddLandIrrigatedNonIrrigatedCubit>()
                              .state;
                          final addLandData = {
                            "id":editLandCubit.state.id,
                            "farmerId": await getFarmerId(),
                            "stateMasterId": editLandCubit.state.stateMasterId,
                            "districtMasterId": editLandCubit.state.districtMasterId,
                            "villageId": editLandCubit.state.villageId,
                            "ownershipId": editLandCubit.state.ownershipId,
                            "areaUnitId": editLandCubit.state.areaUnitId,
                            "sourceOfIrrigationId":
                            addLandIrrigatedCubit.sourceOfIrrigationId,
                            "surveyNo": editLandCubit.state.surveyNo,
                            "encumbered": editLandCubit.state.encumbered,
                            "area": addLandIrrigatedCubit.landSize,
                            "irrigatedLand": addLandIrrigatedCubit.irrigated,
                            "unIrrigatedLand":
                            addLandIrrigatedCubit.nonIrrigated,
                          };

                          if (_formKey.currentState!.validate()) {
                            print(addLandData);

                            addLand(addLandData);
                          }
                        },
                        child:  CommonButton(
                          buttonName:  AppLocalizations.of(context)!.update,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
