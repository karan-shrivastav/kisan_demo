import 'package:ekisan_credit/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/header.dart';
import '../../../cubit/create_farmeruserinfo/create_farmer_current_address_cubit.dart';
import '../../../cubit/model/create_farmer_current_address_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../widgets/current_address_information_edit_widget.dart';
import 'edit_contact_information_second_screen.dart';
import 'edit_same_current_permanent_address_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditContactInformationFirstScreen extends StatefulWidget {
  static String routeName = "edit-contact-information-first-screen";
  const EditContactInformationFirstScreen({super.key});

  @override
  State<EditContactInformationFirstScreen> createState() =>
      _EditContactInformationFirstScreenState();
}

class _EditContactInformationFirstScreenState
    extends State<EditContactInformationFirstScreen> {
  final ValueNotifier<bool> _isCurrentAsPermanent = ValueNotifier<bool>(false);
  bool light0 = true;
  bool isEnable = false;
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
  void didChangeDependencies() {
    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    addressList = getFarmerResponseModel.data?.addressDtos;
    _isCurrentAsPermanent.value =
        getFarmerResponseModel.data?.bothAddressSame ?? false;
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  percentageSecond: 50,
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
                      const CurrentAddressInformationEditWidget(),
                      const SizedBox(
                        height: 26,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextWidget(
                              text: AppLocalizations.of(context)!
                                  .isYourPermanentAddressIsSameAsCurrent,
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
              child: BlocConsumer<CreateFarmerCurrentAddressCubit,
                  CreateFarmerCurrentAddressCubitModel>(
                builder: (BuildContext context,
                    CreateFarmerCurrentAddressCubitModel state) {
                  if (state.address != "" &&
                      state.pincode != "" &&
                      state.selectedStateString != "" &&
                      state.selectedVillageString != "" &&
                      state.selectedDistrictString != "") {
                    return ValueListenableBuilder(
                      valueListenable: _isCurrentAsPermanent,
                      builder: (BuildContext context, value, Widget? child) {
                        return InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (_isCurrentAsPermanent.value) {
                                Navigator.pushNamed(
                                    context,
                                    EditSameCurrentPermanentAddressScreen
                                        .routeName);
                              } else {
                                Navigator.pushNamed(
                                    context,
                                    EditContactInformationSecondScreen
                                        .routeName);
                              }
                            }
                          },
                          child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.next),
                        );
                      },
                    );
                  }
                  return CommonButton(
                    buttonName: AppLocalizations.of(context)!.next,
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
