import 'package:equatable/equatable.dart';

abstract class GetLandDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLandListData extends GetLandDataEvent {
  final Map<String, dynamic> landRequest;
  GetLandListData({required this.landRequest});
  @override
  List<Object?> get props => [landRequest];
}
