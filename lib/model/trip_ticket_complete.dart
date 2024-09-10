class TripTicketComplete {
  final String tripId;
  final List<CustomerInformations> customerList;
  final List<CheckList> checkList;
  final List<DeliveryTeamInformation> deliveryTeam;
  final DateTime dateTime;

  TripTicketComplete(
      {required this.tripId,
      required this.customerList,
      required this.checkList,
      required this.deliveryTeam,
      required this.dateTime});
}

class CustomerInformations {
  final String deliveryNum;
  final String storeName;
  final String ownerName;
  final String storeAddress;
  final String latitude;
  final String longitude;
  final List phoneNumber;
  final List<InvoicesDetails> invoiceDetails;
  final double totalAmount;
  final String paymentMethode;

  CustomerInformations(
      {required this.deliveryNum,
      required this.storeName,
      required this.ownerName,
      required this.storeAddress,
      required this.latitude,
      required this.longitude,
      required this.phoneNumber,
      required this.invoiceDetails,
      required this.totalAmount,
      required this.paymentMethode});
}

class InvoicesDetails {
  final String invNumber;
  final List<ProductInformations> productInformations;

  InvoicesDetails({required this.invNumber, required this.productInformations});
}

class ProductInformations {
  final String productName;
  final int productQuantity;
  final double productPrice;
  final String productDescription;
  final String unit;
  //Image
  ProductInformations(
      {required this.productName,
      required this.productQuantity,
      required this.productPrice,
      required this.unit,
      required this.productDescription});
}

class CheckList {
  final String name;

  bool isChecked;

  CheckList({required this.name, this.isChecked = false});
}

class DeliveryTeamInformation {
  final String tripId;
  final String name;
  final String numberOfHelpers;
  final String helper1;
  final String helper2;
  final String plateNumber;
  final String vehicleType;
  final String vehicleBrand;
  final String odometer;
  final String activeDelivery;
  final String totalDelivered;
  final String activeLocation;
  final String totalDistance;

  DeliveryTeamInformation(
      {required this.tripId,
      required this.name,
      required this.numberOfHelpers,
      required this.helper1,
      required this.helper2,
      required this.vehicleType,
      required this.vehicleBrand,
      required this.odometer,
      required this.plateNumber,
      required this.activeDelivery,
      required this.totalDelivered,
      required this.activeLocation,
      required this.totalDistance});
}
