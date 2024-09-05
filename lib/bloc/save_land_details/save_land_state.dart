import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/save_land_details_resposne_model.dart';


abstract class SaveLandDetailsNewState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SaveLandDetailsNewStateInitial extends SaveLandDetailsNewState{

}
class SaveLandDetailsNewStateLoading extends SaveLandDetailsNewState{

}
class SaveLandDetailsNewStateSuccess extends SaveLandDetailsNewState{
  final SaveLoanDetailsNewResponseModel saveLoanDetailsNewResponseModel;
  SaveLandDetailsNewStateSuccess({required this.saveLoanDetailsNewResponseModel});
  @override
  List<Object?> get props => [saveLoanDetailsNewResponseModel];
}
class SaveLandDetailsNewStateFail extends SaveLandDetailsNewState{
  final CommonResponseModel commonResponseModel;
  SaveLandDetailsNewStateFail({required this.commonResponseModel});
}