import 'package:ekisan_credit/cubit/create_farmeruserinfo/create_farmer_permanent_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../bloc/district/district_bloc.dart';
import '../../../bloc/district/district_event.dart';
import '../../../bloc/state/state_bloc.dart';
import '../../../bloc/state/state_event.dart';
import '../../../bloc/state/state_state.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StateDropDownPermanentWidget extends StatefulWidget {
  const StateDropDownPermanentWidget({super.key});

  @override
  State<StateDropDownPermanentWidget> createState() =>
      _StateDropDownPermanentWidgetState();
}

class _StateDropDownPermanentWidgetState
    extends State<StateDropDownPermanentWidget> {
  List<String> getSuggestions(String query, List<String> statesList) {
    final List<String> suggestions = statesList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  final TextEditingController _stateTextEditingController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<StateBloc>().add(GetAllState());
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool _hasState = false;

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
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: _hasState ? Colors.red : AppColors.textBlackColor,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textBlackColor),
                  ),
                  labelText: AppLocalizations.of(context)!.state,
                  labelStyle: TextStyle(
                    color: _hasState ? Colors.red : AppColors.textBlackColor,
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
                      AppFormValidation.validateState(value);
                  if (mainValidationError != null) {
                    setState(() {
                      _hasState = true;
                    });
                  }
                  context.read<CreateFarmerPermanentAddressCubit>().updateModel(
                        selectedStateString: "",
                        selectedDistrictString: "",
                        selectedVillageString: "",
                      );
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
        return Container();
      },
    );
  }
}
