class FAQModel {
  String? message;
  List<Data>? data;

  FAQModel({this.message, this.data});

  FAQModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions'] = this.questions;
    data['answer'] = this.answer;
    return data;
  }
}
