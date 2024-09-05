import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../common_widget/common_description_text_field.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'edit_permanent_address_widget.dart';

class PermanentAddressInformationEditWidget extends StatefulWidget {
  const PermanentAddressInformationEditWidget({super.key});

  @override
  State<PermanentAddressInformationEditWidget> createState() =>
      _PermanentAddressInformationEditWidget();
}

class _PermanentAddressInformationEditWidget
    extends State<PermanentAddressInformationEditWidget> {
  List<AddressDto>? addressList = [];
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  String selectedValue = "";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "India", child: Text("India")),
    ];
    return menuItems;
  }

  @override
  void didChangeDependencies() {
    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos;
      _permanentAddressController.text = addressList?[1].address ?? '';
      _pinCodeController.text = addressList?[1].pincode ?? '';

      final permanentAddressCubit =
          context.read<CreateFarmerPermanentAddressCubit>();
      permanentAddressCubit.updateModel(
          address: addressList?[1].address ?? '',
          pincode: addressList?[1].pincode ?? '');
    }
    super.didChangeDependencies();
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
              controller: _permanentAddressController,
              labelText: AppLocalizations.of(context)!.fullAddress,
              hintText: AppLocalizations.of(context)!.asPerAadhaar,
              validator: AppFormValidation.validateFullAddress,
              onChange: (value) {
                createFarmerPermanentAddressCubit.updateModel(address: value);
              },
            ),

            const EditPermanentAddressWidget(),
            CommonTextField(
              controller: _pinCodeController,
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
