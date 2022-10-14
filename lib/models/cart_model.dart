class CartModel {
  bool? status;
  String? message;
  CartData? data;

  //named constructor
  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? CartData.fromJson(json['data']) : null)!;
  }
}

class CartData {
  int? id;
  int? quantity;
  CartProduct? product;

  //named constructor
  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = (json['product'] != null
        ? CartProduct.fromJson(json['product'])
        : null)!;
  }
}

class CartProduct {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;

  //named constructor
  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
