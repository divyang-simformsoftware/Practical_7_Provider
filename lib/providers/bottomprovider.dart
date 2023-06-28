import 'package:flutter/material.dart';

class BottomAppProvider with ChangeNotifier {
  int _index = 0;
  void updateBottomIndex({required int index}) {
    _index = index;
    notifyListeners();
  }

  int get getBottomIndex => _index;
}
