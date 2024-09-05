import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 76,
        ),
        Image.asset("assets/images/logos.png"),

      ],
    );
  }
}
