import 'package:ekisan_credit/cubit/add_land/edit_land_cubit.dart';
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


class EditLandDetailState extends StatefulWidget {
  const EditLandDetailState({super.key});

  @override
  State<EditLandDetailState> createState() => _EditLandDetailsState();
}

class _EditLandDetailsState extends State<EditLandDetailState> {
  final TextEditingController _stateTextEditingController = TextEditingController();
  List<String> getSuggestions(String query, List<String> statesList) {
    final List<String> suggestions = statesList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }
  @override
  void didChangeDependencies() {
    context.read<StateBloc>().add(GetAllState());

    final editLandCubit = context.read<EditLandCubit>().state;
    _stateTextEditingController.text = editLandCubit.stateName ?? "";
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StateBloc, StateState>(
      builder: (BuildContext context, StateState state) {
        if (state is GetStateSuccess) {
          List<String> statesList = state
              .getAllStateResponseModel.dataList
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
                decoration:  InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: const OutlineInputBorder(),
                  focusedBorder:const  OutlineInputBorder(
                    borderSide:
                    BorderSide(color: AppColors.outLineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.state,
                  labelStyle: const TextStyle(color: AppColors.outLineColor),
                ),
              );
            },
            itemBuilder: (context, idProof) {
              return ListTile(
                title: Text(idProof),
              );
            },
            onSelected: (selectedState) {
              _stateTextEditingController.text = selectedState;

              final selectedStateObject =
              state.getAllStateResponseModel.dataList?.firstWhere(
                      (item) => item.stateName == selectedState);

              final districtRequest = {
                "stateId": selectedStateObject?.id ?? ''
              }; // Set the selected value to _selectedState
              context.read<DistrictBlocNew>().add(GetAllDistrictByState(
                  districtRequest: districtRequest));

              context
                  .read<EditLandCubit>()
                  .updateModel(
                stateMasterId: selectedStateObject?.id,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
