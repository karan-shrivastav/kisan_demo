import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
 final double max;
 final double current;
 final Color color;

 const CustomProgressBar(
  {Key? key,
  required this.max,
  required this.current,
  this.color = AppColors.grayColor})
  : super(key: key);
  @override
  Widget build(BuildContext context) {
  return LayoutBuilder(
  builder: (_, boxConstraints) {
    var x = boxConstraints.maxWidth;
    var percent = (current / max) * x;
    return Stack(
      children: [
        Container(
          width: x,
          height: 7,
          decoration: BoxDecoration(
            color: Color(0xffd3d3d3),
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: percent,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ],
    );
  },
);
}
}