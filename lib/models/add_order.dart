class AddOrderModel {
  bool? status;
  String? message;
  AddOrderData? data;

  AddOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = AddOrderData.fromJson(json['data']);
  }
}

class AddOrderData {
  dynamic cost;
  dynamic vat;
  dynamic discount;
  dynamic total;
  int? id;

  AddOrderData.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    vat = json['vat'];
    discount = json['cost'];
    total = json['total'];
    id = json['id'];
  }
}
