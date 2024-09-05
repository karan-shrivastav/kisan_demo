import 'package:equatable/equatable.dart';

abstract class SaveLandDetailsNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SaveLandDetailsNew extends SaveLandDetailsNewEvent{
  final Map<String, dynamic> requestBody;
  SaveLandDetailsNew({required this.requestBody});
  @override
  List<Object?> get props => [requestBody];
}
