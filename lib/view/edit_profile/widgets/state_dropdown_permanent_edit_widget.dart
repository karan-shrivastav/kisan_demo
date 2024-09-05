import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/get_farmer/get_farmer_bloc.dart';
import '../../../bloc/get_farmer/get_farmer_event.dart';
import '../../../bloc/state/state_bloc.dart';
import '../../../bloc/state/state_event.dart';
import '../../../bloc/state/state_state.dart';
import '../../../common_widget/common_text_field_widget.dart';
import '../../../model/response/get_farmer_by_id_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateDropDownPermanentEditWidget extends StatefulWidget {
  const StateDropDownPermanentEditWidget({super.key});

  @override
  State<StateDropDownPermanentEditWidget> createState() =>
      _StateDropDownPermanentEditWidgetState();
}

class _StateDropDownPermanentEditWidgetState
    extends State<StateDropDownPermanentEditWidget> {
  List<String> getSuggestions(String query, List<String> statesList) {
    final List<String> suggestions = statesList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _stateTextEditingController =
      TextEditingController();

  List<AddressDto>? addressList = [];

  @override
  void didChangeDependencies() {
    context.read<StateBloc>().add(GetAllState());
    // context.read<GetFarmerBloc>().add(GetFarmerDetails(body: const {}));
    final GetFarmerByIdResponseModel getFarmerResponseModel =
        context.read<GetFarmerBloc>().getFarmerResponseModel;
    if (getFarmerResponseModel.data?.addressDtos != null &&
        getFarmerResponseModel.data!.addressDtos!.isNotEmpty) {
      addressList = getFarmerResponseModel.data?.addressDtos;
      _stateTextEditingController.text = addressList?[1].stateName ?? '';

      final permanentAddressCubit = context.read<CreateFarmerPermanentAddressCubit>();
      permanentAddressCubit.updateModel(
          selectedStateString: addressList?[1].stateName??'',
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StateBloc, StateState>(
      builder: (BuildContext context, StateState state) {
        if (state is GetStateSuccess) {
          List<String> statesList = state.getAllStateResponseModel.dataList
                  ?.map((item) => item.stateName ?? "")
                  .toList() ??
              [];
          return TypeAheadField<String>(
            controller: _stateTextEditingController,
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, statesList);
            },
            builder: (context, controller, focusNode) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: AppFormValidation.validateState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.state,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
                onChanged: (value){
                  context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                      selectedStateString: value);
                },
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedState) {
              _stateTextEditingController.text = selectedState;

              final selectedStateObject = state
                  .getAllStateResponseModel.dataList
                  ?.firstWhere((item) => item.stateName == selectedState);

              final districtRequest = {
                "stateId": selectedStateObject?.id ?? ''
              }; // Set the selected value to _selectedState
              context
                  .read<DistrictBlocNew>()
                  .add(GetAllDistrictByState(districtRequest: districtRequest));

              context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                  stateMasterId: selectedStateObject?.id,
                  selectedStateString: selectedState);
            },
          );
        }
        return CommonTextField(
          enabled: false,
          suffixIcon: Icons.arrow_drop_down,
          labelText: AppLocalizations.of(context)!.state,
        );
      },
    );
  }
}
