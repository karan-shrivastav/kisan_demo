import 'package:equatable/equatable.dart';

abstract class SelectedJointApplicantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSelectedApplicantDetails extends SelectedJointApplicantEvent {
  final String loanId;
  GetSelectedApplicantDetails({required this.loanId});
  @override
  List<Object?> get props => [loanId];
}


