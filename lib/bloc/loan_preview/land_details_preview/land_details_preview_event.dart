import 'package:equatable/equatable.dart';

abstract class LandDetailsNewPreviewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetLandNewDetailsForPreview extends LandDetailsNewPreviewEvent{
  final Map<String,dynamic> bodyRequest ;
  GetLandNewDetailsForPreview({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}
