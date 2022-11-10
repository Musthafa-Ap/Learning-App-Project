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
}
