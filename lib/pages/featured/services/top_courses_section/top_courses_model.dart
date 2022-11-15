class TopCoursesModel {
  String? message;
  List<Data>? data;
  int? pageCount;
  int? pages;
  bool? hasNext;
  bool? hasPrevious;

  TopCoursesModel(
      {this.message,
      this.data,
      this.pageCount,
      this.pages,
      this.hasNext,
      this.hasPrevious});

  TopCoursesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pageCount = json['page_count'];
    pages = json['pages'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
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
  int? ratingCount;
  bool? isWishList;

  Data(
      {this.isWishList,
      this.id,
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
      this.rating,
      this.ratingCount});

  Data.fromJson(Map<String, dynamic> json) {
    isWishList = json['wish_list'];
    ratingCount = json['rating_count'];
    id = json['id'];
    courseName = json['course_name'];
    price = json['price'];
    offerPrice = json['offer_price'];
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredCourse = json['featured_course'];
    recommendedCourse = json['recommended_course'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
    introVideo = json['intro_video'];
    rating = json['rating'];
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
}

class Thumbnail {
  String? thumbnail;
  String? fullSize;

  Thumbnail({this.thumbnail, this.fullSize});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    fullSize = json['full_size'];
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
        ? Thumbnail.fromJson(json['profile_pic'])
        : null;
    phone = json['phone'];
    email = json['email'];
    details = json['details'];
  }
}
