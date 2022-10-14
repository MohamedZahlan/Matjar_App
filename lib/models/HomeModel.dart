class HomeModel {
  bool? status;
  HomeData? data;

  // named constructor
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<BannersData> banners = [];

  List<ProductsData> products = [];

  // named constructor
  HomeData.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJSon(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsData.fromJson(element));
    });
  }
}

class BannersData {
  dynamic id;
  String? image;

  //named constructor
  BannersData.fromJSon(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsData {
  dynamic id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  //named constructor
  ProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
