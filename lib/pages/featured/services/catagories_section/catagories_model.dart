class CatagoriesModel {
  String? message;
  List<Data>? data;

  CatagoriesModel({this.message, this.data});

  CatagoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;

  Data({this.id, this.categoryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }
}
