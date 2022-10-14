class ChangeFavModel {
  bool? status;
  String? message;
  ChangeFavData? data;

  //named constructor
  ChangeFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = ChangeFavData.fromJson(json['data']);
  }
}

class ChangeFavData {
  int? id;
  ChangeFavProduct? product;

  //named constructor
  ChangeFavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ChangeFavProduct.fromJson(json['product']);
  }
}

class ChangeFavProduct {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;

  //named constructor
  ChangeFavProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
