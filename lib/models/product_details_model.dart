class ProductDetailsModel {
  late bool status;
  late ProductDetailsData data;

  //named constructor
  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null
        ? ProductDetailsData.fromJson(json['data'])
        : null)!;
  }
}

class ProductDetailsData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String name;
  late String description;
  late bool inCart;
  late bool inFav;
  List<String> images = [];

  //named constructor
  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    description = json['description'];
    inCart = json['in_cart'];
    inFav = json['in_favorites'];
    images = json['images'].cast<String>();
  }
}
