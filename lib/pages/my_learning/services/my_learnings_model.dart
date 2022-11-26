class MyLearningsModel {
  String? status;
  List<Data>? data;

  MyLearningsModel({this.status, this.data});

  MyLearningsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? courseId;
  double? itemTotal;
  int? order;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  String? variant;
  int? rating;
  int? ratingCount;

  Data(
      {this.rating,
      this.ratingCount,
      this.courseId,
      this.itemTotal,
      this.order,
      this.instructorName,
      this.courseName,
      this.courseThumbnail,
      this.variant});

  Data.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    ratingCount = json['rating_count'];
    variant = json['section_id'];
    courseId = json['course_id'];
    itemTotal = json['item_total'];
    order = json['order'];
    instructorName = json['instructor_name'];
    courseName = json['course_name'];
    courseThumbnail = json['course_thumbnail'];
  }
}
