import 'package:equatable/equatable.dart';

abstract class LoanDetailsNewPreviewEvent extends Equatable{
  @override
  List<Object?> get props => [];

}
class GetLoanDetailsNewPreviewData extends LoanDetailsNewPreviewEvent{
  final Map<String, dynamic> bodyRequest;
  GetLoanDetailsNewPreviewData ({required this.bodyRequest});
  @override
  List<Object?> get props => [bodyRequest];
}