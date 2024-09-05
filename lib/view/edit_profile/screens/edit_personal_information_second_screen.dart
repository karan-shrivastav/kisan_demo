import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../common_widget/header.dart';
import '../../../cubit/model/create_farmer_userinfo_cubit_model.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../widgets/select_identity_proof_edit_widget.dart';
import 'edit_personal_information_third_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPersonalInformationSecondScreen extends StatefulWidget {
  static String routeName = "edit-personal-information-second-screen";

  const EditPersonalInformationSecondScreen({super.key});

  @override
  State<EditPersonalInformationSecondScreen> createState() =>
      _EditPersonalInformationSecondScreenState();
}

class _EditPersonalInformationSecondScreenState
    extends State<EditPersonalInformationSecondScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<DateTime?> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime now = DateTime.now();

    // Calculate the maximum birth date (18 years ago from now)
    final DateTime maxBirthDate = DateTime(now.year - 18, now.month, now.day);

    // Calculate the minimum birth date (80 years ago from now)
    final DateTime minBirthDate = DateTime(now.year - 80, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxBirthDate,
      // Set the initial date to the maximum birth date
      firstDate: minBirthDate,
      // Set the first selectable date to the minimum birth date
      lastDate: maxBirthDate,
      // Set the last selectable date to the maximum birth date
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );

    return picked;
  }


  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year.toString().substring(2)}";
    setState(() {
      dateController = TextEditingController(text: formattedDate.toString());
      dateController.selection = TextSelection(
          baseOffset: formattedDate.length, extentOffset: formattedDate.length);
    });
    return formattedDate;
  }

  TextEditingController dateController = TextEditingController();
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

  String selectedValue = "";

  @override
  void initState() {
    final cubitState = context.read<CreateFarmerUserInfoCubit>().state;
    if (cubitState.dateOfBirth != null) {
      dateController.text = cubitState.dateOfBirth ?? '';
    }
    //context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(
        getFarmerResponseModel.data?.dateOfBirth.toString() ?? ''));

    final createFarmerCubit = context.read<CreateFarmerUserInfoCubit>();

    createFarmerCubit.updateModel(
      dateOfBirth: DateFormat('dd/MM/yyyy').format(DateTime.parse(
          getFarmerResponseModel.data?.dateOfBirth.toString() ?? '')),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 59,
          ),
          Column(
            children: [
              Header(
                pageNumber: 1,
                percentageFirst: 66.66,
                pageName: AppLocalizations.of(context)!.editProfile,
                percentageSecond: 0,
                percentageThird: 0,
              ),
            ],
          ),

          /************* Personal Info **********************/
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: AppTextWidget(
                          text: AppLocalizations.of(context)!
                              .personalInformation,
                          fontWeight: FontWeight.w400,
                          fontSize: AppTextSize.contentSize22,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context).then((value) {
                            if (value != null) {
                              DateTime dateTime =
                                  DateTime.parse(value.toString());
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              convertToDDMMYY(formattedDate);
                              // Output: 2006-04-29
                              context
                                  .read<CreateFarmerUserInfoCubit>()
                                  .updateModel(
                                    dateOfBirth: formattedDate,
                                  );
                            }
                          });
                        },
                        child: ValueListenableBuilder(
                          valueListenable: _dateOfBirthString,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            if (_dateOfBirthString.value.isNotEmpty) {
                              dateController = TextEditingController(
                                  text: _dateOfBirthString.value);
                              // Future.delayed(const Duration(seconds: 1),(){
                              //   _formKey.currentState?.validate();
                              // });
                            }

                            return Column(
                              children: [
                                CommonTextField(
                                  enabled: false,
                                  labelText: AppLocalizations.of(context)!
                                      .dateOfBirth,
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    if (kDebugMode) {
                                      print("000");
                                    }
                                    _selectDate(context).then((value) {
                                      if (kDebugMode) {}
                                      if (value != null) {
                                        convertToDDMMYY(value.toString());
                                        if (kDebugMode) {
                                          print("9890989");
                                        }
                                        if (kDebugMode) {
                                          print(convertToDDMMYY(
                                              value.toString()));
                                        }

                                        context
                                            .read<CreateFarmerUserInfoCubit>()
                                            .updateModel(
                                                dateOfBirth: convertToDDMMYY(
                                                    value.toString()));
                                      }
                                    });
                                  },
                                  vertical: 16,
                                  suffix: const Icon(Icons.event),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: _isShow,
                                    builder: (BuildContext context, value,
                                        Widget? child) {
                                      return _isShow.value &&
                                              _dateOfBirthString.value.isEmpty
                                          ? Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 13),
                                                  child: AppTextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .pleaseSelectDate,
                                                    textColor:
                                                        AppColors.errorColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox();
                                    })
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const SelectIdentityProofEditWidget(),
                      const SizedBox(
                        height: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<CreateFarmerUserInfoCubit,
                CreateFarmerUserProfileInfoCubitModel>(
              builder: (BuildContext context,
                  CreateFarmerUserProfileInfoCubitModel state) {
                if (state.dateOfBirth != null &&
                    state.selectedProofOfIdentityString != null &&
                    state.selectedProofOfIdentityString != "" &&
                    state.idProofNo != "" &&
                    state.proofOfIdentityId != null &&
                    state.proofOfIdentityId != "") {
                  return InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context,
                            EditPersonalInformationThirdScreen.routeName);
                      }
                    },
                    child: CommonButton(
                      buttonName: AppLocalizations.of(context)!.next,
                    ),
                  );
                }
                return CommonButton(
                  buttonName: AppLocalizations.of(context)!.next,
                  buttonColor: AppColors.grayColor,
                );
              },
              listener: (BuildContext context,
                  CreateFarmerUserProfileInfoCubitModel state) {},
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
