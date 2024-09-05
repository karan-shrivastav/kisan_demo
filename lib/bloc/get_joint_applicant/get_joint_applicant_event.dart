import 'package:equatable/equatable.dart';

abstract class GetJointApplicantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetJointApplicantList extends GetJointApplicantEvent {
  //final String farmerId;
  final Map<String, dynamic> body;
  GetJointApplicantList({required this.body});
  @override
  List<Object?> get props => [body];
}
