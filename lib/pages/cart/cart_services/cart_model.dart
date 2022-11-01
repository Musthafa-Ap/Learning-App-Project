class CartModel {
  String? message;
  Data? data;

  CartModel({this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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
        cartItem!.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['grand_total'] = this.grandTotal;
    if (this.cartItem != null) {
      data['cart_item'] = this.cartItem!.map((v) => v.toJson()).toList();
    }
    return data;
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
        json['section'] != null ? new Section.fromJson(json['section']) : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_image'] = this.courseimage;
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['auther_name'] = this.autherName;
    data['rating'] = this.rating;
    data['best_seller'] = this.bestSeller;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    data['price'] = this.price;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount_perc'] = this.amountPerc;
    return data;
  }
}
