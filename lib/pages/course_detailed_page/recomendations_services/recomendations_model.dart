class RecomendationsModel {
  String? message;
  List<Data>? data;

  RecomendationsModel({this.message, this.data});

  RecomendationsModel.fromJson(Map<String, dynamic> json) {
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
  String? courseName;
  double? price;
  int? offerPrice;
  SubCategory? subCategory;
  String? createdAt;
  String? updatedAt;
  bool? featuredCourse;
  bool? recommendedCourse;
  Thumbnail? thumbnail;
  Instructor? instructor;
  String? introVideo;
  int? rating;

  Data(
      {this.id,
      this.courseName,
      this.price,
      this.offerPrice,
      this.subCategory,
      this.createdAt,
      this.updatedAt,
      this.featuredCourse,
      this.recommendedCourse,
      this.thumbnail,
      this.instructor,
      this.introVideo,
      this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    price = json['price'];
    offerPrice = json['offer_price'];
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredCourse = json['featured_course'];
    recommendedCourse = json['recommended_course'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    introVideo = json['intro_video'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['featured_course'] = this.featuredCourse;
    data['recommended_course'] = this.recommendedCourse;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.instructor != null) {
      data['instructor'] = this.instructor!.toJson();
    }
    data['intro_video'] = this.introVideo;
    data['rating'] = this.rating;
    return data;
  }
}

class SubCategory {
  int? id;
  String? subCatehoryName;
  int? category;

  SubCategory({this.id, this.subCatehoryName, this.category});

  SubCategory.fromJson(Map<String, dynamic> json) {
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

class Thumbnail {
  String? fullSize;
  String? thumbnail;

  Thumbnail({this.fullSize, this.thumbnail});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    fullSize = json['full_size'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_size'] = this.fullSize;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Instructor {
  String? name;
  Thumbnail? profilePic;
  String? phone;
  String? email;
  String? details;

  Instructor(
      {this.name, this.profilePic, this.phone, this.email, this.details});

  Instructor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePic = json['profile_pic'] != null
        ? new Thumbnail.fromJson(json['profile_pic'])
        : null;
    phone = json['phone'];
    email = json['email'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.profilePic != null) {
      data['profile_pic'] = this.profilePic!.toJson();
    }
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['details'] = this.details;
    return data;
  }
}
