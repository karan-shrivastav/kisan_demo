import 'package:equatable/equatable.dart';

abstract class SaveOtherDetailsNewEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class SaveOtherDetailsNew extends SaveOtherDetailsNewEvent{
  final Map<String, dynamic> bodyRequest;
  SaveOtherDetailsNew({required this.bodyRequest});
}

class ResetStateOfSaveOtherDetailsNew extends SaveOtherDetailsNewEvent{

}