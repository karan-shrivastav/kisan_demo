import 'package:ekisan_credit/bloc/update_contact_info/update_contact_info_bloc.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/update_contact_info/update_contact_info_event.dart';
import '../../../bloc/update_contact_info/update_contact_info_state.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../widgets/permanent_address_information_edit_widget.dart';
import 'edit_family_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditContactInformationSecondScreen extends StatefulWidget {
  static String routeName = "edit-contact-information-second-screen";

  const EditContactInformationSecondScreen({super.key});

  @override
  State<EditContactInformationSecondScreen> createState() =>
      _EditContactInformationSecondScreenState();
}

class _EditContactInformationSecondScreenState
    extends State<EditContactInformationSecondScreen> {
  final _formKey = GlobalKey<FormState>();
  bool light0 = true;
  bool light1 = true;
  List<AddressDto>? addressList = [];
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

 @override
  void initState() {
   //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
   final GetFarmerByIdResponseModel getFarmerResponseModel =
       context.read<GetFarmerBloc>().getFarmerResponseModel;
   addressList = getFarmerResponseModel.data?.addressDtos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();
    final createFarmerPermanentAddressCubit =
        context.read<CreateFarmerPermanentAddressCubit>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 59,
            ),
            Column(
              children: [
                Header(
                  pageNumber: 2,
                  percentageFirst: 100,
                  percentageSecond: 100,
                  percentageThird: 0,
                  pageName: AppLocalizations.of(context)!.editProfile,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!
                              .addressInformation,
                          fontWeight: FontWeight.w400,
                          fontSize: AppTextSize.contentSize22,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const PermanentAddressInformationEditWidget(),
                      const SizedBox(
                        height: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<CreateFarmerPermanentAddressCubit,
                  CreateFarmerCurrentAddressCubitModel>(
                builder: (BuildContext context,
                    CreateFarmerCurrentAddressCubitModel state) {
                  if (state.address != '' &&
                      state.selectedStateString != '' &&
                      state.selectedDistrictString != '' &&
                      state.selectedVillageString != '' &&
                      state.pincode != '') {
                    return BlocConsumer<UpdateContactInfoBloc,
                        UpdateContactInfoState>(
                      builder: (BuildContext context,
                          UpdateContactInfoState state) {
                        if (state is UpdateContactInfoStateLoading) {
                          return InkWell(
                            onTap: () {},
                            child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.save,
                              buttonColor: AppColors.grayColor,
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                List<Map<String, dynamic>> bodyRequest = [
                                  {
                                    "id": addressList!.isEmpty
                                        ? ""
                                        : addressList?[0].id,
                                    "stateMasterId": createFarmerAddressCubit
                                            .state.stateMasterId ??
                                        addressList?[0].stateId,
                                    "districtMasterId":
                                        createFarmerAddressCubit
                                                .state.districtMasterId ??
                                            addressList?[0].districtId,
                                    "villageMasterId":
                                        createFarmerAddressCubit
                                                .state.villageMasterId ??
                                            addressList?[0].villageId,
                                    "address": createFarmerAddressCubit
                                            .state.address ??
                                        addressList?[0].address,
                                    "pincode": createFarmerAddressCubit
                                            .state.pincode ??
                                        addressList?[0].pincode,
                                    "addressType": "CURRENT_ADDRESS"
                                  },
                                  {
                                    "id": addressList!.isEmpty
                                        ? ""
                                        : addressList?[1].id,
                                    "stateMasterId":
                                        createFarmerPermanentAddressCubit
                                                .state.stateMasterId ??
                                            addressList?[1].stateId,
                                    "districtMasterId":
                                        createFarmerPermanentAddressCubit
                                                .state.districtMasterId ??
                                            addressList?[1].districtId,
                                    "villageMasterId":
                                        createFarmerPermanentAddressCubit
                                                .state.villageMasterId ??
                                            addressList?[1].villageId,
                                    "address":
                                        createFarmerPermanentAddressCubit
                                                .state.address ??
                                            addressList?[1].address,
                                    "pincode":
                                        createFarmerPermanentAddressCubit
                                                .state.pincode ??
                                            addressList?[1].pincode,
                                    "addressType": "PERMANENT_ADDRESS"
                                  },
                                ];
                                context.read<UpdateContactInfoBloc>().add(
                                      UpdateContactInfoDetails(
                                        body: bodyRequest,
                                        bothAddressSame:
                                            createFarmerPermanentAddressCubit
                                                    .state.isAddressSame ??
                                                false,
                                      ),
                                    );
                              }
                            },
                            child: CommonButton(
                                buttonName:
                                    AppLocalizations.of(context)!.save),
                          );
                        }
                      },
                      listener: (BuildContext context,
                          UpdateContactInfoState state) {
                        if (state is UpdateContactInfoStateSuccess) {
                          // context
                          //     .read<GetFarmerBloc>()
                          //     .add(GetFarmerDetails(body: const {}));
                          Navigator.pushNamed(
                              context, EditFamilyScreen.routeName);
                        }
                      },
                    );
                  }
                  return CommonButton(
                    buttonName: AppLocalizations.of(context)!.save,
                    buttonColor: AppColors.grayColor,
                  );
                },
                listener: (BuildContext context,
                    CreateFarmerCurrentAddressCubitModel state) {},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
