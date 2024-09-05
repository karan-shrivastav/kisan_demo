import 'package:equatable/equatable.dart';

abstract class PreviewBasicsDetailsEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetPreviewBasicsDetails extends PreviewBasicsDetailsEvent{
  final Map<String,dynamic> bodyRequest ;
  GetPreviewBasicsDetails({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}
