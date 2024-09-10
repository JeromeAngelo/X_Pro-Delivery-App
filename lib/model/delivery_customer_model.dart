class DeliveryCustomerModel {
  final String id;
  final String customerName;
  final String location;

  bool isDeliveryCompleted;

  DeliveryCustomerModel({
    required this.id,
    required this.customerName,
    required this.location,
    this.isDeliveryCompleted = false,
  });
}
