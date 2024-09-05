import 'package:flutter/material.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../utils/app_text_size.dart';
import '../../loan_request/screens/loan_purpose_screen.dart';
import 'header_widget.dart';

class LoanApplyHeaderWidget extends StatelessWidget {
  final String? headerName;
  final int? pageNumber;
  final double? percentageFirst;
  final double? percentageSecond;
  final double? percentageThird;
  final double? percentageFourth;
  const LoanApplyHeaderWidget({
    super.key,
    this.headerName,
    this.pageNumber,
    this.percentageFirst,
    this.percentageSecond,
    this.percentageThird,
    this.percentageFourth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 52,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: AppTextWidget(
                        text: headerName ?? '',
                        fontSize: AppTextSize.contentSize24,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Help icon
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LoanPurpose.routeName);
                },
                child: const Icon(Icons.help_outline_outlined)),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        HeaderWidget(
          pageNumber: pageNumber ?? 1,
          percentageFirst: percentageFirst,
          percentageSecond: percentageSecond,
          percentageThird: percentageThird,
          percentageFourth: percentageFourth,
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
