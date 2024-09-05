import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatefulWidget {
  final String labelText;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final IconData? suffixIcon;
  final Color focusedBorderColor;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? prefix;
  final Widget? suffix;
  final int? length;
  final double? vertical;
  final double? horizontal;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final bool showPrefixIcon;
  final Function(String)? onChange;
  final bool enabled;
  final VoidCallback? onEditingCompleted;
  final List<TextInputFormatter>? inputFormatters; // Added this line

  const CommonTextField({
    super.key,
    required this.labelText,
    this.prefix,
    this.prefixIcon,
    this.prefixIconColor = Colors.green,
    this.focusedBorderColor = AppColors.outLineColor,
    this.controller,
    this.validator,
    this.suffix,
    this.suffixIcon,
    this.length,
    this.vertical,
    this.horizontal,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.hintText,
    this.contentPadding,
    this.showPrefixIcon = false,
    this.onChange,
    this.enabled = true,
    this.onEditingCompleted,
    this.inputFormatters, // Added this line
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
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
      validator: widget.validator,
      enabled: widget.enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        widget.onChange?.call(value);
        _updateErrorState(value);
      },
      keyboardType: widget.keyboardType,
      maxLength: widget.length,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingCompleted,
      inputFormatters: widget.inputFormatters, // Added this line
      decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefix: widget.prefix,
          suffix: widget.suffix,
          counterText: '',
          errorMaxLines: 3,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                  vertical: widget.vertical ?? 20.0,
                  horizontal: widget.horizontal ?? 12.0),
          // Adjust the padding here
          suffixIcon: widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                )
              : null,
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
          //labelStyle: TextStyle(color: focusedBorderColor),
          prefixIcon: widget.showPrefixIcon ? Icon(widget.prefixIcon) : null),
    );
  }
}
