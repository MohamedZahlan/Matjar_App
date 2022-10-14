class DelAddressModel {
  bool? status;
  String? message;
  DelAddressData? data;

  DelAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DelAddressData.fromJson(json['data']);
  }
}

class DelAddressData {
  dynamic id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;

  DelAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
  }
}
