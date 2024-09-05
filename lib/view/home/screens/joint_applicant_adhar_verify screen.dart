import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_bloc.dart';
import 'package:ekisan_credit/bloc/add_joint_applicant/add_joint_applicant_event.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import '../../../bloc/add_joint_applicant/add_joint_applicant_state.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../bloc/otp/send_otp_bloc.dart';
import '../../../bloc/otp/send_otp_event.dart';
import '../../../bloc/relationships/relationship_bloc.dart';
import '../../../bloc/relationships/relationship_data_event.dart';
import '../../../bloc/relationships/relationship_data_state.dart';
import '../../../bloc/send_adhar_otp/send_otp_adhar_bloc.dart';
import '../../../bloc/send_adhar_otp/send_otp_adhar_state.dart';
import '../../../bloc/timer/timer_bloc.dart';
import '../../../common_button.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/joint_applicant/joint_applicant_cubit.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../model/response/relationship_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../../utils/form_validation.dart';
import '../../../utils/screen_argument.dart';
import '../../../utils/shared_preference_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JointApplicantAadharVerifyScreen extends StatefulWidget {
  static String routeName = "joint-applicant-aadhar-verify-screen";
  const JointApplicantAadharVerifyScreen({super.key});

  @override
  State<JointApplicantAadharVerifyScreen> createState() =>
      _JointApplicantAadharVerifyScreenState();
}

class _JointApplicantAadharVerifyScreenState
    extends State<JointApplicantAadharVerifyScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController idProofNumberController = TextEditingController();
  final TextEditingController _proofIdNumberTextEditingController =
      TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");
  final ValueNotifier<String> _dateOfBirthString = ValueNotifier<String>("");
  final ValueNotifier<bool> _isShow = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();
  String convertToDDMMYY(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year.toString().substring(2)}";
    setState(() {
      dateController = TextEditingController(text: formattedDate.toString());
      _formKey.currentState?.validate();
      dateController.selection = TextSelection(
          baseOffset: formattedDate.length, extentOffset: formattedDate.length);
    });
    return formattedDate;
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime now = DateTime.now();
    final DateTime maxBirthDate = DateTime(now.year - 18, now.month, now.day);
    final DateTime minBirthDate = DateTime(now.year - 80, now.month, now.day);
    final _formKey = GlobalKey<FormState>();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxBirthDate,
      firstDate: minBirthDate,
      lastDate: maxBirthDate,
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );

    return picked;
  }

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  List<String> getSuggestionsRelationship(
      String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  Future<String?> getFarmerId() async {
    AppSharedPreferenceHelper appSharedPreferenceHelper =
        AppSharedPreferenceHelper();
    return appSharedPreferenceHelper.getCustomerData('farmerId');
  }

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final ValueNotifier<String> _isCompleted = ValueNotifier<String>("");

  bool isCheck = false;

  @override
  void initState() {
    final lovsTypeData = [
      "GENDER",
      "IDPROOF",
    ];

    context.read<GetLovsTypeDataNewBloc>().add(
          GetLovsTypeDataNewList(
            bodyRequest: lovsTypeData,
          ),
        );
    super.initState();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = AppColors.secondOutLineColor;
    const focusedBorderColor = AppColors.secondOutLineColor;
    const fillColor = Colors.transparent;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: AppTextSize.contentSize16,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: AppColors.textBlackColor,
                  ),
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.delete,
                      size: 24,
                      color: AppColors.textBlackColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.account_circle_outlined,
                      size: 24,
                      color: AppColors.greenColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      text: AppLocalizations.of(context)!.add,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    CommonTextField(
                      labelText: AppLocalizations.of(context)!.aadharNumber,
                      vertical: 15,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          AppFormValidation.validateAadhar(context, value),
                      suffix: const ImageIcon(
                          AssetImage("assets/images/adhar.png")),
                      length: 12,
                      onChange: (value) {},
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     AppTextWidget(
                    //       text: AppLocalizations.of(context)!.enterOtp,
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //     BlocBuilder<TimerBloc, TimerState>(
                    //       builder: (BuildContext context, TimerState state) {
                    //         if (state is TimerRunComplete) {
                    //           return InkWell(
                    //             onTap: () {},
                    //             child: AppTextWidget(
                    //               text: AppLocalizations.of(context)!.resendOtp,
                    //               fontSize: AppTextSize.contentSize14,
                    //               fontWeight: FontWeight.w500,
                    //               textColor: AppColors.primary,
                    //             ),
                    //           );
                    //         }
                    //         return Row(
                    //           children: [
                    //             AppTextWidget(
                    //               text:
                    //                   "${AppLocalizations.of(context)!.resendOtpIn} ",
                    //               fontSize: AppTextSize.contentSize14,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //             AppTextWidget(
                    //               text: formatTime(context.select(
                    //                   (TimerBloc bloc) => bloc.state.duration)),
                    //               fontSize: AppTextSize.contentSize14,
                    //               fontWeight: FontWeight.w500,
                    //               textColor: AppColors.primary,
                    //             )
                    //           ],
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 24,
                    // ),
                    // Pinput(
                    //   length: 6,
                    //   controller: pinController,
                    //   focusNode: focusNode,
                    //   androidSmsAutofillMethod:
                    //       AndroidSmsAutofillMethod.smsUserConsentApi,
                    //   listenForMultipleSmsOnAndroid: true,
                    //   defaultPinTheme: defaultPinTheme,
                    //   separatorBuilder: (index) => const SizedBox(width: 8),
                    //   validator: (value) {
                    //     return '';
                    //   },
                    //   // onClipboardFound: (value) {
                    //   //   debugPrint('onClipboardFound: $value');
                    //   //   pinController.setText(value);
                    //   // },
                    //
                    //   hapticFeedbackType: HapticFeedbackType.lightImpact,
                    //   onCompleted: (pin) {
                    //     // Navigator.pushNamed(context, DashboardScreen.routeName);
                    //     debugPrint('onCompleted: $pin');
                    //   },
                    //   onChanged: (value) {
                    //     // debugPrint('onChanged: $value');
                    //     // setState(() {
                    //     //
                    //     // });
                    //
                    //     _isCompleted.value = value;
                    //   },
                    //   cursor: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Container(
                    //         margin: const EdgeInsets.only(bottom: 9),
                    //         width: 22,
                    //         height: 1,
                    //         color: focusedBorderColor,
                    //       ),
                    //     ],
                    //   ),
                    //   focusedPinTheme: defaultPinTheme.copyWith(
                    //     decoration: defaultPinTheme.decoration!.copyWith(
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: focusedBorderColor),
                    //     ),
                    //   ),
                    //   submittedPinTheme: defaultPinTheme.copyWith(
                    //     decoration: defaultPinTheme.decoration!.copyWith(
                    //       color: fillColor,
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: focusedBorderColor),
                    //     ),
                    //   ),
                    //   // errorPinTheme: defaultPinTheme.copyBorderWith(
                    //   //   border: Border.all(color: Colors.redAccent),
                    //   // ),
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.greenColor,
                          value: isCheck,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheck = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: AppTextWidget(
                            text: AppLocalizations.of(context)!
                                .byClickingHereAcknowledgeThatIHaveRead,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: AppTextWidget(
                            text: AppLocalizations.of(context)!
                                .enterAadharNoOfUserMustBeAge,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CommonButton(
                      buttonTextColor: Colors.black,
                      buttonName: AppLocalizations.of(context)!.cancel,
                      borderColor: AppColors.secondOutLineColor,
                      buttonColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocConsumer<SendOTPAadharBloc,
                      SendOTPAdharState>(
                    builder:
                        (BuildContext context, SendOTPAdharState state) {
                      return InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {


                          // if (_formKey.currentState!.validate()) {
                          //   final jointInfoCubit =
                          //       context.read<JointApplicantInfoCubit>();
                          //   Map<String, dynamic> jointApplicant = {
                          //     "farmerId": await getFarmerId(),
                          //     "joinApplicantName": jointInfoCubit.state.name,
                          //     "dateOfBirth": jointInfoCubit.state.dateOfBirth,
                          //     "genderId": jointInfoCubit.state.genderId,
                          //     "idNumber": jointInfoCubit.state.idProofNumber,
                          //     "relationId": jointInfoCubit.state.relationId,
                          //     "idProodId": jointInfoCubit.state.idProofId,
                          //   };
                          //   if (kDebugMode) {
                          //     print("jointApplicant :$jointApplicant");
                          //   }
                          //   context.read<AddJointApplicantBloc>().add(
                          //       AddJointApplicantDetails(body: jointApplicant));
                          // }
                        },
                        child: CommonButton(
                          buttonName: AppLocalizations.of(context)!.sendOTP,
                        ),
                      );
                    },
                    listener:
                        (BuildContext context, SendOTPAdharState state) {
                      if (state is SendOTPAdharSuccess) {
                        // context.read<GetJointApplicantBloc>().add(
                        //     GetJointApplicantList(body: const {"search": ""}));
                        // Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
