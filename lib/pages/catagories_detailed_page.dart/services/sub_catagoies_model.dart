class SubCatagoriesModel {
  String? message;
  List<Data>? data;

  SubCatagoriesModel({this.message, this.data});

  SubCatagoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? subCatehoryName;
  int? category;

  Data({this.id, this.subCatehoryName, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCatehoryName = json['sub_catehory_name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_catehory_name'] = this.subCatehoryName;
    data['category'] = this.category;
    return data;
  }
}
