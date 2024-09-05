import 'package:ekisan_credit/bloc/update_contact_info/update_contact_info_state.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/update_contact_info/update_contact_info_bloc.dart';
import '../../../bloc/update_contact_info/update_contact_info_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_text_size.dart';
import '../widgets/edit_same_current_permanent_address_widget.dart';
import 'edit_family_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSameCurrentPermanentAddressScreen extends StatefulWidget {
  static String routeName = "edit-same-current-permanent-address";

  const EditSameCurrentPermanentAddressScreen({super.key});

  @override
  State<EditSameCurrentPermanentAddressScreen> createState() =>
      _EditSameCurrentPermanentAddressScreenState();
}

class _EditSameCurrentPermanentAddressScreenState
    extends State<EditSameCurrentPermanentAddressScreen> {
  List<AddressDto> addressList = [];

  @override
  void didChangeDependencies() {
    context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    addressList = getFarmerResponseModel.data?.addressDtos ?? [];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();
    return Scaffold(
      body: Column(
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
                        text:AppLocalizations.of(context)!.addressInformation,
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSize.contentSize22,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const EditSameCurrentPermanentAddressWidget(),
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
            child:
                BlocConsumer<UpdateContactInfoBloc, UpdateContactInfoState>(
              builder: (BuildContext context, UpdateContactInfoState state) {
                if (state is UpdateContactInfoStateLoading) {
                  return InkWell(
                    onTap: () {},
                    child:  CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                      buttonColor: AppColors.grayColor,
                    ),
                  );
                }

                return InkWell(
                  onTap: () {
                    final bodyRequest = [
                      {
                        "id": addressList.isEmpty ? "" : addressList[0].id,
                        "stateMasterId":
                            createFarmerAddressCubit.state.stateMasterId ??
                                addressList[0].stateId,
                        "districtMasterId":
                            createFarmerAddressCubit.state.districtMasterId ??
                                addressList[0].districtId,
                        "villageMasterId":
                            createFarmerAddressCubit.state.villageMasterId ??
                                addressList[0].villageId,
                        "address": createFarmerAddressCubit.state.address ??
                            addressList[0].address,
                        "pincode": createFarmerAddressCubit.state.pincode ??
                            addressList[0].pincode,
                        "addressType": "CURRENT_ADDRESS"
                      },
                      {
                        "id": addressList.isEmpty ? "" : addressList[1].id,
                        "stateMasterId":
                            createFarmerAddressCubit.state.stateMasterId ??
                                addressList[1].stateId,
                        "districtMasterId":
                            createFarmerAddressCubit.state.districtMasterId ??
                                addressList[1].districtId,
                        "villageMasterId":
                            createFarmerAddressCubit.state.villageMasterId ??
                                addressList[1].villageId,
                        "address": createFarmerAddressCubit.state.address ??
                            addressList[1].address,
                        "pincode": createFarmerAddressCubit.state.pincode ??
                            addressList[1].pincode,
                        "addressType": "PERMANENT_ADDRESS"
                      },
                    ];

                    context.read<UpdateContactInfoBloc>().add(
                          UpdateContactInfoDetails(
                              body: bodyRequest,
                              bothAddressSame: createFarmerAddressCubit
                                      .state.isAddressSame ??
                                  false),
                        );
                  },
                  child:  CommonButton(buttonName: AppLocalizations.of(context)!.next),
                );
              },
              listener: (BuildContext context, UpdateContactInfoState state) {
                if (state is UpdateContactInfoStateSuccess) {
                  Navigator.pushNamed(context, EditFamilyScreen.routeName);
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
