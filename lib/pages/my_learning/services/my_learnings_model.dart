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
  int? course_id;
  double? itemTotal;
  int? order;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;

  Data(
      {this.course_id,
      this.itemTotal,
      this.order,
      this.instructorName,
      this.courseName,
      this.courseThumbnail});

  Data.fromJson(Map<String, dynamic> json) {
    course_id = json['course_id'];
    itemTotal = json['item_total'];
    order = json['order'];
    instructorName = json['instructor_name'];
    courseName = json['course_name'];
    courseThumbnail = json['course_thumbnail'];
  }
}
