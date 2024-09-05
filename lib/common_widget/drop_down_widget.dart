import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DropDownWidget extends StatelessWidget {
  final Function(String?) onChange;
  final VoidCallback? onTap;
  final String hintText;
  final String selectedValue;
  final List<DropdownMenuItem<String>> dropdownItems;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;

  const DropDownWidget({
    super.key,
    required this.onChange,
    required this.selectedValue,
    required this.dropdownItems,
    required this.hintText,
    required this.onTap,
    this.hintFontWeight,
    this.hintFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: const TextStyle(fontSize: 12, color: Colors.black),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondOutLineColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondOutLineColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColors.secondOutLineColor, width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      dropdownColor: Colors.white,
      value: selectedValue.isNotEmpty ? selectedValue : null,
      onChanged: onChange,
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: hintFontSize,
          fontWeight: hintFontWeight,
        ),
      ),
      items: dropdownItems,
      onTap: onTap,
    );
  }
}
