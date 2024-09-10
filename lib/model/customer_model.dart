class CustomerModel {
  CustomerModel({
    required this.customerName,
    required this.location,
    required this.invoiceNumber,
    required this.totalAmount,
    required this.modeOfPayment,
  });

  final String customerName;
  final String location;
  final int invoiceNumber;
  final int totalAmount;
  final String modeOfPayment;
}
