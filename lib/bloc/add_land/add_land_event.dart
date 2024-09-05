import 'package:equatable/equatable.dart';

abstract class AddLandDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddLandDetailsData extends AddLandDataEvent {
  final Map<String, dynamic> landRequest;
  AddLandDetailsData({required this.landRequest});
  @override
  List<Object?> get props => [landRequest];
}
