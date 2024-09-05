import 'package:equatable/equatable.dart';

import '../../model/response/common_response_model.dart';
import '../../model/response/get_pacs_list_response_model.dart';

abstract class PacsListNewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPacsListNewInitial extends PacsListNewState {}

class GetPacsListNewLoading extends PacsListNewState {}

class GetPacsListNewSuccess extends PacsListNewState {
  final PacsListNewResponseModel pacsListNewResponseModel;

  GetPacsListNewSuccess({required this.pacsListNewResponseModel});

  @override
  List<Object?> get props => [pacsListNewResponseModel];
}

class GetPacsListNewFail extends PacsListNewState {
  final CommonResponseModel commonResponseModel;

  GetPacsListNewFail({required this.commonResponseModel});

  @override
  List<Object?> get props => [commonResponseModel];
}
