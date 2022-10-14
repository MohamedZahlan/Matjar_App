class OrderModel {
  bool? status;
  OrderData? data;
  //named constructor
  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }
}

class OrderData {
  int? current_page;
  int? total;
  List<Data> data = [];
  //named constructor
  OrderData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    total = json['total'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  dynamic id;
  dynamic total;
  String? date;
  String? status;

  //named constructor
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
