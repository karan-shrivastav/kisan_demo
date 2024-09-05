import 'package:equatable/equatable.dart';

abstract class DeleteFamilyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class DeleteFamilyInfoDetails extends DeleteFamilyEvent {
   final int id;
   DeleteFamilyInfoDetails({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
