import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final Widget? content;
  const AppAlertDialog({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: content,
      backgroundColor: AppColors.whiteColor,
       shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
