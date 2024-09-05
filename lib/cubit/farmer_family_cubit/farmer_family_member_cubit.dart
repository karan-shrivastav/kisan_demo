import 'package:ekisan_credit/cubit/model/farmer_family_member_cubit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerFamilyMemberCubit extends Cubit<FarmerFamilyMemberCubitModel> {
  FarmerFamilyMemberCubit() : super(FarmerFamilyMemberCubitModel());

  void updateModel({
    int? genderId,
    int? nomineeRelationId,
    int? nomineeOccupationId,
    String? nomineeName,
    String? nomineeAge,
    String? annualIncome,
    String? relationName,
  }) {
    emit(state.copyWith(
      genderId: genderId ?? state.genderId,
      nomineeRelationId: nomineeRelationId ?? state.nomineeRelationId,
      nomineeOccupationId: nomineeOccupationId ?? state.nomineeOccupationId,
      nomineeName: nomineeName ?? state.nomineeName,
      nomineeAge: nomineeAge ?? state.nomineeAge,
      annualIncome: annualIncome ?? state.annualIncome,
      relationName: relationName ?? state.relationName,
    ));
  }

  void clear() {
    emit(FarmerFamilyMemberCubitModel());
  }
}
