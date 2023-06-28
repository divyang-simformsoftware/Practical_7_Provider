import 'package:flutter/material.dart';
import 'package:shoppingcart/model/itemsmodel.dart';

class AddCartProvider with ChangeNotifier {
  final List<ItemModel> _itemModelList = [];

  void addToCart({required ItemModel model}) {
    _itemModelList.add(model);
    notifyListeners();
  }

  void removeToCart({required ItemModel model}) {
    if (_itemModelList.isNotEmpty) {
      _itemModelList
          .removeWhere((element) => element.getItemName == model.getItemName);
      notifyListeners();
    }
  }

  bool checkItemAvail({required ItemModel model}) {
    var v = _itemModelList
        .where((element) => element.getItemName == model.getItemName);
    return v.isNotEmpty ? true : false;
  }

  List<ItemModel> get getItemModelList {
    _itemModelList.sort(
      (a, b) => a.getItemName.compareTo(b.getItemName),
    );
    return _itemModelList;
  }
}
