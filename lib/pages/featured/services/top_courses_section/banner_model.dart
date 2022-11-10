class BannerModel {
  String? message;
  List<Data>? data;

  BannerModel({this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  List<BannerImg>? bannerImg;
  String? description;
  String? publishDate;
  String? expireAt;

  Data(
      {this.id,
      this.name,
      this.bannerImg,
      this.description,
      this.publishDate,
      this.expireAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['banner_img'] != null) {
      bannerImg = <BannerImg>[];
      json['banner_img'].forEach((v) {
        bannerImg!.add(BannerImg.fromJson(v));
      });
    }
    description = json['description'];
    publishDate = json['publish_date'];
    expireAt = json['expire_at'];
  }
}

class BannerImg {
  String? bannerImg;
  int? actionId;

  BannerImg({this.bannerImg, this.actionId});

  BannerImg.fromJson(Map<String, dynamic> json) {
    bannerImg = json['banner_img'];
    actionId = json['action_id'];
  }
}
