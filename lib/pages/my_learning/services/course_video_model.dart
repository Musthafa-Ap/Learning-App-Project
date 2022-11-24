class CourseVideoModel {
  String? status;
  List<Data>? data;

  CourseVideoModel({this.status, this.data});

  CourseVideoModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? topicName;
  String? description;
  String? video;
  String? thumbnail;
  int? rating;
  int? ratingCount;
  String? imagePpoi;
  bool? isActive;
  int? course;
  int? section;
  String? videoDuration;

  Data(
      {this.ratingCount,
      this.rating,
      this.videoDuration,
      this.id,
      this.topicName,
      this.description,
      this.video,
      this.thumbnail,
      this.imagePpoi,
      this.isActive,
      this.course,
      this.section});

  Data.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    ratingCount = json['rating_count'];
    videoDuration = json['video_duration'];
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
}
