import 'package:ekisan_credit/bloc/family/get_family_detail/get_farmer_family_details_bloc.dart';
import 'package:ekisan_credit/common_button.dart';
import 'package:ekisan_credit/common_widget/app_text_widget.dart';
import 'package:ekisan_credit/utils/app_colors.dart';
import 'package:ekisan_credit/view/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_event.dart';
import '../../../bloc/family/get_family_detail/get_farmer_family_state.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_state.dart';
import '../../../common_widget/header.dart';
import '../../../model/response/farmer_family_detail_response_model.dart';
import '../../edit_profile/widgets/add_family_bottomsheet.dart';
import '../../edit_profile/widgets/update_family_dialog.dart';
import '../widgets/family_expansion_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyScreen extends StatefulWidget {
  static String routeName = "family-screen";

  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<GetFarmerBloc>().stream.listen((event) {
      if (event is GetFarmerSuccess) {
        if (mounted) {
          context
              .read<GetFarmerFamilyDetailBloc>()
              .add(GetFarmerFamilyDetails());
        }
      }
    });
    super.didChangeDependencies();
  }

  List<FamilyDataList>? familyList = [];
  final ValueNotifier<bool> isEnable = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFarmerFamilyDetailBloc, GetFarmerFamilyDetailState>(
        builder: (BuildContext context, GetFarmerFamilyDetailState state) {
      if (state is GetFarmerFamilyDetailDetailSuccess) {
        familyList = state.getFarmerFamilyDetailResponseModel.dataList ?? [];
        if (familyList!.isNotEmpty && familyList != null && familyList != []) {
          isEnable.value = true;
        }
      }
      return ValueListenableBuilder(
          valueListenable: isEnable,
          builder: (BuildContext context, bool value, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: isEnable.value && familyList!.isNotEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: SizedBox(
                        width: 96,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return const AddFamilyBottomSheetWidget();
                                });
                          },
                          label: AppTextWidget(
                            text: AppLocalizations.of(context)!.add,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
              body: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 84,
                        ),
                        Header(
                          pageNumber:
                              isEnable.value && familyList!.isNotEmpty ? 4 : 3,
                          percentageFirst: 100,
                          percentageSecond: 100,
                          percentageThird: 100,
                          pageName: AppLocalizations.of(context)!.profile,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        isEnable.value && familyList!.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .familyInformation,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      width: 96,
                                      child: FloatingActionButton.extended(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return const AddFamilyBottomSheetWidget();
                                              });
                                        },
                                        label: AppTextWidget(
                                          text:
                                              AppLocalizations.of(context)!.add,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        icon: const Icon(
                                          Icons.add,
                                          size: 16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : AppTextWidget(
                                text: AppLocalizations.of(context)!
                                    .familyInformation,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                        const SizedBox(
                          height: 24,
                        ),
                        isEnable.value && familyList!.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: familyList?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FamilyExpensionTile(
                                      editButtonFunction: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return UpdateFamilyDialog(
                                              id: familyList?[index].id,
                                              genderId:
                                                  familyList?[index].genderId,
                                              nomineeRelationId:
                                                  familyList?[index]
                                                      .relationWithApplicantId,
                                              occupationId: familyList?[index]
                                                  .occupationId,
                                              gender: familyList?[index].gender,
                                              fullNameController:
                                                  TextEditingController(
                                                      text: familyList?[index]
                                                              .name ??
                                                          ''),
                                              ageController:
                                                  TextEditingController(
                                                      text: familyList?[index]
                                                              .age ??
                                                          ''),
                                              annualIncomeController:
                                                  TextEditingController(
                                                      text: familyList?[index]
                                                              .annualIncome ??
                                                          ''),
                                              relationTextEditingController:
                                                  TextEditingController(
                                                      text: familyList?[index]
                                                              .relationWithApplicant ??
                                                          ''),
                                              occupationTextEditingController:
                                                  TextEditingController(
                                                      text: familyList?[index]
                                                              .occupation ??
                                                          ''),
                                            );
                                          },
                                        );
                                      },
                                      id: familyList?[index].id,
                                      name: familyList?[index].name ?? '',
                                      age: familyList?[index].age ?? '',
                                      gender: familyList?[index].gender ?? '',
                                      relation: familyList?[index]
                                              .relationWithApplicant ??
                                          '',
                                      occupation:
                                          familyList?[index].occupation ?? '',
                                      annualIncome:
                                          familyList?[index].annualIncome ?? '',
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: SizedBox(
                                  width: 250,
                                  child: Center(
                                    child: AppTextWidget(
                                      text: AppLocalizations.of(context)!
                                          .pleaseAddAtleast,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        if (isEnable.value && familyList!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (route) =>
                                    false, // Predicate that always returns false to remove all routes
                              );
                            },
                            child: CommonButton(
                              buttonName: AppLocalizations.of(context)!.next,
                            ),
                          )
                        else
                          CommonButton(
                            buttonColor: AppColors.grayColor,
                            buttonName: AppLocalizations.of(context)!.next,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          });
    });
  }
}
