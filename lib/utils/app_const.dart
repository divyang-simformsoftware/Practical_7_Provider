import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcart/pages/addcartdetails.dart';
import 'package:shoppingcart/pages/dashboardpage.dart';

class AppConst {
  AppConst._();
  static final AppConst _appConst = AppConst._();
  factory AppConst() {
    return _appConst;
  }
  static final List<Widget> appWidgetList = [
    const DashBoardPage(),
    const AddCartDetailsPage()
  ];
}
