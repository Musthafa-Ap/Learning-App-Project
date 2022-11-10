class AboutAppModel {
  String? message;
  List<Data>? data;

  AboutAppModel({this.message, this.data});

  AboutAppModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? aboutApp;

  Data({this.id, this.title, this.aboutApp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    aboutApp = json['about_app'];
  }
}
