class SubCatagoriesModel {
  String? message;
  List<Data>? data;

  SubCatagoriesModel({this.message, this.data});

  SubCatagoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? subCatehoryName;
  int? category;

  Data({this.id, this.subCatehoryName, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCatehoryName = json['sub_catehory_name'];
    category = json['category'];
  }
}
