import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/relationship_response_model.dart';

abstract class RelationshipDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRelationshipInitial extends RelationshipDataState {}

class GetRelationshipLoading extends RelationshipDataState {}

class GetRealationshipSuccess extends RelationshipDataState {
  final RelationshipDataModel getRealtionshipResponseModel;

  GetRealationshipSuccess({required this.getRealtionshipResponseModel});

  @override
  List<Object?> get props => [getRealtionshipResponseModel];
}

class GetRealtioanshipFail extends RelationshipDataState {
  final CommonResponseModel commonResponseModel;

  GetRealtioanshipFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
