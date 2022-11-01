class BannerModel {
  String? message;
  List<Data>? data;

  BannerModel({this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
        bannerImg!.add(new BannerImg.fromJson(v));
      });
    }
    description = json['description'];
    publishDate = json['publish_date'];
    expireAt = json['expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.bannerImg != null) {
      data['banner_img'] = this.bannerImg!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['publish_date'] = this.publishDate;
    data['expire_at'] = this.expireAt;
    return data;
  }
}

class BannerImg {
  int? id;
  String? name;
  BannerImage? bannerImage;
  String? action;
  int? actionId;

  BannerImg({this.id, this.name, this.bannerImage, this.action, this.actionId});

  BannerImg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bannerImage = json['banner_img'] != null
        ? new BannerImage.fromJson(json['banner_img'])
        : null;
    action = json['action'];
    actionId = json['action_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.bannerImage != null) {
      data['banner_img'] = this.bannerImage!.toJson();
    }
    data['action'] = this.action;
    data['action_id'] = this.actionId;
    return data;
  }
}

class BannerImage {
  String? fullSize;

  BannerImage({this.fullSize});

  BannerImage.fromJson(Map<String, dynamic> json) {
    fullSize = json['full_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_size'] = this.fullSize;
    return data;
  }
}
