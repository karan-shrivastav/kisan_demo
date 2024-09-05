import 'package:equatable/equatable.dart';

abstract class AddFamilyMemberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFamilyMember extends AddFamilyMemberEvent {
  final List<Map<String, dynamic>> bodyRequest;

  AddFamilyMember({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}
