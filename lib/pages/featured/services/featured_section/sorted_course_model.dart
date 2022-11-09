class SortedCourseModel {
  String? message;
  List<Data>? data;

  SortedCourseModel({this.message, this.data});

  SortedCourseModel.fromJson(Map<String, dynamic> json) {
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
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['description'] = this.description;
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
    data['rating_count'] = this.ratingCount;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_catehory_name'] = this.subCatehoryName;
    data['is_active'] = this.isActive;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['user_social_id'] = this.userSocialId;
    data['is_active'] = this.isActive;
    data['is_admin'] = this.isAdmin;
    data['is_staff'] = this.isStaff;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['last_login'] = this.lastLogin;
    data['is_superuser'] = this.isSuperuser;
    data['image_ppoi'] = this.imagePpoi;
    data['is_instructor'] = this.isInstructor;
    data['instructor_docs'] = this.instructorDocs;
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    if (this.userPermissions != null) {
      data['user_permissions'] =
          this.userPermissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
