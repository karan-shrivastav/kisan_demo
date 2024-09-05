import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import 'package:ekisan_credit/cubit/model/create_farmer_current_address_cubit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/profile/screens/peramanent_address_information_screen.dart';
import 'package:ekisan_credit/view/profile/screens/same_current_permanent_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../utils/app_text_size.dart';
import '../widgets/current_address_information_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressInformationScreen extends StatefulWidget {
  static String routeName = "address-information";

  const AddressInformationScreen({super.key});

  @override
  State<AddressInformationScreen> createState() =>
      _AddressInformationScreenState();
}

class _AddressInformationScreenState extends State<AddressInformationScreen> {
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

  final ValueNotifier<bool> _isCurrentAsPermanent = ValueNotifier<bool>(false);

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
                    percentageSecond: 50,
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
                        const CurrentAddressInformationWidget(),
                        const SizedBox(
                          height: 26,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: AppTextWidget(
                                text:
                                    'Is your permanent Address is same as current?',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _isCurrentAsPermanent,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return Switch(
                                  thumbIcon: thumbIcon,
                                  value: _isCurrentAsPermanent.value,
                                  onChanged: (bool value) {
                                    _isCurrentAsPermanent.value = value;
                                    context
                                        .read<CreateFarmerCurrentAddressCubit>()
                                        .updateModel(isAddressSame: value);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<CreateFarmerCurrentAddressCubit,CreateFarmerCurrentAddressCubitModel>(builder: (BuildContext context, CreateFarmerCurrentAddressCubitModel state) {
                  if(state.address!= null && state.address!.isNotEmpty && state.selectedDistrictString != null && state.selectedDistrictString!.isNotEmpty && state.selectedVillageString != null && state.selectedVillageString!.isNotEmpty && state.pincode != null && state.pincode!.isNotEmpty){
                    return ValueListenableBuilder(
                      valueListenable: _isCurrentAsPermanent,
                      builder: (BuildContext context, value, Widget? child) {
                        return InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (_isCurrentAsPermanent.value) {
                                Navigator.pushNamed(context,
                                    SameCurrentPermanentAddressScreen.routeName);
                              } else {
                                Navigator.pushNamed(context,
                                    PermanentAddressInformationScreen.routeName);
                              }
                            }
                          },
                          child: const CommonButton(buttonName: "Save"),
                        );
                      },
                    );
                  }
                  return const CommonButton(buttonName: "Save",
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
