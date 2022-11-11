class WhishlistModel {
  String? message;
  Data? data;

  WhishlistModel({this.message, this.data});

  WhishlistModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  List<Wishlist>? wishlist;
  int? user;

  Data({this.id, this.wishlist, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Wishlist.fromJson(v));
      });
    }
    user = json['user'];
  }
}

class Wishlist {
  int? courseId;
  String? courseName;
  String? courseImage;
  int? rating;
  String? autherName;
  Section? section;
  double? price;

  Wishlist(
      {this.courseId,
      this.courseName,
      this.courseImage,
      this.rating,
      this.autherName,
      this.section,
      this.price});

  Wishlist.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseImage = json['course_image'];
    rating = json['rating'];
    autherName = json['auther_name'];
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
    price = json['price'];
  }
}

class Section {
  int? id;
  String? name;
  int? amountPerc;
  bool? isActive;

  Section({this.id, this.name, this.amountPerc, this.isActive});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amountPerc = json['amount_perc'];
    isActive = json['is_active'];
  }
}
