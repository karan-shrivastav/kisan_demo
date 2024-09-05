import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSameCurrentPermanentAddressWidget extends StatefulWidget {
  const EditSameCurrentPermanentAddressWidget({super.key});

  @override
  State<EditSameCurrentPermanentAddressWidget> createState() =>
      _EditSameCurrentPermanentAddressWidgetState();
}

class _EditSameCurrentPermanentAddressWidgetState
    extends State<EditSameCurrentPermanentAddressWidget> {
  String selectedValue = "";
  List<AddressDto>? addressList = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "India", child: Text("India")),
    ];
    return menuItems;
  }

  final TextEditingController _stateTextEditingController =
      TextEditingController();
  final TextEditingController _districtEditingController =
      TextEditingController();
  final TextEditingController _villageTextEditingController =
      TextEditingController();
  final TextEditingController _pinCodeTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    final createFarmerCurrentAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();
    context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));

    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    addressList = getFarmerResponseModel.data?.addressDtos;
    _stateTextEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedStateString ??
            addressList?[0].stateName ??
            '';
    _districtEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedDistrictString ??
            addressList?[0].districtName ??
            '';
    _villageTextEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedVillageString ??
            addressList?[0].villageName ??
            '';
    _pinCodeTextEditingController.text =
        createFarmerCurrentAddressCubit.state.pincode ??
            addressList?[0].pincode ??
            '';
    _addressTextEditingController.text =
        createFarmerCurrentAddressCubit.state.address ??
            addressList?[0].address ??
            '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.permanentAddress,
                  fontWeight: FontWeight.w500,
                  fontSize: AppTextSize.contentSize16,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CommonDescriptionTextField(
              labelText: AppLocalizations.of(context)!.fullAddress,
              hintText: AppLocalizations.of(context)!.asPerAadhaar,
              enabled: false,
              controller: _addressTextEditingController,
            ),
            const SizedBox(
              height: 16,
            ),
            /************* Sate ****************/
            CommonTextField(
              labelText: AppLocalizations.of(context)!.state,
              controller: _stateTextEditingController,
              enabled: false,
              vertical: 20,
            ),
            /************* District  ****************/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              labelText: AppLocalizations.of(context)!.district,
              enabled: false,
              vertical: 20,
              controller: _districtEditingController,
            ),
            /************** Village/Locality ***********/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              labelText: AppLocalizations.of(context)!.villageLocality,
              enabled: false,
              vertical: 20,
              controller: _villageTextEditingController,
            ),
            /*********** Pin code  ************/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              labelText: AppLocalizations.of(context)!.pinCode,
              vertical: 20,
              enabled: false,
              controller: _pinCodeTextEditingController,
            )
          ],
        )
      ],
    );
  }
}
