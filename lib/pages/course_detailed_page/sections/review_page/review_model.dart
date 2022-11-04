class ReviewModel {
  String? status;
  List<Data>? data;

  ReviewModel({this.status, this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    data['course'] = this.course;
    return data;
  }
}
