import 'package:equatable/equatable.dart';

abstract class PacsListNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetPacsListNew extends PacsListNewEvent{
  final Map<String, dynamic> branchListRequest;
  GetPacsListNew({required this.branchListRequest});
  @override
  List<Object?> get props => [branchListRequest];
}
