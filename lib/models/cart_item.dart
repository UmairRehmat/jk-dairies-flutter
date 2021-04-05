import 'package:jkdairies/models/CategoryModel.dart';

class CartItem {
  int productId;
  int price;
  String deliveryTime;
  int quantity;
  int type;
  String startDate;
  String endDate;
  Products item;
  CartItem(
      {this.productId,
      this.price,
      this.deliveryTime,
      this.quantity,
      this.type,
      this.item,
      this.startDate,
      this.endDate});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    price = json['price'];
    deliveryTime = json['delivery_time'];
    quantity = json['quantity'];
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['price'] = this.price;
    data['delivery_time'] = this.deliveryTime;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
