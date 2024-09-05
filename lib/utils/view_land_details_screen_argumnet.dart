class ViewLandDetailsScreenArgument {
  final String state;
  final int farmerId;
  final int stateMasterId;
  final int districtMasterId;
  final int villageId;
  final int ownershipId;
  final int areaUnitId;
  final int sourceOfIrrigationId;
  final String irrigatedLand;
  final int unIrrigatedLand;
  final String district;
  final String village;
  final String ownership;
  final String encumbered;
  final String area;
  final String sourceOfIrrigation;
  final double onWhichIrrigated;
  final double onWhichNonIrrigated;
  final String surveyNumber;

  ViewLandDetailsScreenArgument(
      {required this.state,
        required this.farmerId,
        required this.stateMasterId,
        required this.districtMasterId,
        required this.villageId,
        required this.ownershipId,
        required this.areaUnitId,
        required this.sourceOfIrrigationId,
        required this.irrigatedLand,
        required this.unIrrigatedLand,
        required this.district,
      required this.village,
      required this.ownership,
      required this.encumbered,
      required this.area,
      required this.sourceOfIrrigation,
      required this.onWhichIrrigated,
      required this.onWhichNonIrrigated,
      required this.surveyNumber});
}
