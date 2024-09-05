import 'package:flutter/material.dart';
import '../view/profile/widgets/profile_progress_header.dart';
import 'app_text_widget.dart';

class Header extends StatelessWidget {
  final String pageName;
  final int pageNumber;
  final double percentageFirst;
  final double percentageSecond;
  final double percentageThird;
  const Header({super.key, required this.pageNumber,required this.percentageFirst,required this.percentageSecond, required this.percentageThird, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
             AppTextWidget(
              text: pageName,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Center(
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
       
         ProfileProgressHeader(
          pageNumber: pageNumber,
          percentageFirst: percentageFirst,
          percentageSecond: percentageSecond,
          percentageThird: percentageThird,
        
        ),
      ],
    );
  }
}

