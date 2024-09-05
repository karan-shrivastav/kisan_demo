import 'package:ekisan_credit/bloc/otp/send_otp_bloc.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_state.dart';
import 'package:ekisan_credit/bloc/show_otp/show_otp_bloc.dart';
import 'package:ekisan_credit/bloc/show_otp/show_otp_event.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/utils/form_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/otp/send_otp_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/login/farmer_login_cubit.dart';
import '../../../cubit/model/farmer_info_model_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import '../../../utils/generate_captcha.dart';
import '../../../utils/screen_argument.dart';
import '../../verify_otp/screens/verify_otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterSection extends StatefulWidget {
  const RegisterSection({super.key});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  late final TextEditingController myController;
  late String fieldName;
  late final IconData myIcon;
  late Color prefixIconColor;

  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _captchaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<FarmerInfoCubit>().updateModel(fromScreen: "register");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  final ValueNotifier<String> _captchaValue =
      ValueNotifier<String>(GenerateCaptcha.generateRandomString());
  final ValueNotifier<String> mobileNumber = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    final farmerInfoCubit = context.read<FarmerInfoCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          AppTextWidget(
            text: AppLocalizations.of(context)!.register,
            fontSize: AppTextSize.header,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  labelText: AppLocalizations.of(context)!.mobileNumber,
                  controller: _mobileNumberController,
                  vertical: 15,
                  keyboardType: TextInputType.phone,
                  suffixIcon: Icons.dialpad_sharp,
                  length: 10,
                  validator: (value) =>
                      AppFormValidation.validateMobile(context, value),
                  prefix: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: AppTextWidget(
                      text: "+91",
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.textBlackColor,
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    mobileNumber.value = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              AppTextWidget(
                text: AppLocalizations.of(context)!.useThisNumberToLogin,
                textColor: AppColors.textColorPrimary,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.10,
              ),

            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ValueListenableBuilder(
            valueListenable: _captchaValue,
            builder: (BuildContext context, String value, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: const Color(0xFFD7E8CD),
                      height: 55,
                      child: Center(
                        child: AppTextWidget(
                          text: _captchaValue.value,
                          fontWeight: FontWeight.bold,
                          fontSize: 29,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                          onTap: () {
                            _captchaValue.value =
                                GenerateCaptcha.generateRandomString();
                          },
                          child: const Icon(Icons.refresh_outlined)),
                    ),
                  ),
                  Expanded(
                    child: CommonTextField(
                      controller: _captchaController,
                      validator: (enteredCaptcha) =>
                          AppFormValidation.validateCaptcha(
                              captchaValue: _captchaValue.value,
                              enteredCaptcha: enteredCaptcha,
                              context: context),
                      onChange: (value) {
                        farmerInfoCubit.updateModel(captcha: value);
                      },
                      labelText: AppLocalizations.of(context)!.enterCaptcha,
                      vertical: 16,
                      horizontal: 16,
                    ),
                  )
                ],
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<FarmerInfoCubit, FarmerInfoModelCubit>(
            builder: (BuildContext context, farmerInfoData) {
              return ValueListenableBuilder(
                valueListenable: mobileNumber,
                builder: (BuildContext context, String mobileNumberValue,
                    Widget? child) {
                  return mobileNumberValue.isNotEmpty &&
                          farmerInfoData.captcha != null &&
                          farmerInfoData.captcha!.isNotEmpty
                      ? BlocConsumer<SendOtpBloc, SendOtpState>(
                          builder: (BuildContext context, SendOtpState state) {
                            if (state is GetOtpNewLoading) {
                              return const CommonButton(
                                buttonName: "Loading...",
                                buttonColor: AppColors.grayColor,
                              );
                            }
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    final bodyRequest = {
                                      "authType": "CREATE_FARMER",
                                      "otpType": "mobile",
                                      "mobileNo": _mobileNumberController.text
                                    };

                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, proceed with submission
                                      // You can add your logic here

                                      context.read<SendOtpBloc>().add(
                                          GetNewOtp(bodyRequest: bodyRequest));
                                    }
                                  },
                                  child: CommonButton(
                                    buttonName:
                                        AppLocalizations.of(context)!.next,
                                  ),
                                ),
                              ],
                            );
                          },
                          listener: (BuildContext context, SendOtpState state) {
                            if (state is GetOtpNewSuccess) {
                              final bodyRequest = {
                                "mobileNo": _mobileNumberController.text
                              };
                              context
                                  .read<ShowOtpBloc>()
                                  .add(ShowOtp(bodyRequest: bodyRequest));

                              Navigator.pushNamed(
                                context,
                                VerifyOtpScreen.routeName,
                                arguments: ScreenArguments(
                                    screenName: "Register",
                                    mobileNumber: _mobileNumberController.text),
                              );
                            }
                          },
                        )
                      : CommonButton(
                          buttonName: AppLocalizations.of(context)!.next,
                          buttonColor: AppColors.grayColor,
                        );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
