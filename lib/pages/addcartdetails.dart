import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/itemsmodel.dart';
import 'package:shoppingcart/providers/bottomprovider.dart';
import '../providers/addcartprovider.dart';

class AddCartDetailsPage extends StatelessWidget {
  const AddCartDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCartProvider>(
      builder: (_, value, __) {
        return value.getItemModelList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your cart is empty',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.grey.withOpacity(0.4)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: () {
                        context
                            .read<BottomAppProvider>()
                            .updateBottomIndex(index: 0);
                      },
                      child: const Text('Shop Now'),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Card(
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            NumberFormat.currency(
                              symbol: '₹',
                              decimalDigits: 2,
                            ).format(
                              value.getItemModelList
                                  .map(
                                    (e) => int.parse(e.getItemPrice),
                                  )
                                  .reduce((value, element) => value + element),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.getItemModelList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      itemBuilder: (context, index) {
                        ItemModel model = ItemModel(
                            itemName: value.getItemModelList
                                .elementAt(index)
                                .getItemName,
                            itemImage: value.getItemModelList
                                .elementAt(index)
                                .getItemImage,
                            itemPrice: value.getItemModelList
                                .elementAt(index)
                                .getItemPrice);
                        return SizedBox(
                          height: 100,
                          child: Card(
                            child: Center(
                              child: ListTile(
                                leading: Image.network(
                                  model.getItemImage,
                                  width: 100,
                                ),
                                title: Text(model.getItemName),
                                subtitle: Text(model.getItemPrice.toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        if (value.getItemModelList
                                            .elementAt(index)
                                            .getItemName
                                            .isNotEmpty) {
                                          value.removeToCart(model: model);
                                        }
                                      },
                                      minWidth: 50,
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      child: const Text('Remove'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
