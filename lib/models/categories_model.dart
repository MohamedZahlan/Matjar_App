class CategoriesModel {
  bool? status;
  CategoriesData? data;
  //named Constructor
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  int? currentPage;
  List<CategoriesDataModel> data = [];

  //named Constructor
  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];

    json['data'].forEach((element) {
      data.add(CategoriesDataModel.fromJson(element));
    });
  }
}

class CategoriesDataModel {
  int? id;
  String? name;
  String? image;

  //named Constructor
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
