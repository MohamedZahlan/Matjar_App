class SearchModel {
  bool? status;
  String? message;
  Data? data;

  //named constructor
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? current_page;
  List<Product> data = [];
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  String? path;
  int? per_page;
  int? to;
  int? total;

  //named constructor
  Data.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    first_page_url = json['first_page_url'];
    from = json['from'];
    last_page = json['last_page'];
    last_page_url = json['last_page_url'];
    path = json['path'];
    per_page = json['per_page'];
    to = json['to'];
    total = json['total'];

    json['data'].forEach((element) {
      data.add(Product.fromJson(element));
    });
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  //named constructor
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
