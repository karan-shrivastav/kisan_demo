import 'package:equatable/equatable.dart';

abstract class DeleteLandDataEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteLandData extends DeleteLandDataEvent {
  final int id;

  DeleteLandData({required this.id});

  @override
  List<Object?> get props => [id];
}
