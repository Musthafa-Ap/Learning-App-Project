class RecentlyViewedModel {
  String? status;
  Data? data;

  RecentlyViewedModel({this.status, this.data});

  RecentlyViewedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Datas>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Datas>[];
      json['data'].forEach((v) {
        data!.add(Datas.fromJson(v));
      });
    }
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
}
