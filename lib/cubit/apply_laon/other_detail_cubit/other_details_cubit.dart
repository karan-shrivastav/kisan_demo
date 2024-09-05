import 'package:ekisan_credit/utils/money_formater.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/other_details_cubit_model.dart';

CurrencyFormatter currencyFormatter = CurrencyFormatter();

class OtherDetailsCubit extends Cubit<OtherDetailsState> {
  OtherDetailsCubit() : super(const OtherDetailsState());
  // Method to add data from UI
  void addDataFromUI({
    LoanAsset? loanAsset,
    LoanGuarantorsList? loanGuarantor,
    LoanLiabilityGuarantor? loanLiabilityGuarantor,
    UserLoanLiabilitiesList? userLoanLiability,
    LoanMasterOtherDetailsRequestPayload? loanMasterOtherDetailsRequestPayload,
  }) {
    final newState = state.copyWith(
      loanAsset: LoanAsset(
          id: loanAsset?.id ?? state.loanAsset?.id,
          assestTypeId:
              loanAsset?.assestTypeId ?? state.loanAsset?.assestTypeId,
          assetDataId: loanAsset?.assetDataId ?? state.loanAsset?.assetDataId,
          particulars: loanAsset?.particulars ?? state.loanAsset?.particulars,
          presentMarketValue: loanAsset?.presentMarketValue ??
              state.loanAsset?.presentMarketValue,
          assetName: loanAsset?.assetName ?? state.loanAsset?.assetName,
          listId: loanAsset?.listId ?? state.loanAsset?.listId,
          assetType: loanAsset?.assetType ?? state.loanAsset?.assetType),
      loanGuarantor: LoanGuarantorsList(
        occupationDataId: loanGuarantor?.occupationDataId ??
            state.loanGuarantor?.occupationDataId,
        guarantorName:
            loanGuarantor?.guarantorName ?? state.loanGuarantor?.guarantorName,
        age: loanGuarantor?.age ?? state.loanGuarantor?.age,
        address: loanGuarantor?.address ?? state.loanGuarantor?.address,
        mobileNumber:
            loanGuarantor?.mobileNumber ?? state.loanGuarantor?.mobileNumber,
        netWorth: loanGuarantor?.netWorth ?? state.loanGuarantor?.netWorth,
        listId: loanGuarantor?.listId ?? state.loanGuarantor?.listId,
      ),
      loanLiabilityGuarantor: LoanLiabilityGuarantor(
          bankMasterId: loanLiabilityGuarantor?.bankMasterId ??
              state.loanLiabilityGuarantor?.bankMasterId,
          guarantorName: loanLiabilityGuarantor?.guarantorName ??
              state.loanLiabilityGuarantor?.guarantorName,
          loanAmount: loanLiabilityGuarantor?.loanAmount ??
              state.loanLiabilityGuarantor?.loanAmount,
          outstanding: loanLiabilityGuarantor?.outstanding ??
              state.loanLiabilityGuarantor?.outstanding,
          accountStatus: loanLiabilityGuarantor?.accountStatus ??
              state.loanLiabilityGuarantor?.accountStatus,
          accountStatusName: loanLiabilityGuarantor?.accountStatusName ??
              state.loanLiabilityGuarantor?.accountStatusName,
          bankName: loanLiabilityGuarantor?.bankName ??
              state.loanLiabilityGuarantor?.bankName,
          listId: loanLiabilityGuarantor?.listId ??
              state.loanLiabilityGuarantor?.listId),
      userLoanLiability: UserLoanLiabilitiesList(
          farmerId:
              userLoanLiability?.farmerId ?? state.userLoanLiability?.farmerId,
          accountStatusId: userLoanLiability?.accountStatusId ??
              state.userLoanLiability?.accountStatusId,
          securityOfferedId: userLoanLiability?.securityOfferedId ??
              state.userLoanLiability?.securityOfferedId,
          bankName:
              userLoanLiability?.bankName ?? state.userLoanLiability?.bankName,
          branchName: userLoanLiability?.branchName ??
              state.userLoanLiability?.branchName,
          loanPurpose: userLoanLiability?.loanPurpose ??
              state.userLoanLiability?.loanPurpose,
          outstanding: userLoanLiability?.outstanding ??
              state.userLoanLiability?.outstanding,
          bankType:
              userLoanLiability?.bankType ?? state.userLoanLiability?.bankType,
          listId: userLoanLiability?.listId ?? state.userLoanLiability?.listId),
      loanMasterOtherDetailsRequestPayload:
          LoanMasterOtherDetailsRequestPayload(
        agricultureIncome:
            loanMasterOtherDetailsRequestPayload?.agricultureIncome ??
                state.loanMasterOtherDetailsRequestPayload?.agricultureIncome,
        otherIncome: loanMasterOtherDetailsRequestPayload?.otherIncome ??
            state.loanMasterOtherDetailsRequestPayload?.otherIncome,
        alliedIncome: loanMasterOtherDetailsRequestPayload?.alliedIncome ??
            state.loanMasterOtherDetailsRequestPayload?.alliedIncome,
        lastYear: loanMasterOtherDetailsRequestPayload?.lastYear ??
            state.loanMasterOtherDetailsRequestPayload?.lastYear,
      ),
    );
    emit(newState);
  }

  void resetState() {
    emit(
        const OtherDetailsState()); // Resetting all fields to their initial state
  }

  void addLoanAsset(LoanAsset newAsset) {
    final updatedAssets = List<LoanAsset>.from(state.loanAssetsList)
      ..add(newAsset);
    emit(state.copyWith(loanAssetsList: updatedAssets));
  }

  void clearLoanAssetList() {
    emit(state.copyWith(loanAssetsList: []));
  }

  List<LoanAsset> getLoanAssets() {
    return state.loanAssetsList;
  }

  void addBorrowerList(UserLoanLiabilitiesList userLoanLiability) {
    final updatedAssets =
        List<UserLoanLiabilitiesList>.from(state.userLoanLiabilityList)
          ..add(userLoanLiability);
    emit(state.copyWith(userLoanLiabilityList: updatedAssets));
  }

  void clearBorrowerList() {
    emit(state.copyWith(userLoanLiabilityList: []));
  }

  void addGuarantorList(LoanGuarantorsList loanGuarantor) {
    // If state.loanGuarantorList is null, use an empty list as the fallback
    final updatedGuarantors =
        List<LoanGuarantorsList>.from(state.loanGuarantorList ?? []);
    updatedGuarantors.add(loanGuarantor);
    emit(state.copyWith(loanGuarantorList: updatedGuarantors));
  }

  void clearGuarantorList() {
    emit(state.copyWith(loanGuarantorList: []));
  }

  //********* Add LoanLiabilityGuarantor **********//
  void addLoanLiabilityGuarantorList(
      LoanLiabilityGuarantor loanLiabilityGuarantor) {
    final updatedLoanLiabilityGuarantor =
        List<LoanLiabilityGuarantor>.from(state.loanLiabilityGuarantorList);
    updatedLoanLiabilityGuarantor.add(loanLiabilityGuarantor);
    emit(state.copyWith(
        loanLiabilityGuarantorList: updatedLoanLiabilityGuarantor));
  }

  void clearLoanLiabilityGuarantorList() {
    emit(state.copyWith(loanLiabilityGuarantorList: []));
  }

  List<UserLoanLiabilitiesList> getBorrowerList() {
    return state.userLoanLiabilityList;
  }

  void deleteBorrowerById(dynamic id) {
    final updatedBorrower = state.userLoanLiabilityList
        .where((borrower) => borrower.listId != id)
        .toList();
    emit(state.copyWith(userLoanLiabilityList: updatedBorrower));
  }

  void deleteLoanAssetById(dynamic id) {
    final updatedAssets =
        state.loanAssetsList.where((asset) => asset.listId != id).toList();
    emit(state.copyWith(loanAssetsList: updatedAssets));
  }

  void deleteGuarantorById(dynamic id) {
    final updatedGuarantor = state.loanGuarantorList
        .where((guarantor) => guarantor.listId != id)
        .toList();
    emit(state.copyWith(loanGuarantorList: updatedGuarantor));
  }

  //********* Delete LoanLiabilityGuarantor **********//
  void deleteLoanLiabilityGuarantorById(dynamic id) {
    final updatedLoanLiabilityGuarantor = state.loanLiabilityGuarantorList
        .where((borrower) => borrower.listId != id)
        .toList();
    emit(state.copyWith(
        loanLiabilityGuarantorList: updatedLoanLiabilityGuarantor));
  }

  double getTotalPresentMarketValueOfImmovable() {
    double total = 0.0;
    for (LoanAsset asset in state.loanAssetsList) {
      if (asset.assetType == "Immovable") {
        double value = double.tryParse(
                (asset.presentMarketValue?.replaceAll(',', '')) ?? "0") ??
            0.0;
        total += value;
      }
    }
    return total;
  }

  double getTotalPresentMarketValueOfMovable() {
    double total = 0.0;
    for (LoanAsset asset in state.loanAssetsList) {
      if (asset.assetType == "Movable") {
        double value = double.tryParse(
                (asset.presentMarketValue?.replaceAll(',', '')) ?? "0") ??
            0.0;
        total += value;
      }
    }
    return total;
  }

//************* Clear asset ***********************//
  clearAsset() {
    emit(state.copyWith(
      loanAsset: LoanAsset(
        id: null,
        loanMasterId: null,
        assetDataId: null,
        assestTypeId: null,
        particulars: null,
        presentMarketValue: null,
        assetName: null,
        listId: null,
        assetType: null,
      ),
    ));
  }

//******** Clear Loan Guarantor *************//
  void clearLoanGuarantor() {
    emit(state.copyWith(
      loanGuarantor: LoanGuarantorsList(
        occupationDataId: null,
        guarantorName: null,
        age: null,
        address: null,
        mobileNumber: null,
        netWorth: null,
        listId: '',
      ),
    ));
  }

  //******** Clear Liabilities Guarantor *************//

  void clearLiabilitiesLoanGuarantor() {
    emit(state.copyWith(
      loanLiabilityGuarantor: LoanLiabilityGuarantor(
        bankMasterId: null,
        guarantorName: null,
        bankName: null,
        loanAmount: null,
        outstanding: null,
        accountStatus: null,
        listId: '',
      ),
    ));
  }
  //******** Clear User Liabilities *************//

  void clearUserLoanLiability() {
    emit(state.copyWith(
      userLoanLiability: UserLoanLiabilitiesList(
          accountStatusId: null,
          securityOfferedId: null,
          bankName: null,
          branchName: null,
          loanPurpose: null,
          outstanding: null,
          bankType: null,
          listId: null),
    ));
  }
}

class OtherDetailsState {
  final LoanAsset? loanAsset;
  final List<LoanAsset>
      loanAssetsList; // Changed from LoanAsset? to List<LoanAsset>
  final LoanGuarantorsList? loanGuarantor;

  final LoanLiabilityGuarantor? loanLiabilityGuarantor;
  final List<LoanLiabilityGuarantor> loanLiabilityGuarantorList;

  final UserLoanLiabilitiesList? userLoanLiability;
  final List<UserLoanLiabilitiesList> userLoanLiabilityList;
  final List<LoanGuarantorsList> loanGuarantorList;
  final LoanMasterOtherDetailsRequestPayload?
      loanMasterOtherDetailsRequestPayload;

  const OtherDetailsState({
    this.loanAsset,
    this.loanAssetsList = const [], // Default to an empty list
    this.userLoanLiabilityList = const [],
    this.loanGuarantorList = const [],
    this.loanLiabilityGuarantorList = const [],
    this.loanGuarantor,
    this.loanLiabilityGuarantor,
    this.userLoanLiability,
    this.loanMasterOtherDetailsRequestPayload,
  });

  OtherDetailsState copyWith(
      {LoanAsset? loanAsset,
      List<LoanAsset>? loanAssetsList,
      LoanGuarantorsList? loanGuarantor,
      LoanLiabilityGuarantor? loanLiabilityGuarantor,
      UserLoanLiabilitiesList? userLoanLiability,
      List<UserLoanLiabilitiesList>? userLoanLiabilityList,
      LoanMasterOtherDetailsRequestPayload?
          loanMasterOtherDetailsRequestPayload,
      List<LoanGuarantorsList>? loanGuarantorList,
      List<LoanLiabilityGuarantor>? loanLiabilityGuarantorList}) {
    return OtherDetailsState(
      loanAsset: loanAsset ?? this.loanAsset,
      loanAssetsList: loanAssetsList ?? this.loanAssetsList,
      loanGuarantor: loanGuarantor ?? this.loanGuarantor,
      loanLiabilityGuarantor:
          loanLiabilityGuarantor ?? this.loanLiabilityGuarantor,
      userLoanLiability: userLoanLiability ?? this.userLoanLiability,
      loanMasterOtherDetailsRequestPayload:
          loanMasterOtherDetailsRequestPayload ??
              this.loanMasterOtherDetailsRequestPayload,
      userLoanLiabilityList:
          userLoanLiabilityList ?? this.userLoanLiabilityList,
      loanGuarantorList: loanGuarantorList ?? this.loanGuarantorList,
      loanLiabilityGuarantorList:
          loanLiabilityGuarantorList ?? this.loanLiabilityGuarantorList,
    );
  }
}
