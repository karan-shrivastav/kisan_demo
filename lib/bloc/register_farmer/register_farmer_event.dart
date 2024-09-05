import 'package:equatable/equatable.dart';

abstract class RegisterFarmerEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class RegisterFarmer extends RegisterFarmerEvent{
  final Map<String,dynamic> bodyRequest;
  RegisterFarmer({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}

class CreateFarmerUserInfo extends RegisterFarmerEvent{
  final Map<String,dynamic> bodyRequest;
  CreateFarmerUserInfo({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}