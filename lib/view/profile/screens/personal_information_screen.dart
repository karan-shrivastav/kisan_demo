 import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/common_widget/common_text_field_widget.dart';
import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import 'package:ekisan_credit/cubit/model/create_farmer_userinfo_cubit_model.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:ekisan_credit/view/profile/screens/religion_information_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../common_widget/header.dart';
import '../widgets/profile_progress_header.dart';
import '../widgets/select_identity_proof.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalInformationScreen extends StatefulWidget {
  static String routeName = "personal-info";

  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
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
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    _dateOfBirthString.value = formattedDate;

    return formattedDate;
  }

  TextEditingController dateController = TextEditingController();

  String selectedValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubitState = context.read<CreateFarmerUserInfoCubit>().state;
    if (cubitState.dateOfBirth != null) {
      DateTime dateTime = DateTime.parse(cubitState.dateOfBirth ?? '');
      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      dateController.text = formattedDate;

      _isShow.value = false;
      _dateOfBirthString.value = formattedDate;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

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
                    pageNumber: 1,
                    percentageFirst: 66.66,
                    percentageSecond: 0,
                    percentageThird: 0,
                    pageName: AppLocalizations.of(context)!.profile,
                  ),
                ],
              ),

              /************* Personal Info **********************/
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
                                    suffixIcon: Icons.event,
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
                                                    padding: EdgeInsets.only(
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
                          height: 15,
                        ),
                        const SelectIdentityProofWidget(),
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
                child: BlocBuilder<CreateFarmerUserInfoCubit,CreateFarmerUserProfileInfoCubitModel>(
                  builder: (BuildContext context, CreateFarmerUserProfileInfoCubitModel state) {

                    if(state.dateOfBirth != null && state.dateOfBirth!.isNotEmpty && state.idProofNo != null && state.idProofNo!.isNotEmpty){
                      return InkWell(
                          onTap: () {

                            if (_dateOfBirthString.value.isEmpty) {
                              _isShow.value = true;
                            } else {
                              _isShow.value = false;
                            }

                            if (_formKey.currentState!.validate() &&
                                _dateOfBirthString.value.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, ReligionInformationScreen.routeName);
                            }
                          },
                          child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.next));
                    }

                    return CommonButton(
                      buttonColor: AppColors.grayColor,
                        buttonName: AppLocalizations.of(context)!.next);
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
