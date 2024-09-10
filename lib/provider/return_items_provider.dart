import 'package:flutter/foundation.dart';
import 'package:x_pro_delivery_app/model/item_list_model.dart';

class ReturnedItemsProvider with ChangeNotifier {
  final List<ItemListModel> _returnedItems = [];

  List<ItemListModel> get returnedItems => _returnedItems;

  void addReturnedItems(List<ItemListModel> items) {
    _returnedItems.addAll(items);
    notifyListeners();
  }

  void clearReturnedItems() {
    _returnedItems.clear();
    notifyListeners();
  }
}
