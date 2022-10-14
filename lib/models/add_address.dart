class AddAddressModel {
  bool? status;
  String? message;
  AddAddressData? data;

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AddAddressData.fromJson(json['data']) : null;
  }
}

class AddAddressData {
  dynamic id;
  String? name;
  String? city;
  String? government;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;

  AddAddressData.fromJson(Map<String, dynamic> json) {
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
