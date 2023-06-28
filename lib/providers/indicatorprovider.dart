import 'package:flutter/material.dart';

class IndicatorProvider with ChangeNotifier {
  int _index = 0;
  void updateIndex({required int index}) {
    _index = index;
    notifyListeners();
  }

  int get getIndex => _index;
}
