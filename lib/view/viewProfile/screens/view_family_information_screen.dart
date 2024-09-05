import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/view/family/widgets/family_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewFamilyInformationScreen extends StatefulWidget {
  static String routeName = "view-family-information-screen";
  const ViewFamilyInformationScreen({super.key});

  @override
  State<ViewFamilyInformationScreen> createState() =>
      _ViewFamilyInformationScreenState();
}

class _ViewFamilyInformationScreenState
    extends State<ViewFamilyInformationScreen> {
  bool isTrue = false;
  int farmerId = 0;

 @override
  void initState() {
    // TODO: implement initState
   context.read<GetFarmerFamilyDetailBloc>().add(GetFarmerFamilyDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getFarmerFamilyDetailsBloc = context
        .watch<GetFarmerFamilyDetailBloc>()
        .getFarmerFamilyDetailResponseModel;
    return getFarmerFamilyDetailsBloc.dataList != null
        ? Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: getFarmerFamilyDetailsBloc.dataList?.length,
              itemBuilder: (BuildContext context, int index) {
                return FamilyExpensionTile(
                  isView: false,
                  name: getFarmerFamilyDetailsBloc.dataList?[index].name ?? '',
                  age: getFarmerFamilyDetailsBloc.dataList?[index].age ?? '',
                  gender:
                      getFarmerFamilyDetailsBloc.dataList?[index].gender ?? '',
                  relation: getFarmerFamilyDetailsBloc
                          .dataList?[index].relationWithApplicant ??
                      '',
                  occupation:
                      getFarmerFamilyDetailsBloc.dataList?[index].occupation ??
                          '',
                  annualIncome: getFarmerFamilyDetailsBloc
                          .dataList?[index].annualIncome ??
                      '',
                );
              },
            ),
          )
        :  Expanded(
            child: Center(
              child: AppTextWidget(
                text: AppLocalizations.of(context)!.noData,
                fontSize: 20,
              ),
            ),
          );
  }
}
