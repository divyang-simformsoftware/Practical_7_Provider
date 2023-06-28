class ItemModel {
  String? itemName;
  String? itemImage;
  String? itemPrice;

  ItemModel(
      {required this.itemName,
      required this.itemImage,
      required this.itemPrice});

  factory ItemModel.fromJSON({required Map map}) {
    return ItemModel(
      itemName: map['itemName'],
      itemImage: map['itemImage'],
      itemPrice: map['itemPrice'],
    );
  }
  String get getItemName => itemName ?? "";
  String get getItemImage => itemImage ?? "";
  String get getItemPrice => itemPrice ?? "";

  static List<ItemModel> get getInitialList => [];
}
