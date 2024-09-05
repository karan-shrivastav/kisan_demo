import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/profile/widgets/state_drop_down_permanent_widget.dart';
import 'package:ekisan_credit/view/profile/widgets/village_drop_down_permanent_widet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../utils/form_validation.dart';
import 'district_drop_down_permanent_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PermanentAddressInformationWidget extends StatefulWidget {
  const PermanentAddressInformationWidget({super.key});

  @override
  State<PermanentAddressInformationWidget> createState() =>
      _PermanentAddressInformationWidget();
}

class _PermanentAddressInformationWidget
    extends State<PermanentAddressInformationWidget> {
  String selectedValue = "";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "India", child: Text("India")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerPermanentAddressCubit =
        context.read<CreateFarmerPermanentAddressCubit>();
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
              validator: AppFormValidation.validateFullAddress,
              onChange: (value) {
                createFarmerPermanentAddressCubit.updateModel(address: value);
              },
            ),
            const SizedBox(
              height: 16,
            ),

            /************* Sate ****************/
            const StateDropDownPermanentWidget(),
            /************* District  ****************/
            const SizedBox(
              height: 16,
            ),
            const DistrictDropDownPermanentWidget(),
            /************** Village/Locality ***********/
            const SizedBox(
              height: 16,
            ),
            VillageDropDownPermanentWidget(),
            /*********** Pin code  ************/
            const SizedBox(
              height: 16,
            ),
            CommonTextField(
              labelText: AppLocalizations.of(context)!.pinCode,
              vertical: 20,
              length: 6,
              keyboardType: TextInputType.number,
              validator: AppFormValidation.validatePinCode,
              onChange: (value) {
                createFarmerPermanentAddressCubit.updateModel(pincode: value);
              },
            )
          ],
        )
      ],
    );
  }
}
