import 'package:flutter/material.dart';
import '../../../common_button.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_type_ahed_widget.dart';
import '../../../common_widget/two_and_three_diveded_headers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_size.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditCropScreen extends StatefulWidget {
  const EditCropScreen({super.key});

  @override
  State<EditCropScreen> createState() => _EditCropScreenState();
}

class _EditCropScreenState extends State<EditCropScreen> {
  final TextEditingController _croppingSeasonTextEditingController =
      TextEditingController();
  final TextEditingController _cropNameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.secondOutLineColor,
                  borderRadius: BorderRadius.circular(100)),
            ),
            const SizedBox(
              height: 28,
            ),
            AppTextWidget(
              text: AppLocalizations.of(context)!.editCrop,
              fontWeight: FontWeight.w400,
              fontSize: AppTextSize.contentSize22,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TwoAndThreeDividedHeaders(
                    horizontalPadding: 0,
                    heightBetweenContentAndTitle: 12,
                    title: AppLocalizations.of(context)!.selectLandType,
                    contentList: ["Irrigated", "Un-Irrigated"],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  /********* Cropping Season **************/
                  CommonTypeAheadField<String>(
                    suggestions: ["oo", "000"],
                    suggestionToString: (district) => district,
                    onSelected: (selectedDistrict) {
                      print(selectedDistrict);
                      _croppingSeasonTextEditingController.text =
                          selectedDistrict;
                      // Handle the selected district logic here
                    },
                    controller: _croppingSeasonTextEditingController,
                    labelText: AppLocalizations.of(context)!.croppingSeason,
                    hintText:
                        AppLocalizations.of(context)!.someSeasonNameWithRange,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CommonTypeAheadField<String>(
                    suggestions: [""],
                    suggestionToString: (district) => district,
                    onSelected: (selectedDistrict) {
                      print(selectedDistrict);
                      _cropNameTextEditingController.text = selectedDistrict;
                      // Handle the selected district logic here
                    },
                    controller: _cropNameTextEditingController,
                    labelText: AppLocalizations.of(context)!.crop,
                    hintText: AppLocalizations.of(context)!.someLongCropName,
                  ),
                  /********* Area Unit **********/
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 60,
                    child: CommonTypeAheadField<String>(
                      suggestions: const [""],
                      showIcon: false,
                      length: 15,
                      suggestionToString: (district) => district,
                      onSelected: (selectedDistrict) {
                        print(selectedDistrict);
                        _cropNameTextEditingController.text = selectedDistrict;
                        // Handle the selected district logic here
                      },
                      controller: _cropNameTextEditingController,
                      labelText: AppLocalizations.of(context)!.areaUnit,
                      hintText: AppLocalizations.of(context)!.someAreaUnit,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            buttonName: AppLocalizations.of(context)!.cancel,
                            borderColor: AppColors.greenColor,
                            buttonColor: Colors.transparent,
                            buttonTextColor: AppColors.greenColor,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CommonButton(
                            buttonName: AppLocalizations.of(context)!.save,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
