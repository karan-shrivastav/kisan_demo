import 'package:equatable/equatable.dart';

abstract class CropNameNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetCropNameList extends CropNameNewEvent{
  final Map<String, dynamic> cropRequest;
  GetCropNameList({required this.cropRequest});
  @override
  List<Object?> get props => [cropRequest];
}
