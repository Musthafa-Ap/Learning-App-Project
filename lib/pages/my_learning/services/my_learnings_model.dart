class MyLearningsModel {
  String? status;
  List<Data>? data;

  MyLearningsModel({this.status, this.data});

  MyLearningsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.course_id;
    data['item_total'] = this.itemTotal;
    data['order'] = this.order;
    data['instructor_name'] = this.instructorName;
    data['course_name'] = this.courseName;
    data['course_thumbnail'] = this.courseThumbnail;
    return data;
  }
}
