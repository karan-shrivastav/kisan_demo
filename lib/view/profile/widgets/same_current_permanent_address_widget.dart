import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SameCurrentPermanentAddressWidget extends StatefulWidget {
  const SameCurrentPermanentAddressWidget({super.key});

  @override
  State<SameCurrentPermanentAddressWidget> createState() =>
      _SameCurrentPermanentAddressWidgetState();
}

class _SameCurrentPermanentAddressWidgetState
    extends State<SameCurrentPermanentAddressWidget> {
  String selectedValue = "";

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
  final TextEditingController _addressCodeTextEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    final createFarmerCurrentAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();

    // TODO: implement didChangeDependencies
    _stateTextEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedStateString ?? '';
    _districtEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedDistrictString ?? '';
    _villageTextEditingController.text =
        createFarmerCurrentAddressCubit.state.selectedVillageString ?? '';
    _pinCodeTextEditingController.text =
        createFarmerCurrentAddressCubit.state.pincode ?? '';
    _addressCodeTextEditingController.text =
        createFarmerCurrentAddressCubit.state.address ?? '';
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
              controller: _addressCodeTextEditingController,
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
