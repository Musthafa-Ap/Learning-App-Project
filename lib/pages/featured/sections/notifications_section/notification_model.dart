class NotificationModel {
  String? message;
  List<Data>? data;

  NotificationModel({this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
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
  String? mainIdentifier;
  String? subIdentifier;
  String? messageTitle;
  int? userId;
  String? notificationImage;
  String? createdAt;

  Data(
      {this.id,
      this.mainIdentifier,
      this.subIdentifier,
      this.messageTitle,
      this.userId,
      this.notificationImage,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainIdentifier = json['main_identifier'];
    subIdentifier = json['sub_identifier'];
    messageTitle = json['message_title'];
    userId = json['user_id'];
    notificationImage = json['notification_image'];
    createdAt = json['created_at'];
  }
}
