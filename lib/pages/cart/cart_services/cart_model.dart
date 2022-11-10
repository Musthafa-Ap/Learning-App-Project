class CartModel {
  String? message;
  Data? data;

  CartModel({this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? user;
  double? grandTotal;
  List<CartItem>? cartItem;

  Data({this.user, this.grandTotal, this.cartItem});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    grandTotal = json['grand_total'];
    if (json['cart_item'] != null) {
      cartItem = <CartItem>[];
      json['cart_item'].forEach((v) {
        cartItem!.add(CartItem.fromJson(v));
      });
    }
  }
}

class CartItem {
  int? courseId;
  String? courseName;
  String? autherName;
  int? rating;
  String? courseimage;
  bool? bestSeller;
  Section? section;
  double? price;

  CartItem(
      {this.courseId,
      this.courseimage,
      this.courseName,
      this.autherName,
      this.rating,
      this.bestSeller,
      this.section,
      this.price});

  CartItem.fromJson(Map<String, dynamic> json) {
    courseimage = json['course_image'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    autherName = json['auther_name'];
    rating = json['rating'];
    bestSeller = json['best_seller'];
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
    price = json['price'];
  }
}

class Section {
  int? id;
  String? name;
  int? amountPerc;

  Section({this.id, this.name, this.amountPerc});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amountPerc = json['amount_perc'];
  }
}
