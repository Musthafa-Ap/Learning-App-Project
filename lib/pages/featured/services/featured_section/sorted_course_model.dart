class SortedCourseModel {
  String? message;
  List<Data>? data;

  SortedCourseModel({this.message, this.data});

  SortedCourseModel.fromJson(Map<String, dynamic> json) {
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
  String? courseName;
  String? description;
  double? price;
  double? offerPrice;
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

  Data(
      {this.id,
      this.courseName,
      this.description,
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
    id = json['id'];
    courseName = json['course_name'];
    description = json['description'];
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
    ratingCount = json['rating_count'];
  }
}

class SubCategory {
  int? id;
  String? subCatehoryName;
  bool? isActive;
  int? category;

  SubCategory({this.id, this.subCatehoryName, this.isActive, this.category});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCatehoryName = json['sub_catehory_name'];
    isActive = json['is_active'];
    category = json['category'];
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
}

class Instructor {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? dob;
  String? mobile;
  String? address;
  String? userSocialId;
  String? isActive;
  String? isAdmin;
  String? isStaff;
  String? password;
  String? profilePic;
  String? lastLogin;
  bool? isSuperuser;
  String? imagePpoi;
  bool? isInstructor;
  String? instructorDocs;
  List? groups;
  List? userPermissions;

  Instructor(
      {this.id,
      this.name,
      this.email,
      this.gender,
      this.dob,
      this.mobile,
      this.address,
      this.userSocialId,
      this.isActive,
      this.isAdmin,
      this.isStaff,
      this.password,
      this.profilePic,
      this.lastLogin,
      this.isSuperuser,
      this.imagePpoi,
      this.isInstructor,
      this.instructorDocs,
      this.groups,
      this.userPermissions});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    mobile = json['mobile'];
    address = json['address'];
    userSocialId = json['user_social_id'];
    isActive = json['is_active'];
    isAdmin = json['is_admin'];
    isStaff = json['is_staff'];
    password = json['password'];
    profilePic = json['profile_pic'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    imagePpoi = json['image_ppoi'];
    isInstructor = json['is_instructor'];
    instructorDocs = json['instructor_docs'];
    if (json['groups'] != null) {
      groups = [];

      groups!.add((json['groups']));
    }
    if (json['user_permissions'] != null) {
      userPermissions = [];

      userPermissions!.add(json['user_permissions']);
    }
  }
}
