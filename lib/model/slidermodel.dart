class SliderModel {
  String? sliderImageUrl;
  SliderModel({required this.sliderImageUrl});
  factory SliderModel.fromJSON({required Map map}) {
    return SliderModel(sliderImageUrl: map['imageURL']);
  }
  String get getSliderImageURL => sliderImageUrl ?? "";
}
