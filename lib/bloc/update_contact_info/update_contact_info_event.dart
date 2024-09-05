import 'package:equatable/equatable.dart';

abstract class UpdateContactInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateContactInfoDetails extends UpdateContactInfoEvent {
  bool bothAddressSame;
  final List<Map<String, dynamic>> body;
  UpdateContactInfoDetails({
    required this.body,
    required this.bothAddressSame,
  });
  @override
  List<Object?> get props => [body, bothAddressSame];
}
