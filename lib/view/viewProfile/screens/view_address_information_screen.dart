import 'package:ekisan_credit/view/viewProfile/widgets/address_view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewAddressInformationScreen extends StatefulWidget {
  static String routeName = "view-address-information-screen";
  const ViewAddressInformationScreen({super.key});

  @override
  State<ViewAddressInformationScreen> createState() =>
      _ViewAddressInformationScreenState();
}

class _ViewAddressInformationScreenState
    extends State<ViewAddressInformationScreen> {
  GetFarmerByIdResponseModel? getFarmerResponseModel;
  List<AddressDto>? addressList = [];
  String? presentAddress = '';
  String? presentVillage = '';
  String? presentDistrict = '';
  String? presentState = '';
  String? presentPinCode = '';
  String? pemanentAddress = '';
  String? permanentVillage = '';
  String? permanentDistrict = '';
  String? permanentState = '';
  String? permanentPincode = '';

  @override
  void didChangeDependencies() {
    getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel?.data?.addressDtos != null &&
        getFarmerResponseModel!.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel?.data?.addressDtos;
      presentAddress = addressList?[0].address;
      presentVillage = addressList?[0].villageName;
      presentDistrict = addressList?[0].districtName;
      presentState = addressList?[0].stateName;
      presentPinCode = addressList?[0].pincode;
      pemanentAddress = addressList?[1].address;
      permanentVillage = addressList?[1].villageName;
      permanentDistrict = addressList?[1].districtName;
      permanentState = addressList?[1].stateName;
      permanentPincode = addressList?[1].pincode;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return getFarmerResponseModel!.data!.addressDtos!.isNotEmpty
        ? Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AddressViewCard(
                    title: AppLocalizations.of(context)!.profile,
                    address:
                        '$presentAddress, $presentVillage, $presentDistrict, $presentState - $presentPinCode',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AddressViewCard(
                    title: AppLocalizations.of(context)!.permanent,
                    address:
                        '$pemanentAddress, $permanentVillage, $permanentDistrict, $permanentState - $permanentPincode',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                   AddressViewCard(
                    title: AppLocalizations.of(context)!.fromAadhaar,
                    address:
                        'asasa, 7 km Farm, Nicobars, Andaman And Nicobar Islands - 1212',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          )
        :  Expanded(
            child: Center(
              child: AppTextWidget(
                text: AppLocalizations.of(context)!.noData,
                fontSize: 20,
              ),
            ),
          );
  }
}
