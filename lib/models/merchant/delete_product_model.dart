class DeleteProductModel {
  bool? success;
  Daata? data;
  String? message;

  DeleteProductModel({this.success, this.data, this.message});

  DeleteProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Daata.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Daata {
  int? id;
  String? productName;
  String? description;
  int? categoryId;
  String? photo;
  String? price;
  String? createdAt;
  String? updatedAt;

  Daata(
      {this.id,
      this.productName,
      this.description,
      this.categoryId,
      this.photo,
      this.price,
      this.createdAt,
      this.updatedAt});

  Daata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['Product_name'];
    description = json['description'];
    categoryId = json['category_id'];
    photo = json['photo'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
