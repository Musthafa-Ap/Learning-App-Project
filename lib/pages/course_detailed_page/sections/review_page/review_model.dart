class ReviewModel {
  String? status;
  List<Data>? data;

  ReviewModel({this.status, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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
  int? rating;
  String? review;
  String? createdAt;
  int? user;
  int? course;

  Data(
      {this.id,
      this.rating,
      this.review,
      this.createdAt,
      this.user,
      this.course});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    user = json['user'];
    course = json['course'];
  }
}
