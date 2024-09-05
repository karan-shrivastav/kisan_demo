import 'package:ekisan_credit/bloc/otp/send_otp_bloc.dart';
import 'package:ekisan_credit/bloc/otp/send_otp_state.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/cubit/login/farmer_login_cubit.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/verify_otp/screens/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/otp/send_otp_event.dart';
import '../../../bloc/show_otp/show_otp_bloc.dart';
import '../../../bloc/show_otp/show_otp_event.dart';
import '../../../utils/screen_argument.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextButtonWidget extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  const NextButtonWidget({super.key, this.formKey});

  @override
  State<NextButtonWidget> createState() => _NextButtonWidgetState();
}

class _NextButtonWidgetState extends State<NextButtonWidget> {
  @override
  void initState() {
  //  TODO: implement initState
    context.read<SendOtpBloc>().stream.listen((state) {
      if (state is GetOtpNewSuccess) {
      if(mounted){
        context.read<GetFarmerFamilyDetailBloc>().add(ClearGetFamilyDetails());
        final farmerInfoCubit = context.read<FarmerInfoCubit>().state;
        final bodyRequest = {"mobileNo": farmerInfoCubit.mobileNumber};
        context.read<ShowOtpBloc>().add(ShowOtp(bodyRequest: bodyRequest));
        if(farmerInfoCubit.fromScreen == "login"){
          Navigator.pushNamed(
            context,
            VerifyOtpScreen.routeName,
            arguments: ScreenArguments(
                screenName: AppLocalizations.of(context)!.login,
                mobileNumber: farmerInfoCubit.mobileNumber ?? ''),
          );
        }
      }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final farmerInfoCubit = context.watch<FarmerInfoCubit>().state;
    return BlocConsumer<SendOtpBloc, SendOtpState>(
      builder: (BuildContext context, SendOtpState state) {
        if (state is GetOtpNewLoading) {
          return const CommonButton(
            buttonName: "Loading...",
            buttonColor: AppColors.grayColor,
          );
        }
        return Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            if (farmerInfoCubit.mobileNumber != null &&
                farmerInfoCubit.mobileNumber!.length > 9 &&
                farmerInfoCubit.captcha != null &&
                farmerInfoCubit.captcha!.isNotEmpty)
              InkWell(
                onTap: () {
                  final bodyRequest = {
                    "authType": "AUTHENTICATE",
                    "otpType": "mobile",
                    "mobileNo": farmerInfoCubit.mobileNumber
                  };
                  if (widget.formKey!.currentState!.validate()) {
                    context.read<FarmerInfoCubit>().updateModel(
                        fromScreen: "login"
                    );
                    context
                        .read<SendOtpBloc>()
                        .add(GetNewOtp(bodyRequest: bodyRequest));
                  }
                },
                child:  CommonButton(
                  buttonName: AppLocalizations.of(context)!.next,
                ),
              )
            else
              InkWell(
                onTap: () {},
                child:  CommonButton(
                  buttonName: AppLocalizations.of(context)!.next,
                  buttonColor: AppColors.grayColor,
                ),
              )
          ],
        );
      },
      listener: (BuildContext context, SendOtpState state) {

      },
    );
  }
}
