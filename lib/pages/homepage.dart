// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/bottomlist.dart';
import 'package:shoppingcart/providers/bottomprovider.dart';

import 'package:shoppingcart/utils/app_const.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'My Shop',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Selector<BottomAppProvider, int>(
        builder: (context, value, child) =>
            AppConst.appWidgetList.elementAt(value),
        selector: (_, p1) => p1.getBottomIndex,
      ),
      bottomNavigationBar: Consumer<BottomAppProvider>(
        builder: (context, value, _) {
          return BottomNavigationBar(
            fixedColor: Colors.indigo,
            items: List<BottomNavigationBarItem>.generate(
              AppBottom.appBottomList.length,
              (index) {
                return AppBottom.appBottomList.elementAt(index);
              },
            ),
            currentIndex: value.getBottomIndex,
            onTap: (index) {
              value.updateBottomIndex(index: index);
            },
          );
        },
      ),
    );
  }
}
