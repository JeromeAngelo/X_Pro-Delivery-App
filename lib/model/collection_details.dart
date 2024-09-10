class CollectionDetails {
  CollectionDetails({
    required this.customerName,
    required this.totalAmount,
    required this.modeOfPayment,
    required this.collectionDate,
  });

  final String customerName;
  final double totalAmount;
  final String modeOfPayment;
  final DateTime collectionDate;
}
