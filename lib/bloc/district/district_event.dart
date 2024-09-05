import 'package:equatable/equatable.dart';

abstract class DistrictEventNew extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllDistrictByState extends DistrictEventNew {
  final Map<String, dynamic> districtRequest;

  GetAllDistrictByState({required this.districtRequest});

  @override
  List<Object?> get props => [districtRequest];
}

class ClearAllDistrict extends DistrictEventNew{

}