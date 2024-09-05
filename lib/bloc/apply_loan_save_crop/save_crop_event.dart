import 'package:equatable/equatable.dart';


abstract class SaveCropNewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveCropNew extends SaveCropNewEvent {
  final Map<String, dynamic> requestBody;
  SaveCropNew({required this.requestBody});

  @override
  List<Object?> get props => [requestBody];
}

class SaveCropNewInitiate extends SaveCropNewEvent {

}