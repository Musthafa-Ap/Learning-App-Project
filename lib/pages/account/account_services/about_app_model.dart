class AboutAppModel {
  String? message;
  List<Data>? data;

  AboutAppModel({this.message, this.data});

  AboutAppModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? aboutApp;

  Data({this.id, this.title, this.aboutApp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    aboutApp = json['about_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['about_app'] = this.aboutApp;
    return data;
  }
}
