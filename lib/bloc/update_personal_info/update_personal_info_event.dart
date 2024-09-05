import 'package:equatable/equatable.dart';

abstract class UpdatePersonalInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePersonalInfoDetails extends UpdatePersonalInfoEvent {
  int farmerId;
  final Map<String, dynamic> body;
  UpdatePersonalInfoDetails({
    required this.body,
    required this.farmerId,
  });
  @override
  List<Object?> get props => [body, farmerId];
}
