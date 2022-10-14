class GetCartModel {
  bool? status;
  late GetCartData data;

  //named constructor
  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? GetCartData.fromJSon(json['data']) : null)!;
  }
}

class GetCartData {
  List<CartItems> cart_items = [];
  dynamic subTotal;
  dynamic total;
//named constructor
  GetCartData.fromJSon(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    total = json['total'];
    json['cart_items'].forEach((element) {
      cart_items.add(CartItems.fromJSon(element));
    });
  }
}

class CartItems {
  int? id;
  late int quantity;
  CartProduct? product;

//named constructor
  CartItems.fromJSon(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? CartProduct.fromJson(json['product']) : null;
  }
}

class CartProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  //named constructor
  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
