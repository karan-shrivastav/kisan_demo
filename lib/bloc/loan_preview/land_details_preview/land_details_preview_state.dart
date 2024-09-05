import 'package:equatable/equatable.dart';

import '../../../model/response/common_response_model.dart';
import '../../../model/response/land_details_preview_response_model.dart';

abstract class LandDetailsNewPreviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LandDetailsNewPreviewInitial extends LandDetailsNewPreviewState {}

class LandDetailsNewPreviewLoading extends LandDetailsNewPreviewState {}

class LandDetailsNewPreviewSuccess extends LandDetailsNewPreviewState {
  final LandDetailsNewPreviewResponseModel landDetailsNewPreviewResponseModel;

  LandDetailsNewPreviewSuccess(
      {required this.landDetailsNewPreviewResponseModel});

  @override
  List<Object?> get props => [landDetailsNewPreviewResponseModel];
}

class LandDetailsNewPreviewFail extends LandDetailsNewPreviewState {
  final CommonResponseModel commonResponseModel;

  LandDetailsNewPreviewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
