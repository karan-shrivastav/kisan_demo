import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CommonDescriptionTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final Color focusedBorderColor;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChange;
  final TextEditingController? controller;
  final bool enabled;
  const CommonDescriptionTextField(
      {super.key,
      required this.labelText,
      this.focusedBorderColor = AppColors.outLineColor,
      this.hintText,
      this.validator,
      this.onChange,
      this.controller,
      this.enabled = true});

  @override
  State<CommonDescriptionTextField> createState() =>
      _CommonDescriptionTextFieldState();
}

class _CommonDescriptionTextFieldState
    extends State<CommonDescriptionTextField> {
  bool _hasError = false;

  void _updateErrorState(String? value) {
    if (widget.validator != null) {
      setState(() {
        _hasError = widget.validator!(value) != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 50,
      maxLength: 50,
      enabled: widget.enabled,
      validator: widget.validator,
      onChanged: (value) {
        widget.onChange?.call(value);
        _updateErrorState(value);
        print(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: _hasError ? Colors.red : AppColors.textColorPrimary),
        labelStyle: TextStyle(
            color: _hasError ? Colors.red : AppColors.textColorPrimary),
        errorStyle: const TextStyle(color: Colors.red),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedBorderColor),
        ),
      ),
    );
  }
}
