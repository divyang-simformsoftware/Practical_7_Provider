import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/model/slidermodel.dart';
import '../firebase/firebaseservice.dart';
import '../model/itemsmodel.dart';
import '../providers/addcartprovider.dart';
import '../providers/indicatorprovider.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureProvider<List<SliderModel>>(
            create: (context) => FirebaseService.getFuture(),
            initialData: const [],
            builder: (context, child) {
              return Consumer2<List<SliderModel>, IndicatorProvider>(
                builder: (_, value, i, __) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        items: List.generate(
                          value.length,
                          (index) {
                            SliderModel model = SliderModel(
                                sliderImageUrl:
                                    value.elementAt(index).getSliderImageURL);
                            return Image.network(
                              model.getSliderImageURL,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                        options: CarouselOptions(
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) =>
                              i.updateIndex(index: index),
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          value.length,
                          (index) => AnimatedContainer(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i.getIndex == index
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            width: 20,
                            duration: const Duration(milliseconds: 500),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
          StreamProvider<List<ItemModel>>(
            create: (BuildContext context) => FirebaseService.getStream(),
            initialData: ItemModel.getInitialList,
            child: Consumer<List<ItemModel>>(
              builder: (context, value, child) {
                return value.isEmpty
                    ? const Center(child: CupertinoActivityIndicator())
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel(
                              itemName: value.elementAt(index).getItemName,
                              itemImage: value.elementAt(index).getItemImage,
                              itemPrice: value.elementAt(index).getItemPrice);

                          return SizedBox(
                            height: 100,
                            child: Card(
                              child: Center(
                                child: ListTile(
                                  leading: Image.network(
                                    model.getItemImage,
                                    width: 100,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Icon(
                                          Icons.error,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    model.getItemName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(model.getItemPrice.toString()),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Consumer<AddCartProvider>(
                                        builder: (context, value, child) {
                                          return MaterialButton(
                                            onPressed: value.checkItemAvail(
                                                    model: model)
                                                ? () {
                                                    value.removeToCart(
                                                        model: model);
                                                  }
                                                : () {
                                                    value.addToCart(
                                                        model: model);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Added To MyCart'),
                                                        duration: Duration(
                                                            milliseconds: 200),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                      ),
                                                    );
                                                  },
                                            minWidth: 80,
                                            color: value.checkItemAvail(
                                                    model: model)
                                                ? Colors.red
                                                : Colors.indigo,
                                            textColor: Colors.white,
                                            child: Icon(value.checkItemAvail(
                                                    model: model)
                                                ? Icons.check
                                                : Icons
                                                    .add_shopping_cart_outlined),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
