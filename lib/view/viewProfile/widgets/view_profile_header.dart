import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef PersonalSelectedCallback = void Function(String selectvalue);

class ViewProfileHeader extends StatefulWidget {
  final PersonalSelectedCallback? onValueSelected;
  final List<ViewProfileModel> contentList;
  final EdgeInsetsGeometry? padding;

  const ViewProfileHeader({
    super.key,
    required this.contentList,
    this.padding,
    this.onValueSelected,
  });

  @override
  State<ViewProfileHeader> createState() => _ViewProfileHeaderState();
}

class _ViewProfileHeaderState extends State<ViewProfileHeader> {
  bool isSelect = false;
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
    isSelect = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < widget.contentList.length; i++)
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (widget.onValueSelected != null) {
                        widget.onValueSelected!(widget.contentList[i].name);
                      }
                      isSelect = true;
                      selectedIndex = i;
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelect && selectedIndex == i
                            ? AppColors.yellowBackGroundColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight:
                              (i == 0 || i == widget.contentList.length - 2)
                                  ? const Radius.circular(0)
                                  : const Radius.circular(22),
                          bottomRight:
                              (i == 0 || i == widget.contentList.length - 2)
                                  ? const Radius.circular(0)
                                  : const Radius.circular(22),
                          topLeft: (i > 0 || i == widget.contentList.length)
                              ? const Radius.circular(0)
                              : const Radius.circular(22),
                          bottomLeft: i > 0
                              ? const Radius.circular(0)
                              : const Radius.circular(22),
                        ),
                        border: Border.all(
                          width: 1,
                          color: AppColors.secondOutLineColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.contentList[i].icon,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AppTextWidget(
                            text: widget.contentList[i].name,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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

class ViewProfileModel {
  IconData icon;
  String name;
  ViewProfileModel({required this.icon, required this.name});
}
