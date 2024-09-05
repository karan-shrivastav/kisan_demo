import 'package:equatable/equatable.dart';

abstract class SelectedLandDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSelectedLandDetails extends SelectedLandDetailsEvent {
  final String loanId;
  GetSelectedLandDetails({required this.loanId});
  @override
  List<Object?> get props => [loanId];
}


