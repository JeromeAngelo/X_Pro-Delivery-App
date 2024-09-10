class TripSummaryModel {
  final String tripId;
  final String plateNumber;
  final String driverName;
  final int numberOfHelper;
  final String helper1;
  final String helper2;
  final int activeDeliveries;
  final int totalDelivered;
  final int totalKM;
  final String deliveryStatus;
  final DateTime dateTime;

  TripSummaryModel(
      {required this.tripId,
      required this.plateNumber,
      required this.driverName,
      required this.numberOfHelper,
      required this.helper1,
      required this.helper2,
      required this.activeDeliveries,
      required this.totalDelivered,
      required this.totalKM,
      required this.deliveryStatus,
      required this.dateTime});
}
