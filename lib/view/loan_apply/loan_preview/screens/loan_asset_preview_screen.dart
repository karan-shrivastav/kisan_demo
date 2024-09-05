import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/loan_preview/loan_asset_preview/laon_asset_preview_event.dart';
import '../../../../bloc/loan_preview/loan_asset_preview/loan_asset_preview_bloc.dart';
import '../../../../bloc/loan_preview/loan_asset_preview/loan_asset_preview_state.dart';
import '../../../../bloc/lovs_type/lovs_type_data_bloc.dart';
import '../../../../bloc/lovs_type/lovs_type_data_event.dart';
import '../../../../bloc/lovs_type/lovs_type_data_state.dart';
import '../../../../common_widget/app_text_widget.dart';
import '../../../../model/response/loan_asset_preview_response_model.dart';
import '../../../../model/response/lovtype_type_response_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoanAssetPreviewScreen extends StatefulWidget {
  const LoanAssetPreviewScreen({super.key});

  @override
  State<LoanAssetPreviewScreen> createState() => _LoanAssetPreviewScreenState();
}

class _LoanAssetPreviewScreenState extends State<LoanAssetPreviewScreen> {
  var loanDetailsAssetsBloc = LoanAssetPreviewNewBloc();
  int jointIndex = 0;
  double totalAmountMovable = 0.0;
  double totalAmountImmovable = 0.0;
  double totalAmount = 0.0;
  String token = "";
  int langLocID = 0;
  int movableAssetId = 0;
  int immovableAssetId = 0;
  List<AssetDataListPreview> movableAssets = [];
  List<AssetDataListPreview> immovableAssets = [];
  var lovTypeBloc = GetLovsTypeDataNewBloc();

  @override
  void initState() {
    final bodyRequest = {"masterId": "2308"};
    final lovsTypeData = ["ASSESTTYPE"];
    // TODO: implement initState
    lovTypeBloc.add(
      GetLovsTypeDataNewList(
        bodyRequest: lovsTypeData,
      ),
    );

    lovTypeBloc.stream.listen((state) {
      if (state is GetLovsTypeDataSuccess) {
        if (mounted) {}
        List<LovTypeDataList> data = state.lovsTypeResponseModel.dataList ?? [];

        data
            .where((element) =>
                (element.lovType == "ASSESTTYPE" &&
                    element.value == "Movable Assest") ||
                (element.lovType == "ASSESTTYPE" &&
                    element.value == "Immovable Assest"))
            .forEach((element) {
          if (mounted) {
            setState(() {
              if (element.value == "Movable Assest") {
                if (kDebugMode) {
                  print("0000000000000");
                }
                if (kDebugMode) {
                  print(element.id);
                }
                if (kDebugMode) {
                  print("00000000000000");
                }
                movableAssetId = element.id!;
              } else if (element.value == "Immovable Assest") {
                immovableAssetId = element.id!;
              }
            });
          }
         if(mounted){
           context
               .read<LoanAssetPreviewNewBloc>()
               .add(GetAssetNewPreview(bodyRequest: bodyRequest));
         }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            BlocListener<LoanAssetPreviewNewBloc, LoanAssetPreviewNewState>(
              listener: (context, state) {
                if (state is LoanAssetPreviewNewSuccess) {
                  List<AssetDataListPreview> newImmovableAssets = [];
                  List<AssetDataListPreview> newMovableAssets = [];
                  double newTotalAmountImmovable = 0.0;
                  double newTotalAmountMovable = 0.0;

                  for (var asset
                      in state.getLoanAssetNewPreviewResponseModel.dataList!) {
                    if (asset.assestTypeId == immovableAssetId) {
                      newImmovableAssets.add(asset);
                      newTotalAmountImmovable +=
                          asset.presentMarketValue?.toDouble() ?? 0.0;
                    } else if (asset.assestTypeId == movableAssetId) {
                      newMovableAssets.add(asset);
                      newTotalAmountMovable +=
                          asset.presentMarketValue?.toDouble() ?? 0.0;
                    }
                  }

                  setState(() {
                    immovableAssets = newImmovableAssets;
                    movableAssets = newMovableAssets;
                    totalAmountImmovable = newTotalAmountImmovable;
                    totalAmountMovable = newTotalAmountMovable;
                  });
                }
              },
              child: Column(
                children: [
                   Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextWidget(
                      text: AppLocalizations.of(context)!.particularsOfImmovableOwned,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: immovableAssets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextWidget(
                                text:
                                    immovableAssets[index].assetDataName ?? '',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              AppTextWidget(
                                text: immovableAssets[index].particulars ?? '',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          AppTextWidget(
                            text: immovableAssets[index]
                                .presentMarketValue
                                .toString(),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: AppLocalizations.of(context)!.total,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      AppTextWidget(
                        text: totalAmountImmovable.toString(),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  /************************/
                  SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppTextWidget(
                      text: AppLocalizations.of(context)!.particularsOfMovableOwned,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: movableAssets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextWidget(
                                  text: movableAssets[index].assetDataName ?? '',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                AppTextWidget(
                                  text: movableAssets[index].particulars ?? '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          AppTextWidget(
                            text: movableAssets[index]
                                .presentMarketValue
                                .toString(),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Divider(
              height: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: AppLocalizations.of(context)!.total,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                AppTextWidget(
                  text: totalAmountMovable.toString(),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ],
    );
  }
}
