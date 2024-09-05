import 'package:equatable/equatable.dart';

abstract class AddAddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAddress extends AddAddressEvent {
  final List<Map<String, dynamic>> bodyRequest;
  final bool isSameAddress;
  AddAddress({required this.bodyRequest, required this.isSameAddress});

  @override
  List<Object?> get props => [bodyRequest];
}
