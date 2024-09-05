import 'package:equatable/equatable.dart';

abstract class GetVillageDataNewListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllVillageByDistrict extends GetVillageDataNewListEvent {
  final Map<String, dynamic> villageRequest;

  GetAllVillageByDistrict({required this.villageRequest});

  @override
  List<Object?> get props => [villageRequest];
}
