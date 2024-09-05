import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/generate_captcha.dart';
import 'package:flutter/material.dart';

class CaptchaWidget extends StatelessWidget {
  final TextEditingController captchaController;
  const CaptchaWidget({super.key, required this.captchaController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Container(
          width: 120,
          color: const Color(0xFFD7E8CD),
          height: 55,
          child: Center(
            child: AppTextWidget(text: GenerateCaptcha.generateRandomString(),
            fontWeight: FontWeight.bold,
              fontSize: 29,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
              onTap: (){

              },
              child: const Icon(Icons.refresh_outlined)),
        ),
      ],
    );
  }
}
