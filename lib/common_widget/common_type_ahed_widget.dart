import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../utils/app_colors.dart';

class CommonTypeAheadField<T> extends StatefulWidget {
  final List<T> suggestions;
  final String Function(T) suggestionToString;
  final void Function(T) onSelected;
  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final bool showIcon;
  final int? length;

  const CommonTypeAheadField(
      {super.key,
      required this.suggestions,
      required this.suggestionToString,
      required this.onSelected,
      required this.controller,
      required this.labelText,
      this.validator,
      this.hintText,
      this.length,
      this.showIcon = true});

  @override
  State<CommonTypeAheadField<T>> createState() =>
      _CommonTypeAheadFieldState<T>();
}

class _CommonTypeAheadFieldState<T> extends State<CommonTypeAheadField<T>> {
  List<T> getSuggestions(String query) {
    return widget.suggestions.where(
      (item) {
        final itemString = widget.suggestionToString(item).toLowerCase();
        return itemString.contains(query.toLowerCase());
      },
    ).toList();
  }

  String textValue = "";

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      controller: widget.controller,
      suggestionsCallback: (pattern) => getSuggestions(pattern),
      builder: (context, controller, focusNode) {
        return TextFormField(
          validator: widget.validator,
          controller: controller,
          focusNode: focusNode,
          maxLength: widget.length,
          onChanged: (value) {
            setState(() {
              textValue = value;
            });
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            suffixIcon: widget.showIcon
                ? const Icon(Icons.arrow_drop_down)
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    child: IntrinsicWidth(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.backGroundGreenColor,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0), // Adjust for spacing
                              child: Center(
                                child: AppTextWidget(
                                  text: " $textValue Acre",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.outLineColor),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: const TextStyle(color: AppColors.outLineColor),
            counterText: '',
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(widget.suggestionToString(suggestion)),
        );
      },
      onSelected: widget.onSelected,
    );
  }
}
