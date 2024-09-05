import 'package:ekisan_credit/bloc/Add_address/add_address_bloc.dart';
import 'package:ekisan_credit/bloc/Add_address/add_address_event.dart';
import 'package:ekisan_credit/bloc/Add_address/add_address_state.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../utils/app_text_size.dart';
import '../../family/screens/family_screen.dart';
import '../widgets/same_current_permanent_address_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SameCurrentPermanentAddressScreen extends StatefulWidget {
  static String routeName = "same-current-permanent-address";

  const SameCurrentPermanentAddressScreen({super.key});

  @override
  State<SameCurrentPermanentAddressScreen> createState() =>
      _SameCurrentPermanentAddressScreenState();
}

class _SameCurrentPermanentAddressScreenState
    extends State<SameCurrentPermanentAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final createFarmerAddressCubit =
        context.read<CreateFarmerCurrentAddressCubit>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 34,
            ),
             Column(
              children: [
                Header(
                  pageNumber: 2,
                  percentageFirst: 100,
                  percentageSecond: 100,
                  percentageThird: 0,
                  pageName: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
             Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!.addressInformation,
                          fontWeight: FontWeight.w400,
                          fontSize: AppTextSize.contentSize22,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SameCurrentPermanentAddressWidget(),
                      SizedBox(
                        height: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<AddAddressBloc, AddAddressState>(
                builder: (BuildContext context, AddAddressState state) {
                  if (state is AddAddressLoading) {
                    return InkWell(
                      onTap: () {},
                      child:  CommonButton(
                        buttonName: AppLocalizations.of(context)!.save,
                        buttonColor: AppColors.grayColor,
                      ),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      final bodyRequest = [
                        {
                          "stateMasterId":
                              createFarmerAddressCubit.state.stateMasterId,
                          "districtMasterId":
                              createFarmerAddressCubit.state.districtMasterId,
                          "villageMasterId":
                              createFarmerAddressCubit.state.villageMasterId,
                          "address": createFarmerAddressCubit.state.address,
                          "pincode":
                              createFarmerAddressCubit.state.pincode ?? '',
                          "addressType": "CURRENT_ADDRESS"
                        },
                        {
                          "stateMasterId":
                              createFarmerAddressCubit.state.stateMasterId,
                          "districtMasterId":
                              createFarmerAddressCubit.state.districtMasterId,
                          "villageMasterId":
                              createFarmerAddressCubit.state.villageMasterId,
                          "address": createFarmerAddressCubit.state.address,
                          "pincode":
                              createFarmerAddressCubit.state.pincode ?? '',
                          "addressType": "PERMANENT_ADDRESS"
                        },
                      ];

                      context.read<AddAddressBloc>().add(
                            AddAddress(
                                bodyRequest: bodyRequest,
                                isSameAddress: createFarmerAddressCubit
                                        .state.isAddressSame ??
                                    false),
                          );
                    },
                    child:  CommonButton(buttonName: AppLocalizations.of(context)!.save),
                  );
                },
                listener: (BuildContext context, AddAddressState state) {
                  if (state is AddAddressSuccess) {
                    Navigator.pushNamed(context, FamilyScreen.routeName);
                    if (mounted) {
                      context
                          .read<GetFarmerBloc>()
                          .add(GetFarmerDetails(body: const {}));
                    }
                  }
                },
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
