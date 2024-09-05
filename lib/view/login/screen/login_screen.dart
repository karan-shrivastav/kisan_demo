import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/login/widget/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/login_section.dart';
import '../widget/next_button_widget.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.mainPageBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    LoginHeader(),
                    LoginSection(),
                  ],
                ),
              )),
              NextButtonWidget(
                formKey: _formKey,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
