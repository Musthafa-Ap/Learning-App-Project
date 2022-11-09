class CourseVideoModel {
  String? status;
  List<Data>? data;

  CourseVideoModel({this.status, this.data});

  CourseVideoModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? topicName;
  String? description;
  String? video;
  String? thumbnail;
  String? imagePpoi;
  bool? isActive;
  int? course;
  int? section;

  Data(
      {this.id,
      this.topicName,
      this.description,
      this.video,
      this.thumbnail,
      this.imagePpoi,
      this.isActive,
      this.course,
      this.section});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicName = json['topic_name'];
    description = json['description'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    imagePpoi = json['image_ppoi'];
    isActive = json['is_active'];
    course = json['course'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic_name'] = this.topicName;
    data['description'] = this.description;
    data['video'] = this.video;
    data['thumbnail'] = this.thumbnail;
    data['image_ppoi'] = this.imagePpoi;
    data['is_active'] = this.isActive;
    data['course'] = this.course;
    data['section'] = this.section;
    return data;
  }
}
