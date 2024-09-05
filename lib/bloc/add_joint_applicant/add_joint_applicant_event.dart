import 'package:equatable/equatable.dart';

abstract class AddJointApplicantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddJointApplicantDetails extends AddJointApplicantEvent {
  final Map<String, dynamic> body;
  AddJointApplicantDetails({
    required this.body,
  });
  @override
  List<Object?> get props => [body];
}
