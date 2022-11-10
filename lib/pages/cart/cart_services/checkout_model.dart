class CheckoutModel {
  String? message;
  Data? data;

  CheckoutModel({this.message, this.data});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  double? grandTotal;
  double? totalAmount;
  double? discountAmount;
  String? paymentMethod;
  int? user;
  String? promoCode;

  Data(
      {this.id,
      this.grandTotal,
      this.totalAmount,
      this.discountAmount,
      this.paymentMethod,
      this.user,
      this.promoCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grandTotal = json['grand_total'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    paymentMethod = json['payment_method'];
    user = json['user'];
    promoCode = json['promo_code'];
  }
}
