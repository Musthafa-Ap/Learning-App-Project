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
  String? iconImage;

  Data({this.id, this.categoryName, this.iconImage});

  Data.fromJson(Map<String, dynamic> json) {
    iconImage = json['category_icon_image'];
    id = json['id'];
    categoryName = json['category_name'];
  }
}
