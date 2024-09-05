import 'package:equatable/equatable.dart';
import '../../model/response/common_response_model.dart';
import '../../model/response/selected_joint_applicant_response_model.dart';
import '../../model/response/selected_land_details_response_model.dart';

abstract class SelectedLandDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedLandDetailsInitial extends SelectedLandDetailsState {}

class SelectedLandDetailsLoading extends SelectedLandDetailsState {}

class SelectedLandDetailsSuccess extends SelectedLandDetailsState {
  final SelectedLandDetailsResponseModel selectedLandDetailsResponseModel;

  SelectedLandDetailsSuccess({required this.selectedLandDetailsResponseModel});

  @override
  List<Object?> get props => [selectedLandDetailsResponseModel];
}

class SelectedLandDetailsFail extends SelectedLandDetailsState {
  final CommonResponseModel commonResponseModel;
  SelectedLandDetailsFail({required this.commonResponseModel});
  @override
  List<Object?> get props => [commonResponseModel];
}
