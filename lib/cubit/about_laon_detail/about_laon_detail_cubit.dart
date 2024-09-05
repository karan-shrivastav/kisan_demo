import 'package:ekisan_credit/cubit/model/farmer_info_model_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/about_loan_detail_cubit_model.dart';

class AboutLoanDetailCubit extends Cubit<AboutLoanDetailCubitModel> {
  AboutLoanDetailCubit() : super(AboutLoanDetailCubitModel());

  void updateModel({
    String? loanId,
    String? applicationId,
  }) {
    emit(state.copyWith(
      loanId: loanId ?? state.loanId,
      applicationId: applicationId ?? state.applicationId,
    ));
  }

  void clear() {
    emit(AboutLoanDetailCubitModel());
  }
}
