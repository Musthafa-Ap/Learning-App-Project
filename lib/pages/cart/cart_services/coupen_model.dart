class CoupencodeModel {
  String? message;
  int? cartId;
  double? totalAmount;
  double? discountAmount;
  double? grandTotal;
  int? user;
  String? promoCode;

  CoupencodeModel(
      {this.message,
      this.cartId,
      this.totalAmount,
      this.discountAmount,
      this.grandTotal,
      this.user,
      this.promoCode});

  CoupencodeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    cartId = json['cart_id'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    grandTotal = json['grand_total'];
    user = json['user'];
    promoCode = json['promo_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['cart_id'] = this.cartId;
    data['total_amount'] = this.totalAmount;
    data['discount_amount'] = this.discountAmount;
    data['grand_total'] = this.grandTotal;
    data['user'] = this.user;
    data['promo_code'] = this.promoCode;
    return data;
  }
}
