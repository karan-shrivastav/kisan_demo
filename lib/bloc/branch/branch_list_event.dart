import 'package:equatable/equatable.dart';

abstract class BranchListNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetNewBranchList extends BranchListNewEvent{
  final Map<String, dynamic> branchListRequest;
  GetNewBranchList({required this.branchListRequest});
  @override
  List<Object?> get props => [branchListRequest];
}