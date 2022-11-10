class FAQModel {
  String? message;
  List<Data>? data;

  FAQModel({this.message, this.data});

  FAQModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? questions;
  String? answer;

  Data({this.questions, this.answer});

  Data.fromJson(Map<String, dynamic> json) {
    questions = json['questions'];
    answer = json['answer'];
  }
}
