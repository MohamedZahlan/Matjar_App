class FAQModel {
  bool? status;
  FAQData? data;

  FAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FAQData.fromJson(json["data"]) : null;
  }
}

class FAQData {
  List<FAQDetialsData> data = [];

  FAQData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FAQDetialsData.fromJson(element));
    });
  }
}

class FAQDetialsData {
  dynamic id;
  String? question;
  String? answer;

  FAQDetialsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
