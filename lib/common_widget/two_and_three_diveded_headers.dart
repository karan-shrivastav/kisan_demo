import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Define the callback function signature
typedef GenderSelectedCallback = void Function(String selectvalue);

class TwoAndThreeDividedHeaders extends StatefulWidget {
  final List<dynamic> contentList;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final GenderSelectedCallback? onValueSelected;
  final String? savedSelectedValue; // New parameter
  final bool? showError;
  final double? horizontalPadding;
  final double? heightBetweenContentAndTitle;
  final bool? isSelect;
  const TwoAndThreeDividedHeaders(
      {super.key,
      required this.contentList,
      this.title,
      this.padding,
      this.onValueSelected,
      this.savedSelectedValue,
      this.showError,
      this.horizontalPadding,
      this.heightBetweenContentAndTitle,
      this.isSelect = true});

  @override
  State<TwoAndThreeDividedHeaders> createState() =>
      _TwoAndThreeDividedHeadersState();
}

class _TwoAndThreeDividedHeadersState extends State<TwoAndThreeDividedHeaders> {
  bool isSelect = false;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    selectedIndex = widget.savedSelectedValue != null
        ? widget.contentList.indexOf(widget.savedSelectedValue!)
        : -1;
    if (selectedIndex != -1) {
      isSelect = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 16),
      child: Column(
        children: [
          Row(
            children: [
              AppTextWidget(
                text: widget.title ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
          SizedBox(
            height: widget.heightBetweenContentAndTitle ?? 24,
          ),
          Row(
            children: [
              for (int i = 0; i < widget.contentList.length; i++)
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (widget.isSelect != null && widget.isSelect == true) {
                        if (widget.onValueSelected != null) {
                          widget.onValueSelected!(widget.contentList[i]);
                        }
                        isSelect = true;
                        selectedIndex = i;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelect && selectedIndex == i
                            ? const Color(0xFFD7E8CD)
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight:
                              (i == 0 || i == widget.contentList.length - 2)
                                  ? const Radius.circular(0)
                                  : const Radius.circular(45),
                          bottomRight:
                              (i == 0 || i == widget.contentList.length - 2)
                                  ? const Radius.circular(0)
                                  : const Radius.circular(45),
                          topLeft: (i > 0 || i == widget.contentList.length)
                              ? const Radius.circular(0)
                              : const Radius.circular(45),
                          bottomLeft: i > 0
                              ? const Radius.circular(0)
                              : const Radius.circular(45),
                        ),
                        border: Border.all(
                          width: 1,
                          color: widget.showError != null &&
                                  widget.showError == true
                              ? Colors.red
                              : AppColors.secondOutLineColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedIndex == i
                              ? const Expanded(
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: selectedIndex == i ? 30 : 0,
                                  left: selectedIndex == i ? 0 : 10),
                              child: AppTextWidget(
                                  text: widget.contentList[i],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  textColor: (widget.showError != null &&
                                          widget.showError == true)
                                      ? Colors.red
                                      : AppColors.textBlackColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
