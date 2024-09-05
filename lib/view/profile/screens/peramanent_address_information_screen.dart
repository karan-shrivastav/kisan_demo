import 'package:ekisan_credit/bloc/Add_address/add_address_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:ekisan_credit/cubit/model/create_farmer_current_address_cubit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/profile/widgets/permanent_address_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/Add_address/add_address_bloc.dart';
import '../../../bloc/Add_address/add_address_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../utils/app_text_size.dart';
import '../../family/screens/family_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PermanentAddressInformationScreen extends StatefulWidget {
  static String routeName = "permanent-address-information";

  const PermanentAddressInformationScreen({super.key});

  @override
  State<PermanentAddressInformationScreen> createState() =>
      _PermanentAddressInformationScreenState();
}

class _PermanentAddressInformationScreenState
    extends State<PermanentAddressInformationScreen> {
  bool light0 = true;
  bool light1 = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: AppTextWidget(
                            text: AppLocalizations.of(context)!.addressInformation,
                            fontWeight: FontWeight.w400,
                            fontSize: AppTextSize.contentSize22,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const PermanentAddressInformationWidget(),
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
                child: BlocBuilder<CreateFarmerPermanentAddressCubit ,CreateFarmerCurrentAddressCubitModel>(
                  builder: (BuildContext context, CreateFarmerCurrentAddressCubitModel permanentState) {
                    if(permanentState.address != null && permanentState.address!.isNotEmpty && permanentState.selectedStateString != null && permanentState.selectedStateString!.isNotEmpty && permanentState.selectedDistrictString != null && permanentState.selectedDistrictString!.isNotEmpty && permanentState.selectedVillageString != null && permanentState.selectedVillageString!.isNotEmpty && permanentState.pincode != null && permanentState.pincode!.isNotEmpty){
                      return BlocConsumer<AddAddressBloc, AddAddressState>(
                        builder: (BuildContext context, AddAddressState state) {
                          final addressData = context.read<AddAddressBloc>();
                          return InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final createFarmerPermanentAddressCubit = context
                                    .read<CreateFarmerPermanentAddressCubit>()
                                    .state;
                                final createFarmerCurrentAddressCubit = context
                                    .read<CreateFarmerCurrentAddressCubit>()
                                    .state;

                                if (addressData
                                    .createFarmerAddressResponseModel.dataList !=
                                    null) {
                                  final bodyRequest = [
                                    {
                                      "id": addressData
                                          .createFarmerAddressResponseModel
                                          .dataList
                                          ?.first
                                          .id,
                                      "stateMasterId": createFarmerCurrentAddressCubit
                                          .stateMasterId,
                                      "districtMasterId":
                                      createFarmerCurrentAddressCubit
                                          .districtMasterId,
                                      "villageMasterId":
                                      createFarmerCurrentAddressCubit
                                          .villageMasterId,
                                      "address":
                                      createFarmerCurrentAddressCubit.address,
                                      "pincode":
                                      createFarmerCurrentAddressCubit.pincode ??
                                          '',
                                      "addressType": "CURRENT_ADDRESS"
                                    },
                                    {
                                      "id": addressData
                                          .createFarmerAddressResponseModel
                                          .dataList
                                          ?.last
                                          .id,
                                      "stateMasterId":
                                      createFarmerPermanentAddressCubit
                                          .stateMasterId,
                                      "districtMasterId":
                                      createFarmerPermanentAddressCubit
                                          .districtMasterId,
                                      "villageMasterId":
                                      createFarmerPermanentAddressCubit
                                          .villageMasterId,
                                      "address":
                                      createFarmerPermanentAddressCubit.address,
                                      "pincode":
                                      createFarmerPermanentAddressCubit.pincode ??
                                          '',
                                      "addressType": "PERMANENT_ADDRESS"
                                    },
                                  ];

                                  context.read<AddAddressBloc>().add(
                                    AddAddress(
                                        bodyRequest: bodyRequest,
                                        isSameAddress: false),
                                  );
                                } else {
                                  final bodyRequest = [
                                    {
                                      "stateMasterId": createFarmerCurrentAddressCubit
                                          .stateMasterId,
                                      "districtMasterId":
                                      createFarmerCurrentAddressCubit
                                          .districtMasterId,
                                      "villageMasterId":
                                      createFarmerCurrentAddressCubit
                                          .villageMasterId,
                                      "address":
                                      createFarmerCurrentAddressCubit.address,
                                      "pincode":
                                      createFarmerCurrentAddressCubit.pincode ??
                                          '',
                                      "addressType": "CURRENT_ADDRESS"
                                    },
                                    {
                                      "stateMasterId":
                                      createFarmerPermanentAddressCubit
                                          .stateMasterId,
                                      "districtMasterId":
                                      createFarmerPermanentAddressCubit
                                          .districtMasterId,
                                      "villageMasterId":
                                      createFarmerPermanentAddressCubit
                                          .villageMasterId,
                                      "address":
                                      createFarmerPermanentAddressCubit.address,
                                      "pincode":
                                      createFarmerPermanentAddressCubit.pincode ??
                                          '',
                                      "addressType": "PERMANENT_ADDRESS"
                                    },
                                  ];
                                  context.read<AddAddressBloc>().add(
                                    AddAddress(
                                        bodyRequest: bodyRequest,
                                        isSameAddress: false),
                                  );
                                }
                              }
                            },
                            child:  CommonButton(buttonName: AppLocalizations.of(context)!.save),
                          );
                        },
                        listener: (BuildContext context, AddAddressState state) {
                          if (state is AddAddressSuccess) {
                            Navigator.pushNamed(context, FamilyScreen.routeName);
                          }
                        },
                      );
                    }
                    return CommonButton(buttonName: AppLocalizations.of(context)!.save,
                    buttonColor: AppColors.grayColor,
                    );
                  },

                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
