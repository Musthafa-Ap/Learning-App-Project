class OrderDetailesModel {
  String? message;
  List<Data>? data;

  OrderDetailesModel({this.message, this.data});

  OrderDetailesModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  double? grandTotal;
  double? totalAmount;
  double? discountAmount;
  String? paymentMethod;
  String? status;
  int? user;
  int? promoCode;
  String? orderId;
  List<OrderedCourseOrder>? orderedCourseOrder;

  Data(
      {this.id,
      this.createdAt,
      this.grandTotal,
      this.totalAmount,
      this.discountAmount,
      this.paymentMethod,
      this.status,
      this.user,
      this.promoCode,
      this.orderId,
      this.orderedCourseOrder});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    grandTotal = json['grand_total'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    user = json['user'];
    promoCode = json['promo_code'];
    orderId = json['order_id'];
    if (json['ordered_course_order'] != null) {
      orderedCourseOrder = <OrderedCourseOrder>[];
      json['ordered_course_order'].forEach((v) {
        orderedCourseOrder!.add(OrderedCourseOrder.fromJson(v));
      });
    }
  }
}

class OrderedCourseOrder {
  int? courseId;
  double? itemTotal;
  int? order;
  String? instructorName;
  String? courseName;
  String? courseThumbnail;
  String? sectionId;

  OrderedCourseOrder(
      {this.courseId,
      this.itemTotal,
      this.order,
      this.instructorName,
      this.courseName,
      this.courseThumbnail,
      this.sectionId});

  OrderedCourseOrder.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    itemTotal = json['item_total'];
    order = json['order'];
    instructorName = json['instructor_name'];
    courseName = json['course_name'];
    courseThumbnail = json['course_thumbnail'];
    sectionId = json['section_id'];
  }
}
