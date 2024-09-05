import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../cubit/add_land/edit_land_cubit.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/form_validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLandEncumberedWidget extends StatefulWidget {
  const EditLandEncumberedWidget({super.key});

  @override
  State<EditLandEncumberedWidget> createState() =>
      _EditLandEncumberedWidgetState();
}

class _EditLandEncumberedWidgetState extends State<EditLandEncumberedWidget> {
  final TextEditingController _encumberedController = TextEditingController();

  List<String> getSuggestions(String query, List<String> encumberedList) {
    final List<String> suggestions = encumberedList
        .where((idProof) => idProof.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return suggestions;
  }

  @override
  void didChangeDependencies() {
    final editLandCubit = context.read<EditLandCubit>().state;
    _encumberedController.text = editLandCubit.encumbered ?? '';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      controller: _encumberedController,
      suggestionsCallback: (pattern) {
        return getSuggestions(pattern, ["Yes", "No"]);
      },
      builder: (context, controller, focusNode) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: AppFormValidation.encumbered,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration:  InputDecoration(
            suffixIcon: const Icon(Icons.arrow_drop_down),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.outLineColor),
            ),
            labelText: AppLocalizations.of(context)!.encumbered,
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
        _encumberedController.text = selectedState;
        context.read<EditLandCubit>().updateModel(encumbered: selectedState);
      },
    );
  }
}
