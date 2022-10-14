class SettingsModel {
  bool? status;
  SettingsData? data;
  //named constructor
  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SettingsData.fromJson(json['data']) : null;
  }
}

class SettingsData {
  String? about;
  String? terms;

  //named constructor
  SettingsData.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }
}
