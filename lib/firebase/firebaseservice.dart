import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppingcart/model/itemsmodel.dart';
import 'package:shoppingcart/model/slidermodel.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseService firebaseService = FirebaseService._();
  factory FirebaseService() => firebaseService;
  static final DatabaseReference db = FirebaseDatabase.instance.ref();

  static Stream<List<ItemModel>> getStream() async* {
    try {
      yield* db.child('ItemList').onValue.map(
        (event) {
          List<ItemModel> list = [];
          Map m = event.snapshot.value as Map;
          m.forEach(
            (key, value) {
              list.add(ItemModel.fromJSON(map: value));
              list.sort(
                (a, b) => a.getItemName.compareTo(b.getItemName),
              );
            },
          );
          return list;
        },
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<SliderModel>> getFuture() async {
    return await db.child('SliderData').once().then(
      (value) {
        List<SliderModel> list = [];
        Map m = value.snapshot.value as Map;
        m.forEach((key, value) => list.add(SliderModel.fromJSON(map: value)));
        return list;
      },
    );
  }
}
