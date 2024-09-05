import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/response/loan_basic_response_model.dart';
import '../model/crop_dtos.dart';
import '../model/incomplete_loan_cubit_model.dart';


class IncompleteLoanInfoCubit extends Cubit<IncompleteLoanCubitModel> {
  IncompleteLoanInfoCubit() : super(IncompleteLoanCubitModel());
  void updateModel({
    String? stateName,
    int? stateId,
    String? districtName,
    int? districtId,
    String? bankName,
    int? bankMasterId,
    int? branchId,
    String? branchName,
    String? bankType,
    String? loanPurpose,
    String? covered,
    List<CropDetailDtos>? cropDetailDtos,
    dynamic firstAmount,
    dynamic secondAmount,
    dynamic thirdAmount,
    dynamic totalAmount,
    String? jointApplicant,
    dynamic presentMarketValue,
    dynamic agricultureIncome,
    dynamic otherIncome,
    dynamic alliedIncome,
    int? entityLevelId,
    String? entityLevelName,
    int? pacsLevelId,
    String? otherSecurityDesc,
    int ? landTypeId,
    List<CropDetailDto>? cropDetailDto,
  }) {
    emit(state.copyWith(
        stateName: stateName ?? state.stateName,
        stateId: stateId ?? state.stateId,
        districtName: districtName ?? state.districtName,
        districtId: districtId ?? state.districtId,
        bankName: bankName ?? state.bankName,
        bankMasterId: bankMasterId ?? state.bankMasterId,
        branchId: branchId ?? state.branchId,
        branchName: branchName ?? state.branchName,
        bankType: bankType ?? state.bankType,
        loanPurpose: loanPurpose ?? state.loanPurpose,
        covered: covered ?? state.covered,
        cropDetailDtos: cropDetailDtos ?? state.cropDetailDtos,
        firstAmount: firstAmount ?? state.firstAmount,
        secondAmount: secondAmount ?? state.secondAmount,
        thirdAmount: thirdAmount ?? state.thirdAmount,
        totalAmount: totalAmount ?? state.totalAmount,
        jointApplicant: jointApplicant ?? state.jointApplicant,
        presentMarketValue: presentMarketValue ?? state.presentMarketValue,
        agricultureIncome: agricultureIncome ?? state.agricultureIncome,
        otherIncome: otherIncome ?? state.otherIncome,
        alliedIncome: alliedIncome ?? state.alliedIncome,
        entityLevelId: entityLevelId ?? state.entityLevelId,
        entityLevelName: entityLevelName ?? state.entityLevelName,
        pacsLevelId: pacsLevelId ?? state.pacsLevelId,
        otherSecurityDesc: otherSecurityDesc ?? state.otherSecurityDesc,
        landTypeId: landTypeId ?? state.landTypeId,
        cropDetailDto: cropDetailDto ?? state.cropDetailDto,
    ));
  }

  void clear() {
    emit(IncompleteLoanCubitModel());
  }
}
