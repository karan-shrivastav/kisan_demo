import 'package:equatable/equatable.dart';

abstract class GetFarmerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFarmerDetails extends GetFarmerEvent {
  final Map<String, dynamic> body;
  GetFarmerDetails({required this.body});
  @override
  List<Object?> get props => [body];
}

class ResetFarmerDetails extends GetFarmerEvent {}
