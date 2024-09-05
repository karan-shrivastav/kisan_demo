import 'package:equatable/equatable.dart';

abstract class LoanAssetPreviewNewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAssetNewPreview extends LoanAssetPreviewNewEvent {
  final Map<String, dynamic> bodyRequest;

  GetAssetNewPreview({required this.bodyRequest});

  @override
  List<Object?> get props => [bodyRequest];
}
