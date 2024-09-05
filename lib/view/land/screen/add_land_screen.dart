import 'package:ekisan_credit/bloc/add_land/add_land_state.dart';
import 'package:ekisan_credit/cubit/add_land/add_land_cubit.dart';
import 'package:ekisan_credit/utils/shared_preference_helper.dart';
import 'package:ekisan_credit/view/land/widget/add_land_source_of_lrrigation_widget.dart';
import 'package:ekisan_credit/view/land/widget/add_land_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/add_land/add_land_bloc.dart';
import '../../../bloc/add_land/add_land_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/add_land/add_land_irrigated_non_irrigated_cubit.dart';
import '../../../cubit/model/add_land_irrigated_non_irrigated_cubit_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../../utils/form_validation.dart';
import '../../home/screens/home_screen.dart';
import '../widget/add_land_district_widget.dart';
import '../widget/add_land_encumbered_widget.dart';
import '../widget/add_land_owner_ship_widget.dart';
import '../widget/add_land_vilage_widget.dart';
import 'add_land_area_unit_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddLandScreen extends StatefulWidget {
  static const routeName = 'add-land';

  const AddLandScreen({super.key});

  @override
  State<AddLandScreen> createState() => _AddLandScreenState();
}

class _AddLandScreenState extends State<AddLandScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final lovsTypeData = [
      "AREAUNIT",
      "OWNERSHIP",
      "SOURCEIRRIGATIONNAME",
      "GENDER",
      "NAMINGTITLE",
      "IDPROOF",
      "RELIGIONNAME",
      "CASTE",
      "OCCUPATION",
    ];
    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  final TextEditingController _landSizeController = TextEditingController();

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
                      text: AppLocalizations.of(context)!.add,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 28,
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
                      labelText: 'Survey Number',
                      hintText: "Survey Number",
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
                        labelText: 'Land Size',
                        hintText: "Land Size",
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                          labelText: 'Of which Irrigated (In Acre)',
                          hintText: "Select an Option",
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
                          labelText: 'Of which Non Irrigated (In Acre)',
                          hintText: "Select an Option",
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
                    child: const CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: 'CANCEL',
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
                          builder: (BuildContext context) => const AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            scrollable: true,
                            content: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                                AppTextWidget(
                                  text: "Saving...",
                                  fontSize: AppTextSize.contentSize20,
                                  fontWeight: FontWeight.w500,
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (state is AddLandDataSuccess) {
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
                    builder: (BuildContext context, AddLandDataState state) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          final addLandCubit =
                              context.read<AddLandCubit>().state;
                          final addLandIrrigatedCubit = context
                              .read<AddLandIrrigatedNonIrrigatedCubit>()
                              .state;
                          final addLandData = {
                            "farmerId": await getFarmerId(),
                            "stateMasterId": addLandCubit.stateMasterId,
                            "districtMasterId": addLandCubit.districtMasterId,
                            "villageId": addLandCubit.villageId,
                            "ownershipId": addLandCubit.ownershipId,
                            "areaUnitId": addLandIrrigatedCubit.areaUnitId,
                            "sourceOfIrrigationId":
                                addLandIrrigatedCubit.sourceOfIrrigationId,
                            "surveyNo": addLandCubit.surveyNo,
                            "encumbered": addLandCubit.encumbered,
                            "area": addLandIrrigatedCubit.landSize,
                            "irrigatedLand": addLandIrrigatedCubit.irrigated,
                            "unIrrigatedLand":
                                addLandIrrigatedCubit.nonIrrigated,
                          };

                          if (_formKey.currentState!.validate()) {
                            addLand(addLandData);
                          }
                        },
                        child: const CommonButton(
                          buttonName: 'ADD',
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
