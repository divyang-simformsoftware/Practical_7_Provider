import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/providers/addcartprovider.dart';

class AppBottom {
  static List<BottomNavigationBarItem> appBottomList = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(
      icon: Selector<AddCartProvider, int>(
        builder: (_, value, __) {
          return Badge(
            label: Text(value.toString()),
            isLabelVisible: value != 0 ? true : false,
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.shopping_cart,
            ),
          );
        },
        selector: (_, value) {
          return value.getItemModelList.length;
        },
      ),
      label: 'MyCart',
    ),
  ];
}
