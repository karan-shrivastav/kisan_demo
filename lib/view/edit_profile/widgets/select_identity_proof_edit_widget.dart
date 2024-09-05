import 'package:ekisan_credit/bloc/lovs_type/lovs_type_data_bloc.dart';
import 'package:ekisan_credit/bloc/lovs_type/lovs_type_data_state.dart';
import 'package:ekisan_credit/services/toast_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../common_widget/app_text_widget.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../cubit/create_farmeruserinfo/create_farmetuserinfo_cubit.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../model/response/lovtype_type_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectIdentityProofEditWidget extends StatefulWidget {
  const SelectIdentityProofEditWidget({super.key});

  @override
  State<SelectIdentityProofEditWidget> createState() =>
      _SelectIdentityProofEditWidgetState();
}

class _SelectIdentityProofEditWidgetState
    extends State<SelectIdentityProofEditWidget> {
  TextEditingController idProofNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _proofIdNumberTextEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  List<String> getSuggestions(String query, List<String> idProofValues) {
    final List<String> suggestions = idProofValues
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final ValueNotifier<String> _selectedValue = ValueNotifier<String>("");
  bool _hasIdProofError = false;

  @override
  void initState() {
    final createFarmerUserPersonalInfo =
        context.read<CreateFarmerUserInfoCubit>().state;
    // TODO: implement initState
    // Fetch the saved value from the cubit or wherever it's stored
    String savedSelectedValue =
        createFarmerUserPersonalInfo.selectedProofOfIdentityString ?? "";
    idProofNumberController.text = savedSelectedValue;
    _proofIdNumberTextEditingController.text =
        createFarmerUserPersonalInfo.idProofNo ?? '';
    _mobileNumberTextEditingController.text =
        createFarmerUserPersonalInfo.mobileNumber ?? '';
    _emailTextEditingController.text = createFarmerUserPersonalInfo.email ?? '';

   // context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    idProofNumberController.text =
        getFarmerResponseModel.data?.proofOfIdentity?.value ?? '';
    _proofIdNumberTextEditingController.text =
        getFarmerResponseModel.data?.idProofNumber ?? '';
    _mobileNumberTextEditingController.text =
        '${getFarmerResponseModel.data?.mobileNo ?? ''}';
    _emailTextEditingController.text = getFarmerResponseModel.data?.email ?? '';
    ToastAlert('emailController :${_emailTextEditingController.text}');

    final createFarmerCubit = context.read<CreateFarmerUserInfoCubit>();
    createFarmerCubit.updateModel(
      idProofNo: getFarmerResponseModel.data?.idProofNumber ?? '',
      proofOfIdentityId: getFarmerResponseModel.data?.proofOfIdentity?.id,
      selectedProofOfIdentityString:
          getFarmerResponseModel.data?.idProofNumber ?? '',
    );
    _selectedValue.value =
        getFarmerResponseModel.data?.proofOfIdentity?.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createFarmerUserPersonalInfo =
        context.read<CreateFarmerUserInfoCubit>();

    return Column(
      children: [
        BlocBuilder<GetLovsTypeDataNewBloc, GetLovsTypeDataNewState>(
          builder: (BuildContext context, GetLovsTypeDataNewState state) {
            if (state is GetLovsTypeDataSuccess) {
              List<LovTypeDataList>? identityTypeList = state
                  .lovsTypeResponseModel.dataList
                  ?.where((item) => item.lovType == "IDPROOF")
                  .toList();

              // Extracting the identity type values from the filtered list
              List<String> idProofValues =
                  identityTypeList?.map((item) => item.value ?? "").toList() ??
                      [];

              return TypeAheadField<String>(
                controller: idProofNumberController,
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern, idProofValues);
                },
                builder: (context, controller, focusNode) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    validator: (value) =>
                        AppFormValidation.validateIdProof(context, value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.outLineColor),
                      ),
                      labelText:
                          AppLocalizations.of(context)!.selectProofOfIdentity,
                      labelStyle: TextStyle(
                        color: _hasIdProofError
                            ? Colors.red
                            : AppColors.outLineColor,
                      ),
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      final mainValidationError =
                          AppFormValidation.validateIdProof(context, value);
                      if (mainValidationError != null) {
                        setState(() {
                          _hasIdProofError = true;
                        });
                      }
                      context
                          .read<CreateFarmerUserInfoCubit>()
                          .updateModel(selectedProofOfIdentityString: value);
                    },
                  );
                },
                itemBuilder: (context, idProof) {
                  return ListTile(
                    title: Text(idProof),
                  );
                },
                onSelected: (selectedIdProof) {
                  idProofNumberController.text = selectedIdProof;
                  setState(() {
                    _hasIdProofError = false;
                  });
                  _selectedValue.value = selectedIdProof;
                  List<LovTypeDataList>? identityTypeList = state
                      .lovsTypeResponseModel.dataList
                      ?.where((item) =>
                          item.lovType == "IDPROOF" &&
                          item.value == selectedIdProof)
                      .toList();

                  // Print the id of the first item found
                  if (identityTypeList != null && identityTypeList.isNotEmpty) {
                    context.read<CreateFarmerUserInfoCubit>().updateModel(
                        proofOfIdentityId: identityTypeList[0].id,
                        selectedProofOfIdentityString: selectedIdProof);
                    if (kDebugMode) {
                      print("Corresponding ID: ${identityTypeList[0].id}");
                    }
                  }
                },
              );
            }

            return CommonTextField(
                enabled: false,
                suffixIcon: Icons.arrow_drop_down,
                labelText: AppLocalizations.of(context)!.selectProofOfIdentity);
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ValueListenableBuilder(
          valueListenable: _selectedValue,
          builder: (BuildContext context, String value, Widget? child) {
            return CommonTextField(
              labelText: AppLocalizations.of(context)!.enterIdProofNumber,
              controller: _proofIdNumberTextEditingController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (_selectedValue.value == "Pan Card") {
                  return AppFormValidation.validatePanCard(value);
                } else if (_selectedValue.value == "Passport") {
                  return AppFormValidation.validatePassport(value);
                } else if (_selectedValue.value == "Driving License") {
                  return AppFormValidation.validateDrivingLicense(value);
                } else if (_selectedValue.value == "Voter ID") {
                  return AppFormValidation.validateVoterId(value);
                }
                return null;
                // If no specific validation is needed based on the selected value,
                // you can return null to indicate that the field is valid.
                // return null;
              },
              vertical: 16,
              onChange: (value) {
                context
                    .read<CreateFarmerUserInfoCubit>()
                    .updateModel(idProofNo: value);
                // return null;
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 56,
          child: CommonTextField(
            enabled: false,
            labelText: AppLocalizations.of(context)!.mobileNumber,
            controller: _mobileNumberTextEditingController,
            vertical: 16,
            onChange: (value) {
              createFarmerUserPersonalInfo.updateModel(mobileNumber: value);
            },
            keyboardType: TextInputType.phone,
            suffix: const Icon(Icons.dialpad_sharp),
            length: 10,
            prefix: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: AppTextWidget(
                text: "+91",
                fontWeight: FontWeight.w700,
                textColor: AppColors.textBlackColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CommonTextField(
          prefixIcon: Icons.email,
          showPrefixIcon: true,
          labelText: AppLocalizations.of(context)!.email,
          keyboardType: TextInputType.emailAddress,
          controller: _emailTextEditingController,
          onChange: (value) {
            createFarmerUserPersonalInfo.updateModel(email: value);
          },
          vertical: 16,
        ),
      ],
    );
  }
}
