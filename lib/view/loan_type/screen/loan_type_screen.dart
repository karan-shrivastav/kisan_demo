import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/utils/app_text_size.dart';
import 'package:ekisan_credit/view/home/screens/home_screen.dart';
import 'package:ekisan_credit/view/loan_apply/screen/crop_loan_form_bank_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_bloc.dart';
import '../../../bloc/get_joint_applicant/get_joint_applicant_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanTypeScreen extends StatefulWidget {
  static const routeName = "loan-type-screen";

  const LoanTypeScreen({super.key});

  @override
  State<LoanTypeScreen> createState() => _LoanTypeScreenState();
}

class _LoanTypeScreenState extends State<LoanTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 52,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                         AppTextWidget(
                          text: AppLocalizations.of(context)!.selectLoanType,
                          fontSize: AppTextSize.contentSize22,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        context
                            .read<GetJointApplicantBloc>()
                            .add(GetJointApplicantList(body: const {"search": ""}));
                        Navigator.pushNamed(
                            context, HomeScreen.routeName);
                      },
                        child: const Icon(Icons.help_outline_outlined))
                  ],
                ),
              ),
              SizedBox(
                height: 72,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(60)),
                  ),
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppTextWidget(
                      text: "KCC - CROP",
                      fontSize: AppTextSize.contentSize36,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    // Add spacing between the two text widgets
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: AppTextWidget(
                        text:
                            "Korem ipsum dolor sit amet, consectetur adipiscing elit hufvgf gg.",
                        fontWeight: FontWeight.w400,
                        fontSize: AppTextSize.contentSize16,
                        textColor: AppColors.primary,
                        textAlign:
                            TextAlign.center, // Center the text horizontally
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.yellowBackGroundColor),
                          child: Center(
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, CropLoanFormBankDetail.routeName);
                        },
                        child: CommonButton(
                          buttonName: AppLocalizations.of(context)!.select,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
