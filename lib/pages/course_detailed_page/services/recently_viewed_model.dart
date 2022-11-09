class RecentlyViewedModel {
  String? status;
  Data? data;

  RecentlyViewedModel({this.status, this.data});

  RecentlyViewedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Datas>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Datas>[];
      json['data'].forEach((v) {
        data!.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  double? coursePrice;
  bool? bestSeller;
  int? rating;
  int? ratingCount;

  Datas(
      {this.id,
      this.instructorName,
      this.courseName,
      this.courseThumbnail,
      this.coursePrice,
      this.bestSeller,
      this.rating,
      this.ratingCount});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorName = json['instructor_name'];
    courseName = json['course_name'];
    courseThumbnail = json['course_thumbnail'];
    coursePrice = json['course_price'];
    bestSeller = json['best_seller'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_name'] = this.instructorName;
    data['course_name'] = this.courseName;
    data['course_thumbnail'] = this.courseThumbnail;
    data['course_price'] = this.coursePrice;
    data['best_seller'] = this.bestSeller;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}
