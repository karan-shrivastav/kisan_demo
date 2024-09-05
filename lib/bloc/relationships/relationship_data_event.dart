import 'package:equatable/equatable.dart';

abstract class RelationshipDataEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}

class GetRelationshipList extends RelationshipDataEvent{
  final List<String> bodyRequest;
  GetRelationshipList({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}