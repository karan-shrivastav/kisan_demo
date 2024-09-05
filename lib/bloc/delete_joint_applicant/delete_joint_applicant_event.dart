import 'package:equatable/equatable.dart';

abstract class DeleteJointApplicantEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class DeleteJointApplicant extends DeleteJointApplicantEvent {
  int id;
  DeleteJointApplicant({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
