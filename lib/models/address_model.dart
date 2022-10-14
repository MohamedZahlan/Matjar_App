class AddressModel {
  bool? status;
  AddressData? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AddressData.fromJson(json['data']) : null;
  }
}

class AddressData {
  dynamic current_page;
  int? total;
  List<Data> data = [];

  AddressData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    total = json['total'];
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  dynamic id;
  String? name;
  String? city;
  String? government;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    government = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
